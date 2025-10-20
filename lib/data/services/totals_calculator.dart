import '../models/order.dart';
import '../models/promotion.dart';
import 'discount_engine.dart';
import 'tax_config_service.dart';

class TotalsBreakdown {
  final double subtotal;
  final double itemDiscountTotal;
  final double cartDiscount;
  final double taxableBase;
  final double vatAmount;
  final double serviceFee;
  final double grandTotal;

  const TotalsBreakdown({
    required this.subtotal,
    required this.itemDiscountTotal,
    required this.cartDiscount,
    required this.taxableBase,
    required this.vatAmount,
    required this.serviceFee,
    required this.grandTotal,
  });
}

class TotalsCalculator {
  const TotalsCalculator();

  Future<TotalsBreakdown> compute({
    required List<OrderItem> items,
    Promotion? coupon,
  }) async {
    final subtotal = _calcSubtotal(items);
    final discountResult = const DiscountEngine().apply(
      items: items,
      subtotal: subtotal,
      coupon: coupon,
    );

    final vatRate = await TaxConfigService.getVatRatePercent();
    final vatInclusive = await TaxConfigService.isVatInclusive();
    final serviceFeePercent = await TaxConfigService.getServiceFeePercent();

    final postDiscount =
        (subtotal -
                discountResult.itemDiscountTotal -
                discountResult.cartDiscount)
            .clamp(0, double.infinity);

    double taxableBase;
    double vatAmount;
    if (vatInclusive) {
      taxableBase = postDiscount / (1 + (vatRate / 100.0));
      vatAmount = postDiscount - taxableBase;
    } else {
      taxableBase = postDiscount.toDouble();
      vatAmount = taxableBase * (vatRate / 100.0);
    }

    final serviceFee = taxableBase * (serviceFeePercent / 100.0);
    final grand = vatInclusive
        ? (postDiscount + serviceFee)
        : (postDiscount + vatAmount + serviceFee);

    return TotalsBreakdown(
      subtotal: subtotal,
      itemDiscountTotal: discountResult.itemDiscountTotal,
      cartDiscount: discountResult.cartDiscount,
      taxableBase: taxableBase,
      vatAmount: vatAmount,
      serviceFee: serviceFee,
      grandTotal: grand,
    );
  }

  double _calcSubtotal(List<OrderItem> items) {
    double sum = 0;
    for (final it in items) {
      sum += it.price * it.quantity;
    }
    return sum;
  }
}
