import 'package:isar/isar.dart';

part 'promotion.g.dart';

enum PromotionType {
  itemPercent,
  itemAmount,
  cartPercent,
  cartAmount,
  couponPercent,
  couponAmount,
}

@Collection()
class Promotion {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  late String name;

  @Index(caseSensitive: false)
  String? couponCode;

  @enumerated
  late PromotionType type;
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
