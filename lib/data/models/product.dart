class Product {
  int id = 0;

  String name = '';

  String sku = '';

  double costPrice = 0;
  double salePrice = 0;
  int stock = 0;
  int lowStockThreshold = 0; // Alert when stock falls below this
  String? category;
  String? description;
  String? barcode;
}
