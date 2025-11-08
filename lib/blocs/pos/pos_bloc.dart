import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/order.dart';
import '../../data/models/product.dart';
import '../../data/models/promotion.dart';
import '../../data/services/totals_calculator.dart';

part 'pos_event.dart';
part 'pos_state.dart';
part 'pos_bloc.freezed.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  PosBloc() : super(PosState.initial()) {
    on<_AddProduct>(_onAddProduct);
    on<_RemoveProduct>(_onRemoveProduct);
    on<_UpdateQuantity>(_onUpdateQuantity);
    on<_ClearCart>(_onClearCart);
    on<_ApplyCoupon>(_onApplyCoupon);
    on<_ClearCoupon>(_onClearCoupon);
  }

  Future<void> _recompute({
    required Emitter<PosState> emit,
    required List<OrderItem> items,
    Promotion? coupon,
  }) async {
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

  Future<void> _onAddProduct(_AddProduct event, Emitter<PosState> emit) async {
    final Product product = event.product;
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
    await _recompute(emit: emit, items: items, coupon: state.appliedCoupon);
  }

  Future<void> _onRemoveProduct(
    _RemoveProduct event,
    Emitter<PosState> emit,
  ) async {
    final items = state.cartItems
        .where((e) => e.productId != event.productId)
        .toList();
    await _recompute(emit: emit, items: items, coupon: state.appliedCoupon);
  }

  Future<void> _onUpdateQuantity(
    _UpdateQuantity event,
    Emitter<PosState> emit,
  ) async {
    if (event.quantity <= 0) {
      final items = state.cartItems
          .where((e) => e.productId != event.productId)
          .toList();
      await _recompute(emit: emit, items: items, coupon: state.appliedCoupon);
      return;
    }
    final items = List<OrderItem>.from(state.cartItems);
    final index = items.indexWhere((e) => e.productId == event.productId);
    if (index == -1) return;
    items[index].quantity = event.quantity;
    await _recompute(emit: emit, items: items, coupon: state.appliedCoupon);
  }

  Future<void> _onClearCart(_ClearCart event, Emitter<PosState> emit) async {
    emit(PosState.initial());
  }

  Future<void> _onApplyCoupon(
    _ApplyCoupon event,
    Emitter<PosState> emit,
  ) async {
    await _recompute(emit: emit, items: state.cartItems, coupon: event.coupon);
  }

  Future<void> _onClearCoupon(
    _ClearCoupon event,
    Emitter<PosState> emit,
  ) async {
    await _recompute(emit: emit, items: state.cartItems, coupon: null);
  }
}
