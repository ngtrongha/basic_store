import '../models/return.dart';
import '../repositories/return_repository.dart';
import '../repositories/order_repository.dart';
import '../repositories/product_repository.dart';
import '../repositories/customer_repository.dart';

class ReturnService {
  final _returnRepo = ReturnRepository();
  final _orderRepo = OrderRepository();
  final _productRepo = ProductRepository();
  final _customerRepo = CustomerRepository();

  Future<int> processReturn({
    required int originalOrderId,
    required List<ReturnItem> items,
    required String reason,
    required String notes,
    int? customerId,
  }) async {
    // Get original order
    final originalOrder = await _orderRepo.getById(originalOrderId);
    if (originalOrder == null) {
      throw Exception('Original order not found');
    }

    // Calculate refund amount
    double refundAmount = 0;
    for (final item in items) {
      refundAmount += item.price * item.quantity.abs();
    }

    // Create return record
    final returnOrder = Return()
      ..originalOrderId = originalOrderId
      ..createdAt = DateTime.now()
      ..reason = reason
      ..notes = notes
      ..refundAmount = refundAmount
      ..items = items
      ..customerId = customerId;

    final returnId = await _returnRepo.create(returnOrder);

    // Update stock (add back returned items)
    for (final item in items) {
      final baseQty = (item.quantity.abs() * item.unitFactor).round();
      await _productRepo.updateStock(
        productId: item.productId,
        delta: baseQty, // positive delta to add stock back
      );
    }

    // Deduct loyalty points if customer exists
    if (customerId != null) {
      final pointsToDeduct = refundAmount / 1000; // Same rate as earning
      await _customerRepo.addPoints(customerId, -pointsToDeduct.toInt());
    }

    return returnId;
  }

  Future<List<Return>> getReturnsForOrder(int orderId) async {
    return _returnRepo.getByOrderId(orderId);
  }

  Future<List<Return>> getReturnsForCustomer(int customerId) async {
    return _returnRepo.getByCustomerId(customerId);
  }
}
