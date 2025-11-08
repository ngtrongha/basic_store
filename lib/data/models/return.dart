import 'dart:convert';

import 'package:objectbox/objectbox.dart';


enum ReturnReason { defective, wrongItem, customerChange, duplicate, other }

@Entity()
class Return {
  @Id()
  int id = 0;

  int originalOrderId = 0;
  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
  String reason = '';
  String notes = '';
  double refundAmount = 0;
  String itemsJson = '[]';

  @Transient()
  List<ReturnItem> get items => _itemsCache ??= _decodeItems(itemsJson);

  set items(List<ReturnItem> value) {
    _itemsCache = value;
    itemsJson = jsonEncode(value.map((e) => e.toJson()).toList());
  }

  @Transient()
  List<ReturnItem>? _itemsCache;
  int? customerId;
}

class ReturnItem {
  int productId = 0;
  int quantity = 0; // negative for returns
  double price = 0; // original price
  String reason = '';

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
    'price': price,
    'reason': reason,
  };

  static ReturnItem fromJson(Map<String, dynamic> json) {
    return ReturnItem()
      ..productId = json['productId'] as int? ?? 0
      ..quantity = json['quantity'] as int? ?? 0
      ..price = (json['price'] as num?)?.toDouble() ?? 0
      ..reason = json['reason'] as String? ?? '';
  }
}

List<ReturnItem> _decodeItems(String value) {
  if (value.isEmpty) return <ReturnItem>[];
  final decoded = jsonDecode(value);
  if (decoded is! List) return <ReturnItem>[];
  return decoded
      .map((e) => ReturnItem.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList();
}
