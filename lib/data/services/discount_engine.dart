import '../models/order.dart';
import '../models/promotion.dart';

class DiscountResult {
  final double itemDiscountTotal;
  final double cartDiscount;
  final double grandTotal;
  const DiscountResult({
    required this.itemDiscountTotal,
    required this.cartDiscount,
    required this.grandTotal,
  });
}

class DiscountEngine {
  const DiscountEngine();

  DiscountResult apply({
    required List<OrderItem> items,
    required double subtotal,
    Promotion? coupon,
  }) {
    double itemDiscount = 0;
    // In a real engine, fetch applicable item-level promotions here.
    // For now, only coupon-level cart discount is applied.
    double cartDiscount = 0;
    if (coupon != null && coupon.isActiveNow && coupon.value > 0) {
      if (coupon.type == PromotionType.couponPercent ||
          coupon.type == PromotionType.cartPercent) {
        cartDiscount = subtotal * (coupon.value / 100.0);
      } else if (coupon.type == PromotionType.couponAmount ||
          coupon.type == PromotionType.cartAmount) {
        cartDiscount = coupon.value;
      }
    }

    final grand = (subtotal - itemDiscount - cartDiscount).clamp(
      0,
      double.infinity,
    );
    return DiscountResult(
      itemDiscountTotal: itemDiscount,
      cartDiscount: cartDiscount,
      grandTotal: grand.toDouble(),
    );
  }
}
