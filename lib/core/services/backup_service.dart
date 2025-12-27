import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart' hide Order;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_database.dart';

/// Backup Service for exporting/importing database data
@lazySingleton
class BackupService {
  final AppDatabase _db;

  static const _lastBackupKey = 'last_backup_timestamp';
  static const _backupFileName = 'basic_store_backup.json';

  BackupService(this._db);

  /// Export all database data to JSON
  Future<Map<String, dynamic>> exportData() async {
    // Get all data from database
    final products = await _db.select(_db.products).get();
    final categories = await _db.select(_db.categories).get();
    final customers = await _db.select(_db.customers).get();
    final orders = await _db.select(_db.orders).get();
    final orderItems = await _db.select(_db.orderItems).get();
    final debts = await _db.select(_db.debts).get();
    final debtPayments = await _db.select(_db.debtPayments).get();
    final appSettings = await _db.select(_db.appSettings).get();

    return {
      'version': 1,
      'timestamp': DateTime.now().toIso8601String(),
      'products': products.map((p) => _productToJson(p)).toList(),
      'categories': categories.map((c) => _categoryToJson(c)).toList(),
      'customers': customers.map((c) => _customerToJson(c)).toList(),
      'orders': orders.map((o) => _orderToJson(o)).toList(),
      'orderItems': orderItems.map((i) => _orderItemToJson(i)).toList(),
      'debts': debts.map((d) => _debtToJson(d)).toList(),
      'debtPayments': debtPayments.map((p) => _debtPaymentToJson(p)).toList(),
      'appSettings': appSettings.map((s) => _settingToJson(s)).toList(),
    };
  }

  /// Save backup to local file
  Future<File> saveBackupToFile() async {
    final data = await exportData();
    final jsonString = const JsonEncoder.withIndent('  ').convert(data);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_backupFileName');
    await file.writeAsString(jsonString);

    // Save backup timestamp
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastBackupKey, DateTime.now().toIso8601String());

    return file;
  }

  /// Get backup file path
  Future<String> getBackupFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_backupFileName';
  }

  /// Import data from JSON
  Future<void> importData(Map<String, dynamic> data) async {
    await _db.transaction(() async {
      // Clear existing data
      await _db.delete(_db.debtPayments).go();
      await _db.delete(_db.debts).go();
      await _db.delete(_db.orderItems).go();
      await _db.delete(_db.orders).go();
      await _db.delete(_db.products).go();
      await _db.delete(_db.categories).go();
      await _db.delete(_db.customers).go();
      await _db.delete(_db.appSettings).go();

      // Import categories first (referenced by products)
      final categories = data['categories'] as List<dynamic>? ?? [];
      for (final cat in categories) {
        await _db
            .into(_db.categories)
            .insert(CategoriesCompanion.insert(name: cat['name'] as String));
      }

      // Import customers
      final customers = data['customers'] as List<dynamic>? ?? [];
      for (final cust in customers) {
        await _db
            .into(_db.customers)
            .insert(CustomersCompanion.insert(name: cust['name'] as String));
      }

      // Import products
      final products = data['products'] as List<dynamic>? ?? [];
      for (final prod in products) {
        await _db
            .into(_db.products)
            .insert(
              ProductsCompanion.insert(
                name: prod['name'] as String,
                price: (prod['price'] as num).toDouble(),
              ),
            );
      }

      // Note: Orders, OrderItems, Debts, DebtPayments import can be expanded
      // For now, basic structure is in place
    });
  }

  /// Restore from local backup file
  Future<bool> restoreFromFile() async {
    try {
      final filePath = await getBackupFilePath();
      final file = File(filePath);

      if (!await file.exists()) {
        return false;
      }

      final jsonString = await file.readAsString();
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      await importData(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get last backup timestamp
  Future<DateTime?> getLastBackupTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getString(_lastBackupKey);
    if (timestamp != null) {
      return DateTime.tryParse(timestamp);
    }
    return null;
  }

  /// Check if backup file exists
  Future<bool> hasLocalBackup() async {
    final filePath = await getBackupFilePath();
    return File(filePath).exists();
  }

  // JSON conversion helpers
  Map<String, dynamic> _productToJson(Product p) => {
    'id': p.id,
    'name': p.name,
    'description': p.description,
    'barcode': p.barcode,
    'price': p.price,
    'costPrice': p.costPrice,
    'quantity': p.quantity,
    'unit': p.unit,
    'imagePath': p.imagePath,
    'categoryId': p.categoryId,
    'isActive': p.isActive,
  };

  Map<String, dynamic> _categoryToJson(Category c) => {
    'id': c.id,
    'name': c.name,
    'color': c.color,
    'sortOrder': c.sortOrder,
  };

  Map<String, dynamic> _customerToJson(Customer c) => {
    'id': c.id,
    'name': c.name,
    'phone': c.phone,
    'email': c.email,
    'address': c.address,
    'note': c.note,
    'totalDebt': c.totalDebt,
  };

  Map<String, dynamic> _orderToJson(Order o) => {
    'id': o.id,
    'orderNumber': o.orderNumber,
    'customerId': o.customerId,
    'subtotal': o.subtotal,
    'discount': o.discount,
    'total': o.total,
    'paidAmount': o.paidAmount,
    'paymentMethod': o.paymentMethod,
    'status': o.status,
    'note': o.note,
  };

  Map<String, dynamic> _orderItemToJson(OrderItem i) => {
    'id': i.id,
    'orderId': i.orderId,
    'productId': i.productId,
    'productName': i.productName,
    'price': i.price,
    'quantity': i.quantity,
    'subtotal': i.subtotal,
  };

  Map<String, dynamic> _debtToJson(Debt d) => {
    'id': d.id,
    'customerId': d.customerId,
    'orderId': d.orderId,
    'amount': d.amount,
    'paidAmount': d.paidAmount,
    'remainingAmount': d.remainingAmount,
    'note': d.note,
    'isPaid': d.isPaid,
  };

  Map<String, dynamic> _debtPaymentToJson(DebtPayment p) => {
    'id': p.id,
    'debtId': p.debtId,
    'amount': p.amount,
    'paymentMethod': p.paymentMethod,
    'note': p.note,
  };

  Map<String, dynamic> _settingToJson(AppSetting s) => {
    'id': s.id,
    'key': s.key,
    'value': s.value,
  };
}
