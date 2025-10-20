import 'package:isar/isar.dart';

part 'stock_transfer.g.dart';

@Collection()
class StockTransfer {
  Id id = Isar.autoIncrement;

  late int fromStoreId;
  late int toStoreId;
  late int productId;
  late int quantity;
  late String status; // 'pending', 'in_transit', 'completed', 'cancelled'
  String? notes;
  DateTime createdAt = DateTime.now();
  DateTime? completedAt;
}
