import '../../../data/models/order.dart';
import '../../../data/models/promotion.dart';

class PosState {
  final List<OrderItem> cartItems;
  final double totalAmount;
  final String? couponCode;
  final Promotion? appliedCoupon;
  final double subtotal;
  final double cartDiscount;
  final double vatAmount;
  final double serviceFee;

  const PosState({
    required this.cartItems,
    required this.totalAmount,
    this.couponCode,
    this.appliedCoupon,
    this.subtotal = 0,
    this.cartDiscount = 0,
    this.vatAmount = 0,
    this.serviceFee = 0,
  });

  factory PosState.initial() => const PosState(
    cartItems: [],
    totalAmount: 0,
    couponCode: null,
    appliedCoupon: null,
    subtotal: 0,
    cartDiscount: 0,
    vatAmount: 0,
    serviceFee: 0,
  );

  PosState copyWith({
    List<OrderItem>? cartItems,
    double? totalAmount,
    String? couponCode,
    Promotion? appliedCoupon,
    double? subtotal,
    double? cartDiscount,
    double? vatAmount,
    double? serviceFee,
  }) {
    return PosState(
      cartItems: cartItems ?? this.cartItems,
      totalAmount: totalAmount ?? this.totalAmount,
      couponCode: couponCode ?? this.couponCode,
      appliedCoupon: appliedCoupon ?? this.appliedCoupon,
      subtotal: subtotal ?? this.subtotal,
      cartDiscount: cartDiscount ?? this.cartDiscount,
      vatAmount: vatAmount ?? this.vatAmount,
      serviceFee: serviceFee ?? this.serviceFee,
    );
  }
}
