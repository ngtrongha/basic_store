import 'package:objectbox/objectbox.dart';


@Entity()
class ProductVariant {
  @Id()
  int id = 0;

  @Index()
  int productId = 0;

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
  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
}
