 

part of 'pos_bloc.dart';

@freezed
class PosEvent with _$PosEvent {
  const factory PosEvent.addProduct(Product product) = _AddProduct;
  const factory PosEvent.removeProduct(int productId) = _RemoveProduct;
  const factory PosEvent.updateQuantity({
    required int productId,
    required int quantity,
  }) = _UpdateQuantity;
  const factory PosEvent.clearCart() = _ClearCart;
  const factory PosEvent.applyCoupon(Promotion coupon) = _ApplyCoupon;
  const factory PosEvent.clearCoupon() = _ClearCoupon;
}
