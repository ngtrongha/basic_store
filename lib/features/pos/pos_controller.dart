import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/customer.dart';
import '../../data/models/order.dart';
import '../../data/models/product.dart';
import '../../data/models/promotion.dart';
import '../../data/repositories/product_unit_repository.dart';
import '../../data/services/totals_calculator.dart';
import '../../di/injection.dart';
import 'pos_state.dart';

final posControllerProvider = NotifierProvider<PosController, PosState>(
  PosController.new,
);

class PosController extends Notifier<PosState> {
  ProductUnitRepository get _productUnitRepo => getIt<ProductUnitRepository>();

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
    final resolved = await _productUnitRepo.getDefaultByProductWithUnit(
      product.id,
    );
    final unitId = resolved?.productUnit.unitId;
    final unitFactor = resolved?.productUnit.factor ?? 1.0;
    final unitName = resolved?.unit.name;
    final unitPrice =
        resolved?.productUnit.priceOverride ?? (product.salePrice * unitFactor);

    final items = List<OrderItem>.from(state.cartItems);
    final index = items.indexWhere(
      (e) => e.productId == product.id && e.unitId == unitId,
    );
    if (index == -1) {
      final item = OrderItem()
        ..productId = product.id
        ..quantity = 1
        ..price = unitPrice
        ..unitId = unitId
        ..unitFactor = unitFactor
        ..unitName = unitName;
      items.add(item);
    } else {
      items[index].quantity = items[index].quantity + 1;
    }

    await _recompute(items: items, coupon: state.appliedCoupon);
  }

  Future<void> addProductWithQuantity(
    Product product,
    int qtyDelta, {
    int? unitId,
    double? unitFactor,
    String? unitName,
    double? unitPrice,
  }) async {
    if (qtyDelta <= 0) return;

    ProductUnitWithUnit? resolved;
    if (unitId == null) {
      resolved = await _productUnitRepo.getDefaultByProductWithUnit(product.id);
      unitId = resolved?.productUnit.unitId;
      unitFactor = resolved?.productUnit.factor;
      unitName = resolved?.unit.name;
      unitPrice =
          resolved?.productUnit.priceOverride ??
          (product.salePrice * (unitFactor ?? 1.0));
    }

    final factor = unitFactor ?? 1.0;
    final price = unitPrice ?? (product.salePrice * factor);

    final items = List<OrderItem>.from(state.cartItems);
    final index = items.indexWhere(
      (e) => e.productId == product.id && e.unitId == unitId,
    );
    if (index == -1) {
      final item = OrderItem()
        ..productId = product.id
        ..quantity = qtyDelta
        ..price = price
        ..unitId = unitId
        ..unitFactor = factor
        ..unitName = unitName;
      items.add(item);
    } else {
      items[index].quantity = items[index].quantity + qtyDelta;
    }

    await _recompute(items: items, coupon: state.appliedCoupon);
  }

  Future<void> removeProduct({required int productId, int? unitId}) async {
    final items = state.cartItems
        .where((e) => !(e.productId == productId && e.unitId == unitId))
        .toList();
    await _recompute(items: items, coupon: state.appliedCoupon);
  }

  Future<void> updateQuantity({
    required int productId,
    int? unitId,
    required int quantity,
  }) async {
    if (quantity <= 0) {
      await removeProduct(productId: productId, unitId: unitId);
      return;
    }

    final items = List<OrderItem>.from(state.cartItems);
    final index = items.indexWhere(
      (e) => e.productId == productId && e.unitId == unitId,
    );
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
