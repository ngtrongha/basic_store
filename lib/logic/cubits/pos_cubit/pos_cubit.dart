import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/order.dart';
import '../../../data/models/product.dart';
import '../../../data/models/promotion.dart';
import '../../../data/services/totals_calculator.dart';
import 'pos_state.dart';

class PosCubit extends Cubit<PosState> {
  PosCubit() : super(PosState.initial());

  void addProduct(Product product) {
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
    _recompute(items: items, coupon: state.appliedCoupon);
  }

  void removeProduct(int productId) {
    final items = state.cartItems
        .where((e) => e.productId != productId)
        .toList();
    _recompute(items: items, coupon: state.appliedCoupon);
  }

  void updateQuantity(int productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeProduct(productId);
      return;
    }
    final items = List<OrderItem>.from(state.cartItems);
    final index = items.indexWhere((e) => e.productId == productId);
    if (index == -1) return;
    items[index].quantity = newQuantity;
    _recompute(items: items, coupon: state.appliedCoupon);
  }

  void clearCart() {
    emit(PosState.initial());
  }

  void applyCoupon(Promotion coupon) {
    _recompute(items: state.cartItems, coupon: coupon);
  }

  void clearCoupon() {
    _recompute(items: state.cartItems, coupon: null);
  }

  void _recompute({required List<OrderItem> items, Promotion? coupon}) async {
    final breakdown = await const TotalsCalculator().compute(
      items: items,
      coupon: coupon,
    );
    emit(
      state.copyWith(
        cartItems: items,
        appliedCoupon: coupon,
        couponCode: coupon?.couponCode,
        subtotal: breakdown.subtotal,
        cartDiscount: breakdown.cartDiscount,
        vatAmount: breakdown.vatAmount,
        serviceFee: breakdown.serviceFee,
        totalAmount: breakdown.grandTotal,
      ),
    );
  }
}
