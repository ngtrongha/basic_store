import 'package:isar/isar.dart';

part 'product_bundle.g.dart';

@embedded
class BundleItem {
  late int productId;
  int quantity = 1;
}

@Collection()
class ProductBundle {
  Id id = Isar.autoIncrement;

  late String name;
  String? sku;
  double price = 0.0; // bundle price

  // Items cannot be indexed because this is an embedded list
  List<BundleItem> items = [];

  bool isActive = true;
  DateTime createdAt = DateTime.now();
}
