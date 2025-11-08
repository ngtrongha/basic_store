import 'package:objectbox/objectbox.dart';


@Entity()
class StockTransfer {
  @Id()
  int id = 0;

  int fromStoreId = 0;
  int toStoreId = 0;
  int productId = 0;
  int quantity = 0;
  String status =
      'pending'; // 'pending', 'in_transit', 'completed', 'cancelled'
  String? notes;
  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
  @Property(type: PropertyType.date)
  DateTime? completedAt;
}
