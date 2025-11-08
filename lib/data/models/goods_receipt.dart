import 'dart:convert';

import 'package:objectbox/objectbox.dart';


@Entity()
class GoodsReceipt {
  @Id()
  int id = 0;

  @Index()
  int supplierId = 0;

  @Index()
  int? purchaseOrderId;

  @Property(type: PropertyType.date)
  DateTime receivedAt = DateTime.now();

  String itemsJson = '[]';

  @Transient()
  List<GoodsReceiptItem> get items => _itemsCache ??= _decodeItems(itemsJson);

  set items(List<GoodsReceiptItem> value) {
    _itemsCache = value;
    itemsJson = jsonEncode(value.map((e) => e.toJson()).toList());
  }

  @Transient()
  List<GoodsReceiptItem>? _itemsCache;

  String? notes;
}

class GoodsReceiptItem {
  int productId = 0;
  int quantity = 0;
  double unitCost = 0;

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
    'unitCost': unitCost,
  };

  static GoodsReceiptItem fromJson(Map<String, dynamic> json) {
    return GoodsReceiptItem()
      ..productId = json['productId'] as int? ?? 0
      ..quantity = json['quantity'] as int? ?? 0
      ..unitCost = (json['unitCost'] as num?)?.toDouble() ?? 0;
  }
}

List<GoodsReceiptItem> _decodeItems(String value) {
  if (value.isEmpty) return <GoodsReceiptItem>[];
  final decoded = jsonDecode(value);
  if (decoded is! List) return <GoodsReceiptItem>[];
  return decoded
      .map(
        (e) => GoodsReceiptItem.fromJson(Map<String, dynamic>.from(e as Map)),
      )
      .toList();
}
