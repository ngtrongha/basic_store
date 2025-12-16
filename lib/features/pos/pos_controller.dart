import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/customer.dart';
import '../../data/models/order.dart';
import '../../data/models/product.dart';
import '../../data/models/promotion.dart';
import '../../data/services/totals_calculator.dart';
import 'pos_state.dart';

final posControllerProvider = NotifierProvider<PosController, PosState>(
  PosController.new,
);

class PosController extends Notifier<PosState> {
  @override
  PosState build() => PosState.initial();

  void setCustomer(Customer? customer) {
    state = state.copyWith(selectedCustomer: customer);
  }

  Future<void> _recompute({
    required List<OrderItem> items,
    Promotion? coupon,
  }) async {
    final breakdown = await const TotalsCalculator().compute(
      items: items,
      coupon: coupon,
    );

    state = state.copyWith(
      cartItems: items,
      appliedCoupon: coupon,
      couponCode: coupon?.couponCode,
      subtotal: breakdown.subtotal,
      cartDiscount: breakdown.cartDiscount,
      vatAmount: breakdown.vatAmount,
      serviceFee: breakdown.serviceFee,
      totalAmount: breakdown.grandTotal,
    );
  }

  Future<void> addProduct(Product product) async {
    final items = List<OrderItem>.from(state.cartItems);
    final index = items.indexWhere((e) => e.productId == product.id);
    if (index == -1) {
      final item = OrderItem()
        ..productId = product.id
        ..quantity = 1
        ..price = product.salePrice;
      items.add(item);
    } else {
      items[index].quantity = items[index].quantity + 1;
    }

    await _recompute(items: items, coupon: state.appliedCoupon);
  }

  Future<void> addProductWithQuantity(Product product, int qtyDelta) async {
    if (qtyDelta <= 0) return;

    final items = List<OrderItem>.from(state.cartItems);
    final index = items.indexWhere((e) => e.productId == product.id);
    if (index == -1) {
      final item = OrderItem()
        ..productId = product.id
        ..quantity = qtyDelta
        ..price = product.salePrice;
      items.add(item);
    } else {
      items[index].quantity = items[index].quantity + qtyDelta;
    }

    await _recompute(items: items, coupon: state.appliedCoupon);
  }

  Future<void> removeProduct(int productId) async {
    final items = state.cartItems
        .where((e) => e.productId != productId)
        .toList();
    await _recompute(items: items, coupon: state.appliedCoupon);
  }

  Future<void> updateQuantity({
    required int productId,
    required int quantity,
  }) async {
    if (quantity <= 0) {
      await removeProduct(productId);
      return;
    }

    final items = List<OrderItem>.from(state.cartItems);
    final index = items.indexWhere((e) => e.productId == productId);
    if (index == -1) return;

    items[index].quantity = quantity;
    await _recompute(items: items, coupon: state.appliedCoupon);
  }

  void clearCart() {
    state = PosState.initial();
  }

  Future<void> applyCoupon(Promotion coupon) async {
    await _recompute(items: state.cartItems, coupon: coupon);
  }

  Future<void> clearCoupon() async {
    await _recompute(items: state.cartItems, coupon: null);
  }
}
