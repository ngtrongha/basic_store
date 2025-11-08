import 'package:objectbox/objectbox.dart';


enum PromotionType {
  itemPercent,
  itemAmount,
  cartPercent,
  cartAmount,
  couponPercent,
  couponAmount,
}

@Entity()
class Promotion {
  @Id()
  int id = 0;

  @Index()
  String name = '';

  @Index()
  String? couponCode;

  @Property(type: PropertyType.byte)
  int typeValue = PromotionType.itemPercent.index;

  @Transient()
  PromotionType get type => PromotionType.values[typeValue];

  set type(PromotionType value) => typeValue = value.index;

  double value = 0; // percent or amount depending on type

  @Property(type: PropertyType.date)
  DateTime? startAt;
  @Property(type: PropertyType.date)
  DateTime? endAt;

  bool get isActiveNow {
    final now = DateTime.now();
    if (startAt != null && now.isBefore(startAt!)) return false;
    if (endAt != null && now.isAfter(endAt!)) return false;
    return true;
  }
}
