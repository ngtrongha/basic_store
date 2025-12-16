enum PromotionType {
  itemPercent,
  itemAmount,
  cartPercent,
  cartAmount,
  couponPercent,
  couponAmount,
}

class Promotion {
  int id = 0;

  String name = '';

  String? couponCode;

  int typeValue = PromotionType.itemPercent.index;

  PromotionType get type => PromotionType.values[typeValue];

  set type(PromotionType value) => typeValue = value.index;

  double value = 0; // percent or amount depending on type

  DateTime? startAt;
  DateTime? endAt;

  bool get isActiveNow {
    final now = DateTime.now();
    if (startAt != null && now.isBefore(startAt!)) return false;
    if (endAt != null && now.isAfter(endAt!)) return false;
    return true;
  }
}
