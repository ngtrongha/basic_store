import 'package:isar/isar.dart';

part 'stock_adjustment.g.dart';

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

@Collection()
class StockAdjustment {
  Id id = Isar.autoIncrement;

  late int productId;
  late int delta; // positive for increase, negative for decrease
  late String reason;
  late String notes;
  late DateTime createdAt;
  String? batchNumber;
  DateTime? expiryDate;
}
