import '../models/product.dart';
import '../models/stock_adjustment.dart';
import '../repositories/product_repository.dart';
import '../repositories/stock_adjustment_repository.dart';
import '../repositories/audit_log_repository.dart';
import '../models/audit_log.dart';
import 'auth_service.dart';

class InventoryService {
  final _productRepo = ProductRepository();
  final _adjustmentRepo = StockAdjustmentRepository();

  Future<void> adjustStock({
    required int productId,
    required int delta,
    required String reason,
    required String notes,
    String? batchNumber,
    DateTime? expiryDate,
  }) async {
    // Create adjustment record
    final adjustment = StockAdjustment()
      ..productId = productId
      ..delta = delta
      ..reason = reason
      ..notes = notes
      ..createdAt = DateTime.now()
      ..batchNumber = batchNumber
      ..expiryDate = expiryDate;

    await _adjustmentRepo.create(adjustment);

    // Update product stock
    await _productRepo.updateStock(productId: productId, delta: delta);

    // Audit log
    final currentUser = await AuthService().getCurrentUser();
    await AuditLogRepository().create(
      AuditLog()
        ..userId = currentUser?.id
        ..action = 'STOCK_ADJUST'
        ..details = 'productId=$productId delta=$delta reason=$reason',
    );
  }

  Future<List<Product>> getLowStockProducts() async {
    final products = await _productRepo.getAll(limit: 1000);
    return products.where((p) => p.stock <= p.lowStockThreshold).toList();
  }

  Future<List<Product>> getOutOfStockProducts() async {
    final products = await _productRepo.getAll(limit: 1000);
    return products.where((p) => p.stock <= 0).toList();
  }

  Future<List<StockAdjustment>> getRecentAdjustments({int limit = 50}) async {
    return _adjustmentRepo.getAll(limit: limit);
  }

  Future<List<StockAdjustment>> getAdjustmentsForProduct(int productId) async {
    return _adjustmentRepo.getByProductId(productId);
  }

  Future<List<StockAdjustment>> getExpiringItems({int daysAhead = 7}) async {
    return _adjustmentRepo.getExpiringSoon();
  }

  Future<Map<String, dynamic>> getInventorySummary() async {
    final products = await _productRepo.getAll(limit: 1000);
    final lowStock = getLowStockProducts();
    final outOfStock = getOutOfStockProducts();
    final totalValue = products.fold<double>(
      0.0,
      (sum, p) => sum + (p.stock * p.costPrice),
    );

    return {
      'totalProducts': products.length,
      'lowStockCount': (await lowStock).length,
      'outOfStockCount': (await outOfStock).length,
      'totalValue': totalValue,
    };
  }
}
