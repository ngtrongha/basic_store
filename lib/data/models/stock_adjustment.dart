import 'package:objectbox/objectbox.dart';


enum AdjustmentReason {
  manual,
  damaged,
  expired,
  theft,
  found,
  transfer,
  returned,
  other,
}

@Entity()
class StockAdjustment {
  @Id()
  int id = 0;

  int productId = 0;
  int delta = 0; // positive for increase, negative for decrease
  String reason = '';
  String notes = '';
  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
  String? batchNumber;
  @Property(type: PropertyType.date)
  DateTime? expiryDate;
}
