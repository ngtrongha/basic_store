import 'dart:convert';

class GoodsReceipt {
  int id = 0;

  int supplierId = 0;

  int? purchaseOrderId;

  DateTime receivedAt = DateTime.now();

  String itemsJson = '[]';

  List<GoodsReceiptItem> get items => _itemsCache ??= _decodeItems(itemsJson);

  set items(List<GoodsReceiptItem> value) {
    _itemsCache = value;
    itemsJson = jsonEncode(value.map((e) => e.toJson()).toList());
  }

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
