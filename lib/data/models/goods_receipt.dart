import 'package:isar/isar.dart';

part 'goods_receipt.g.dart';

@Collection()
class GoodsReceipt {
  Id id = Isar.autoIncrement;

  @Index()
  late int supplierId;

  @Index()
  int? purchaseOrderId;

  late DateTime receivedAt;
  late List<GoodsReceiptItem> items;
  String? notes;
}

@embedded
class GoodsReceiptItem {
  late int productId;
  late int quantity;
  late double unitCost;
}
