class ProductUnit {
  int productId = 0;
  int unitId = 0;

  /// Number of base units per 1 of this unit.
  double factor = 1.0;

  bool isBase = false;
  bool isDefault = false;

  double? priceOverride;
  String? sku;
  String? barcode;

  DateTime createdAt = DateTime.now();
}
