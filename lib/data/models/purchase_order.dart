import 'dart:convert';

class PurchaseOrder {
  int id = 0;

  int supplierId = 0;

  DateTime createdAt = DateTime.now();
  String status = 'open'; // open, received, cancelled

  String itemsJson = '[]';

  List<PurchaseOrderItem> get items => _itemsCache ??= _decodeItems(itemsJson);

  set items(List<PurchaseOrderItem> value) {
    _itemsCache = value;
    itemsJson = jsonEncode(value.map((e) => e.toJson()).toList());
  }

  List<PurchaseOrderItem>? _itemsCache;
}

class PurchaseOrderItem {
  int productId = 0;
  int quantity = 0;
  double unitCost = 0;

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
    'unitCost': unitCost,
  };

  static PurchaseOrderItem fromJson(Map<String, dynamic> json) {
    return PurchaseOrderItem()
      ..productId = json['productId'] as int? ?? 0
      ..quantity = json['quantity'] as int? ?? 0
      ..unitCost = (json['unitCost'] as num?)?.toDouble() ?? 0;
  }
}

List<PurchaseOrderItem> _decodeItems(String value) {
  if (value.isEmpty) return <PurchaseOrderItem>[];
  final decoded = jsonDecode(value);
  if (decoded is! List) return <PurchaseOrderItem>[];
  return decoded
      .map(
        (e) => PurchaseOrderItem.fromJson(Map<String, dynamic>.from(e as Map)),
      )
      .toList();
}
