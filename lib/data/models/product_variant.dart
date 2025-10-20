import 'package:isar/isar.dart';

part 'product_variant.g.dart';

@Collection()
class ProductVariant {
  Id id = Isar.autoIncrement;

  @Index()
  late int productId;

  // Simple attributes for common cases
  String? size;
  String? color;

  // SKU override for variant
  String? sku;

  // Price override; if null, use product.salePrice
  double? priceOverride;

  // Stock specific to variant (if you track per-variant)
  int stock = 0;

  bool isActive = true;
  DateTime createdAt = DateTime.now();
}
