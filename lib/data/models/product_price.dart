class ProductPrice {
  int id = 0;

  int productId = 0;
  int storeId = 0;
  double price = 0;
  DateTime createdAt = DateTime.now();
  DateTime? validFrom;
  DateTime? validTo;
}
