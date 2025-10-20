import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../repositories/product_repository.dart';
import '../repositories/order_repository.dart';
import '../repositories/customer_repository.dart';
import '../repositories/supplier_repository.dart';
import '../repositories/payment_repository.dart';
import '../repositories/return_repository.dart';
import '../repositories/stock_adjustment_repository.dart';
import '../repositories/purchase_order_repository.dart';
import '../repositories/goods_receipt_repository.dart';
import '../repositories/store_repository.dart';
import '../repositories/stock_transfer_repository.dart';
import '../repositories/audit_log_repository.dart';

class DataExportService {
  final _productRepo = ProductRepository();
  final _orderRepo = OrderRepository();
  final _customerRepo = CustomerRepository();
  final _supplierRepo = SupplierRepository();
  final _paymentRepo = PaymentRepository();
  final _returnRepo = ReturnRepository();
  final _adjustmentRepo = StockAdjustmentRepository();
  final _purchaseOrderRepo = PurchaseOrderRepository();
  final _grnRepo = GoodsReceiptRepository();
  final _storeRepo = StoreRepository();
  final _transferRepo = StockTransferRepository();
  final _auditRepo = AuditLogRepository();

  // Export all data to JSON
  Future<void> exportAllDataToJson() async {
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final fileName = 'basic_store_export_$timestamp.json';

    final data = await _getAllData();
    final jsonString = const JsonEncoder.withIndent('  ').convert(data);

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsString(jsonString);

    await Share.shareXFiles([
      XFile(file.path),
    ], text: 'Basic Store Data Export');
  }

  // Export specific data types
  Future<void> exportProductsToCsv() async {
    final products = await _productRepo.getAll(limit: 10000);
    final csv = _generateProductCsv(products);
    await _shareCsvFile(csv, 'products');
  }

