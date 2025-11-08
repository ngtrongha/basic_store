import '../../objectbox.g.dart';
import '../models/product_price.dart';
import '../services/database_service.dart';

class ProductPriceRepository {
  Box<ProductPrice> get _box =>
      DatabaseService.instance.store.box<ProductPrice>();

  Future<int> create(ProductPrice price) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(price));
  }

  Future<ProductPrice?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<ProductPrice>> getByProduct(int productId) async {
    final builder = _box.query(ProductPrice_.productId.equals(productId));
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<List<ProductPrice>> getByStore(int storeId) async {
    final builder = _box.query(ProductPrice_.storeId.equals(storeId));
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<ProductPrice?> getCurrentPrice(int productId, int storeId) async {
    final condition =
        ProductPrice_.productId.equals(productId) &
        ProductPrice_.storeId.equals(storeId);
    final builder = _box.query(condition)
      ..order(ProductPrice_.createdAt, flags: Order.descending);
    final query = builder.build();
    try {
      return query.findFirst();
    } finally {
      query.close();
    }
  }

  Future<void> update(ProductPrice price) async {
    await DatabaseService.instance.runWrite<int>(() => _box.put(price));
  }

  Future<bool> delete(int id) async {
    return Future.value(_box.remove(id));
  }
}
