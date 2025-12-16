import 'dart:convert';

class BundleItem {
  int productId = 0;
  int quantity = 1;

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
  };

  static BundleItem fromJson(Map<String, dynamic> json) {
    return BundleItem()
      ..productId = json['productId'] as int? ?? 0
      ..quantity = json['quantity'] as int? ?? 1;
  }
}

class ProductBundle {
  int id = 0;

  String name = '';
  String? sku;
  double price = 0.0; // bundle price

  String itemsJson = '[]';

  List<BundleItem> get items => _itemsCache ??= _decodeItems(itemsJson);

  set items(List<BundleItem> value) {
    _itemsCache = value;
    final encoded = value.map((e) => e.toJson()).toList();
    itemsJson = jsonEncode(encoded);
  }

  List<BundleItem>? _itemsCache;

  bool isActive = true;
  DateTime createdAt = DateTime.now();
}

List<BundleItem> _decodeItems(String value) {
  if (value.isEmpty) return <BundleItem>[];
  final decoded = jsonDecode(value);
  if (decoded is! List) return <BundleItem>[];
  return decoded
      .map((e) => BundleItem.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList();
}