  Future<void> exportOrdersToCsv({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final orders = await _orderRepo.getByDateRange(
      startDate ?? DateTime.now().subtract(const Duration(days: 30)),
      endDate ?? DateTime.now(),
    );
    final csv = _generateOrderCsv(orders);
    await _shareCsvFile(csv, 'orders');
  }

  Future<void> exportCustomersToCsv() async {
    final customers = await _customerRepo.getAll(limit: 10000);
    final csv = _generateCustomerCsv(customers);
    await _shareCsvFile(csv, 'customers');
  }

  Future<void> exportInventoryToCsv() async {
    final products = await _productRepo.getAll(limit: 10000);
    final adjustments = await _adjustmentRepo.getAll(limit: 10000);
    final csv = _generateInventoryCsv(products, adjustments);
    await _shareCsvFile(csv, 'inventory');
  }

  Future<void> exportSuppliersToCsv() async {
    final suppliers = await _supplierRepo.getAll(limit: 10000);
    final csv = _generateSupplierCsv(suppliers);
    await _shareCsvFile(csv, 'suppliers');
  }

  Future<void> exportPaymentsToCsv({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final payments = await _paymentRepo.getByDateRange(
      startDate ?? DateTime.now().subtract(const Duration(days: 30)),
      endDate ?? DateTime.now(),
    );
    final csv = _generatePaymentCsv(payments);
    await _shareCsvFile(csv, 'payments');
  }

  Future<void> exportAuditLogToCsv() async {
    final logs = await _auditRepo.list(limit: 10000);
    final csv = _generateAuditLogCsv(logs);
    await _shareCsvFile(csv, 'audit_log');
  }

  // Get all data for JSON export
  Future<Map<String, dynamic>> _getAllData() async {
    return {
      'exportDate': DateTime.now().toIso8601String(),
      'version': '1.0',
      'data': {
        'products': (await _productRepo.getAll(
          limit: 10000,
        )).map((p) => _productToMap(p)).toList(),
        'orders': (await _orderRepo.getAll(
          limit: 10000,
        )).map((o) => _orderToMap(o)).toList(),
        'customers': (await _customerRepo.getAll(
          limit: 10000,
        )).map((c) => _customerToMap(c)).toList(),
        'suppliers': (await _supplierRepo.getAll(
          limit: 10000,
        )).map((s) => _supplierToMap(s)).toList(),
        'payments': (await _paymentRepo.getAll(
          limit: 10000,
        )).map((p) => _paymentToMap(p)).toList(),
        'returns': (await _returnRepo.getAll(
          limit: 10000,
        )).map((r) => _returnToMap(r)).toList(),
        'stockAdjustments': (await _adjustmentRepo.getAll(
          limit: 10000,
        )).map((a) => _adjustmentToMap(a)).toList(),
        'purchaseOrders': (await _purchaseOrderRepo.getAll(
          limit: 10000,
        )).map((po) => _purchaseOrderToMap(po)).toList(),
        'goodsReceipts': (await _grnRepo.getAll(
          limit: 10000,
        )).map((gr) => _goodsReceiptToMap(gr)).toList(),
        'stores': (await _storeRepo.getAll(
          limit: 10000,
        )).map((s) => _storeToMap(s)).toList(),
        'stockTransfers': (await _transferRepo.getAll(
          limit: 10000,
        )).map((t) => _stockTransferToMap(t)).toList(),
        'auditLogs': (await _auditRepo.list(
          limit: 10000,
        )).map((l) => _auditLogToMap(l)).toList(),
      },
    };
  }

  // CSV Generation methods
  String _generateProductCsv(List<dynamic> products) {
    final buffer = StringBuffer();
    buffer.writeln(
      'ID,Tên,SKU,Giá nhập,Giá bán,Tồn kho,Ngưỡng tồn kho thấp,Danh mục,Mô tả,Mã vạch,Trạng thái',
    );

    for (final product in products) {
      buffer.writeln(
        [
          product.id,
          _escapeCsv(product.name),
          _escapeCsv(product.sku),
          product.costPrice,
          product.salePrice,
          product.stock,
          product.lowStockThreshold,
          _escapeCsv(product.category ?? ''),
          _escapeCsv(product.description ?? ''),
          _escapeCsv(product.barcode ?? ''),
          product.isActive ? 'Hoạt động' : 'Không hoạt động',
        ].join(','),
      );
    }

    return buffer.toString();
  }

  String _generateOrderCsv(List<dynamic> orders) {
    final buffer = StringBuffer();
    buffer.writeln(
      'ID,Ngày tạo,Khách hàng ID,Tổng tiền,Điểm tích lũy,Trạng thái',
    );

    for (final order in orders) {
      buffer.writeln(
        [
          order.id,
          DateFormat('yyyy-MM-dd HH:mm:ss').format(order.createdAt),
          order.customerId ?? '',
          order.totalAmount,
          order.pointsDelta ?? 0,
          'Hoàn thành',
        ].join(','),
      );
    }

    return buffer.toString();
  }

  String _generateCustomerCsv(List<dynamic> customers) {
    final buffer = StringBuffer();
    buffer.writeln('ID,Tên,Số điện thoại,Email,Địa chỉ,Điểm tích lũy,Ngày tạo');

    for (final customer in customers) {
      buffer.writeln(
        [
          customer.id,
          _escapeCsv(customer.name),
          _escapeCsv(customer.phone ?? ''),
          _escapeCsv(customer.email ?? ''),
          _escapeCsv(customer.address ?? ''),
          customer.points,
          DateFormat('yyyy-MM-dd HH:mm:ss').format(customer.createdAt),
        ].join(','),
      );
    }

    return buffer.toString();
  }

  String _generateInventoryCsv(
    List<dynamic> products,
    List<dynamic> adjustments,
  ) {
    final buffer = StringBuffer();
    buffer.writeln(
      'Loại,ID,Tên,SKU,Số lượng thay đổi,Lý do,Ghi chú,Ngày thực hiện',
    );

    // Add current stock
    for (final product in products) {
      buffer.writeln(
        [
          'Tồn kho hiện tại',
          product.id,
          _escapeCsv(product.name),
          _escapeCsv(product.sku),
          product.stock,
          'Tồn kho hiện tại',
          '',
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        ].join(','),
      );
    }

    // Add adjustments
    for (final adjustment in adjustments) {
      buffer.writeln(
        [
          'Điều chỉnh',
          adjustment.productId,
          '',
          '',
          adjustment.delta,
          _escapeCsv(adjustment.reason),
          _escapeCsv(adjustment.notes ?? ''),
          DateFormat('yyyy-MM-dd HH:mm:ss').format(adjustment.createdAt),
        ].join(','),
      );
    }

    return buffer.toString();
  }

  String _generateSupplierCsv(List<dynamic> suppliers) {
    final buffer = StringBuffer();
    buffer.writeln('ID,Tên,Liên hệ,Địa chỉ,Số điện thoại,Email,Trạng thái');

    for (final supplier in suppliers) {
      buffer.writeln(
        [
          supplier.id,
          _escapeCsv(supplier.name),
          _escapeCsv(supplier.contact ?? ''),
          _escapeCsv(supplier.address ?? ''),
          _escapeCsv(supplier.phone ?? ''),
          _escapeCsv(supplier.email ?? ''),
          supplier.isActive ? 'Hoạt động' : 'Không hoạt động',
        ].join(','),
      );
    }

    return buffer.toString();
  }

  String _generatePaymentCsv(List<dynamic> payments) {
    final buffer = StringBuffer();
    buffer.writeln('ID,Đơn hàng ID,Phương thức,Số tiền,Ngày thanh toán');

    for (final payment in payments) {
      buffer.writeln(
        [
          payment.id,
          payment.orderId,
          _escapeCsv(payment.method),
          payment.amount,
          DateFormat('yyyy-MM-dd HH:mm:ss').format(payment.createdAt),
        ].join(','),
      );
    }

    return buffer.toString();
  }

  String _generateAuditLogCsv(List<dynamic> logs) {
    final buffer = StringBuffer();
    buffer.writeln('ID,User ID,Hành động,Chi tiết,Ngày thực hiện');

    for (final log in logs) {
      buffer.writeln(
        [
          log.id,
          log.userId ?? '',
          _escapeCsv(log.action),
          _escapeCsv(log.details ?? ''),
          DateFormat('yyyy-MM-dd HH:mm:ss').format(log.createdAt),
        ].join(','),
      );
    }

    return buffer.toString();
  }

  // Helper methods
  Future<void> _shareCsvFile(String csvContent, String dataType) async {
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final fileName = '${dataType}_export_$timestamp.csv';

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsString(csvContent);

    await Share.shareXFiles([
      XFile(file.path),
    ], text: 'Basic Store $dataType Export');
  }

  String _escapeCsv(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }

  // Object to Map conversion methods
  Map<String, dynamic> _productToMap(dynamic product) => {
    'id': product.id,
    'name': product.name,
    'sku': product.sku,
    'costPrice': product.costPrice,
    'salePrice': product.salePrice,
    'stock': product.stock,
    'lowStockThreshold': product.lowStockThreshold,
    'category': product.category,
    'description': product.description,
    'barcode': product.barcode,
    'isActive': product.isActive,
  };

  Map<String, dynamic> _orderToMap(dynamic order) => {
    'id': order.id,
    'createdAt': order.createdAt.toIso8601String(),
    'customerId': order.customerId,
    'totalAmount': order.totalAmount,
    'pointsDelta': order.pointsDelta,
    'change': order.change,
    'items': order.items
        .map(
          (item) => {
            'productId': item.productId,
            'quantity': item.quantity,
            'unitPrice': item.unitPrice,
            'totalPrice': item.totalPrice,
          },
        )
        .toList(),
  };

  Map<String, dynamic> _customerToMap(dynamic customer) => {
    'id': customer.id,
    'name': customer.name,
    'phone': customer.phone,
    'email': customer.email,
    'address': customer.address,
    'points': customer.points,
    'createdAt': customer.createdAt.toIso8601String(),
  };

  Map<String, dynamic> _supplierToMap(dynamic supplier) => {
    'id': supplier.id,
    'name': supplier.name,
    'contact': supplier.contact,
    'address': supplier.address,
    'phone': supplier.phone,
    'email': supplier.email,
    'isActive': supplier.isActive,
  };

  Map<String, dynamic> _paymentToMap(dynamic payment) => {
    'id': payment.id,
    'orderId': payment.orderId,
    'method': payment.method,
    'amount': payment.amount,
    'createdAt': payment.createdAt.toIso8601String(),
  };

  Map<String, dynamic> _returnToMap(dynamic return_) => {
    'id': return_.id,
    'orderId': return_.orderId,
    'customerId': return_.customerId,
    'totalAmount': return_.totalAmount,
    'reason': return_.reason.toString(),
    'notes': return_.notes,
    'createdAt': return_.createdAt.toIso8601String(),
    'items': return_.items
        .map(
          (item) => {
            'productId': item.productId,
            'quantity': item.quantity,
            'unitPrice': item.unitPrice,
            'totalPrice': item.totalPrice,
          },
        )
        .toList(),
  };

  Map<String, dynamic> _adjustmentToMap(dynamic adjustment) => {
    'id': adjustment.id,
    'productId': adjustment.productId,
    'delta': adjustment.delta,
    'reason': adjustment.reason,
    'notes': adjustment.notes,
    'batchNumber': adjustment.batchNumber,
    'expiryDate': adjustment.expiryDate?.toIso8601String(),
    'createdAt': adjustment.createdAt.toIso8601String(),
  };

  Map<String, dynamic> _purchaseOrderToMap(dynamic po) => {
    'id': po.id,
    'supplierId': po.supplierId,
    'orderDate': po.orderDate.toIso8601String(),
    'expectedDelivery': po.expectedDelivery?.toIso8601String(),
    'status': po.status,
    'totalAmount': po.totalAmount,
    'notes': po.notes,
    'items': po.items
        .map(
          (item) => {
            'productId': item.productId,
            'quantity': item.quantity,
            'unitPrice': item.unitPrice,
            'totalPrice': item.totalPrice,
          },
        )
        .toList(),
  };

  Map<String, dynamic> _goodsReceiptToMap(dynamic gr) => {
    'id': gr.id,
    'purchaseOrderId': gr.purchaseOrderId,
    'receivedDate': gr.receivedDate.toIso8601String(),
    'receivedBy': gr.receivedBy,
    'notes': gr.notes,
    'items': gr.items
        .map(
          (item) => {
            'productId': item.productId,
            'quantity': item.quantity,
            'unitPrice': item.unitPrice,
            'totalPrice': item.totalPrice,
          },
        )
        .toList(),
  };

  Map<String, dynamic> _storeToMap(dynamic store) => {
    'id': store.id,
    'name': store.name,
    'address': store.address,
    'phone': store.phone,
    'email': store.email,
    'isActive': store.isActive,
    'createdAt': store.createdAt.toIso8601String(),
  };

  Map<String, dynamic> _stockTransferToMap(dynamic transfer) => {
    'id': transfer.id,
    'fromStoreId': transfer.fromStoreId,
    'toStoreId': transfer.toStoreId,
    'productId': transfer.productId,
    'quantity': transfer.quantity,
    'status': transfer.status,
    'notes': transfer.notes,
    'createdAt': transfer.createdAt.toIso8601String(),
    'completedAt': transfer.completedAt?.toIso8601String(),
  };

  Map<String, dynamic> _auditLogToMap(dynamic log) => {
    'id': log.id,
    'userId': log.userId,
    'action': log.action,
    'details': log.details,
    'createdAt': log.createdAt.toIso8601String(),
  };
}
