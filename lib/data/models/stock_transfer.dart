class StockTransfer {
  int id = 0;

  int fromStoreId = 0;
  int toStoreId = 0;
  int productId = 0;
  int quantity = 0;
  String status =
      'pending'; // 'pending', 'in_transit', 'completed', 'cancelled'
  String? notes;
  DateTime createdAt = DateTime.now();
  DateTime? completedAt;
}
