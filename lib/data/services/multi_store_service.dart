import '../models/store.dart';
import '../models/stock_transfer.dart';
import '../models/product_price.dart';
import '../repositories/store_repository.dart';
import '../repositories/stock_transfer_repository.dart';
import '../repositories/product_price_repository.dart';
import '../repositories/product_repository.dart';

class MultiStoreService {
  final _storeRepo = StoreRepository();
  final _transferRepo = StockTransferRepository();
  final _priceRepo = ProductPriceRepository();
  final _productRepo = ProductRepository();

  // Store management
  Future<int> createStore(
    String name,
    String address, {
    String? phone,
    String? email,
  }) async {
    final store = Store()
      ..name = name
      ..address = address
      ..phone = phone
      ..email = email
      ..isActive = true
      ..createdAt = DateTime.now();

    return _storeRepo.create(store);
  }

  Future<List<Store>> getActiveStores() async {
    return _storeRepo.getActiveStores();
  }

  // Stock transfers
  Future<int> createStockTransfer({
    required int fromStoreId,
    required int toStoreId,
    required int productId,
    required int quantity,
    String? notes,
  }) async {
    final transfer = StockTransfer()
      ..fromStoreId = fromStoreId
      ..toStoreId = toStoreId
      ..productId = productId
      ..quantity = quantity
      ..status = 'pending'
      ..notes = notes
      ..createdAt = DateTime.now();

    return _transferRepo.create(transfer);
  }

  Future<void> completeStockTransfer(int transferId) async {
    final transfer = await _transferRepo.getById(transferId);
    if (transfer == null) return;

    // Update transfer status
    transfer.status = 'completed';
    transfer.completedAt = DateTime.now();
    await _transferRepo.update(transfer);

    // Update stock levels
    await _productRepo.updateStock(
      productId: transfer.productId,
      delta: -transfer.quantity,
    );
  }

  Future<List<StockTransfer>> getPendingTransfers() async {
    return _transferRepo.getByStatus('pending');
  }

  // Per-store pricing
  Future<void> setProductPrice({
    required int productId,
    required int storeId,
    required double price,
    DateTime? validFrom,
    DateTime? validTo,
  }) async {
    final productPrice = ProductPrice()
      ..productId = productId
      ..storeId = storeId
      ..price = price
      ..createdAt = DateTime.now()
      ..validFrom = validFrom ?? DateTime.now()
      ..validTo = validTo;

    await _priceRepo.create(productPrice);
  }

  Future<double> getProductPrice(int productId, int storeId) async {
    final price = await _priceRepo.getCurrentPrice(productId, storeId);
    if (price != null) return price.price;

    // Fallback to default product price
    final product = await _productRepo.getById(productId);
    return product?.salePrice ?? 0.0;
  }

  Future<Map<String, dynamic>> getStoreSummary(int storeId) async {
    final store = await _storeRepo.getById(storeId);
    if (store == null) return {};

    final transfers = await _transferRepo.getByStore(storeId);
    final pendingTransfers = transfers
        .where((t) => t.status == 'pending')
        .length;
    final completedTransfers = transfers
        .where((t) => t.status == 'completed')
        .length;

    return {
      'store': store,
      'pendingTransfers': pendingTransfers,
      'completedTransfers': completedTransfers,
      'totalTransfers': transfers.length,
    };
  }

  // Public methods for UI access
  Future<List<StockTransfer>> getStockTransfers({int? storeId}) async {
    if (storeId != null) {
      return _transferRepo.getByStore(storeId);
    } else {
      return _transferRepo.getAll();
    }
  }
}
