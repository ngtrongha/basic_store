part of 'pos_bloc.dart';

@freezed
abstract class PosState with _$PosState {
  const factory PosState({
    @Default(<OrderItem>[]) List<OrderItem> cartItems,
    @Default(0.0) double totalAmount,
    String? couponCode,
    Promotion? appliedCoupon,
    @Default(0.0) double subtotal,
    @Default(0.0) double cartDiscount,
    @Default(0.0) double vatAmount,
    @Default(0.0) double serviceFee,
  }) = _PosState;

  factory PosState.initial() => const PosState();
}
