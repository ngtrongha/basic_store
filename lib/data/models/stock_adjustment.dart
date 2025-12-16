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

class StockAdjustment {
  int id = 0;

  int productId = 0;
  int delta = 0; // positive for increase, negative for decrease
  String reason = '';
  String notes = '';
  DateTime createdAt = DateTime.now();
  String? batchNumber;
  DateTime? expiryDate;
}
