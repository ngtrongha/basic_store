import 'package:isar/isar.dart';

part 'product.g.dart';

@Collection()
class Product {
  Id id = Isar.autoIncrement;

  late String name;

  @Index(unique: true, caseSensitive: false)
  late String sku;

  late double costPrice;
  late double salePrice;
  late int stock;
  late int lowStockThreshold; // Alert when stock falls below this
  String? category;
  String? description;
  String? barcode;
}
