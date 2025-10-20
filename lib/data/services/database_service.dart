import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/order.dart';
import '../models/product.dart';
import '../models/customer.dart';
import '../models/promotion.dart';
import '../models/payment.dart';
import '../models/return.dart';
import '../models/stock_adjustment.dart';
import '../models/supplier.dart';
import '../models/purchase_order.dart';
import '../models/goods_receipt.dart';
import '../models/user.dart';
import '../models/audit_log.dart';
import '../models/store.dart';
import '../models/stock_transfer.dart';
import '../models/product_price.dart';
import '../models/product_variant.dart';
import '../models/product_bundle.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService instance = DatabaseService._internal();

  Isar? _isar;

  Isar get isar {
    final db = _isar;
    if (db == null) {
      throw StateError('DatabaseService not initialized. Call init() first.');
    }
    return db;
  }

  Future<void> init() async {
    if (_isar != null) return;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      ProductSchema,
      OrderSchema,
      CustomerSchema,
      PromotionSchema,
      PaymentSchema,
      ReturnSchema,
      StockAdjustmentSchema,
      SupplierSchema,
      PurchaseOrderSchema,
      GoodsReceiptSchema,
      AppUserSchema,
      AuditLogSchema,
      StoreSchema,
      StockTransferSchema,
      ProductPriceSchema,
      ProductVariantSchema,
      ProductBundleSchema,
    ], directory: dir.path);
  }

  Future<void> reopen() async {
    final db = _isar;
    if (db != null && !db.isOpen) {
      await db.close();
    }
    _isar = null;
    await init();
  }

  Future<void> seedIfEmpty() async {
    final db = isar;
    // Seed products if empty
    if (await db.products.count() == 0) {
      await db.writeTxn(() async {
        for (int i = 0; i < 10; i++) {
          final p = Product()
            ..name = 'Sản phẩm ${i + 1}'
            ..sku = 'SKU${1000 + i}'
            ..costPrice = (i + 1) * 8000.0
            ..salePrice = (i + 1) * 10000.0
            ..stock = 10 + i
            ..lowStockThreshold = 5
            ..category = 'Danh mục ${(i % 3) + 1}';
          await db.products.put(p);
        }
      });
    }

    // Seed default users if empty
    if (await db.appUsers.count() == 0) {
      await db.writeTxn(() async {
        await db.appUsers.putAll([
          AppUser()
            ..username = 'admin'
            ..password = 'admin'
            ..role = UserRole.admin,
          AppUser()
            ..username = 'manager'
            ..password = 'manager'
            ..role = UserRole.manager,
          AppUser()
            ..username = 'cashier'
            ..password = 'cashier'
            ..role = UserRole.cashier,
        ]);
      });
    }

    // Seed default store if empty
    if (await db.stores.count() == 0) {
      await db.writeTxn(() async {
        await db.stores.put(
          Store()
            ..name = 'Cửa hàng chính'
            ..address = 'Địa chỉ mặc định'
            ..isActive = true
            ..createdAt = DateTime.now(),
        );
      });
    }
  }
}
