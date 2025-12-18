import 'dart:convert';

import 'payment.dart';

class Order {
  int id = 0;

  DateTime createdAt = DateTime.now();
  double totalAmount = 0;
  int? customerId;
  int pointsDelta = 0;

  String itemsJson = '[]';

  List<OrderItem> get items => _itemsCache ??= _decodeItems(itemsJson);

  set items(List<OrderItem> value) {
    _itemsCache = value;
    itemsJson = jsonEncode(value.map((e) => e.toJson()).toList());
  }

  List<OrderItem>? _itemsCache;

  List<Payment> payments = [];

  double change = 0;
}

class OrderItem {
  int productId = 0;
  int quantity = 0;
  double price = 0; // unit price at the time of sale

  /// Optional unit info (for selling in converted units).
  int? unitId;
  double unitFactor = 1.0; // base units per 1 unit
  String? unitName;

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
    'price': price,
    if (unitId != null) 'unitId': unitId,
    if (unitFactor != 1.0) 'unitFactor': unitFactor,
    if (unitName != null) 'unitName': unitName,
  };

  static OrderItem fromJson(Map<String, dynamic> json) {
    return OrderItem()
      ..productId = json['productId'] as int? ?? 0
      ..quantity = json['quantity'] as int? ?? 0
      ..price = (json['price'] as num?)?.toDouble() ?? 0
      ..unitId = (json['unitId'] as num?)?.toInt()
      ..unitFactor = (json['unitFactor'] as num?)?.toDouble() ?? 1.0
      ..unitName = json['unitName'] as String?;
  }
}

List<OrderItem> _decodeItems(String value) {
  if (value.isEmpty) return <OrderItem>[];
  final decoded = jsonDecode(value);
  if (decoded is! List) return <OrderItem>[];
  return decoded
      .map((e) => OrderItem.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList();
}
