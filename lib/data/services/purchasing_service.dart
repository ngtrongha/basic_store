import '../models/goods_receipt.dart';
import '../repositories/goods_receipt_repository.dart';
import '../repositories/purchase_order_repository.dart';
import '../repositories/product_repository.dart';

class PurchasingService {
  final _grnRepo = GoodsReceiptRepository();
  final _poRepo = PurchaseOrderRepository();
  final _productRepo = ProductRepository();

  Future<int> receive({
    required int supplierId,
    int? purchaseOrderId,
    required List<GoodsReceiptItem> items,
    String? notes,
  }) async {
    // Create GRN
    final grn = GoodsReceipt()
      ..supplierId = supplierId
      ..purchaseOrderId = purchaseOrderId
      ..receivedAt = DateTime.now()
      ..items = items
      ..notes = notes;

    final grnId = await _grnRepo.create(grn);

    // Update stock and weighted-average cost per item
    for (final it in items) {
      final product = await _productRepo.getById(it.productId);
      if (product == null) continue;

      final existingQty = product.stock;
      final existingCost = product.costPrice;
      final newQty = existingQty + it.quantity;
      final newCost = newQty == 0
          ? it.unitCost
          : ((existingQty * existingCost) + (it.quantity * it.unitCost)) /
                newQty;

      // Update product cost and stock in a single write
      product
        ..costPrice = newCost
        ..stock = newQty;
      await _productRepo.create(product);
    }

    // Optionally close PO
    if (purchaseOrderId != null) {
      final po = await _poRepo.getById(purchaseOrderId);
      if (po != null) {
        po.status = 'received';
        await _poRepo.update(po);
      }
    }

    return grnId;
  }
}
