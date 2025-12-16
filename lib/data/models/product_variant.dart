class ProductVariant {
  int id = 0;

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
  DateTime createdAt = DateTime.now();
}
