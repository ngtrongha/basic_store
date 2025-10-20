import 'package:isar/isar.dart';

part 'purchase_order.g.dart';

@Collection()
class PurchaseOrder {
  Id id = Isar.autoIncrement;

  @Index()
  late int supplierId;

  late DateTime createdAt;
  String status = 'open'; // open, received, cancelled

  late List<PurchaseOrderItem> items;
}

@embedded
class PurchaseOrderItem {
  late int productId;
  late int quantity;
  late double unitCost;
}
