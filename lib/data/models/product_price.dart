import 'package:isar/isar.dart';

part 'product_price.g.dart';

@Collection()
class ProductPrice {
  Id id = Isar.autoIncrement;

  late int productId;
  late int storeId;
  late double price;
  DateTime createdAt = DateTime.now();
  DateTime? validFrom;
  DateTime? validTo;
}
