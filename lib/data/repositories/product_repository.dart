import '../../objectbox.g.dart';

import '../models/product.dart';
import '../services/database_service.dart';

class ProductRepository {
  Box<Product> get _box => DatabaseService.instance.store.box<Product>();

  Future<int> create(Product product) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(product));
  }

  Future<Product?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<Product?> getBySku(String sku) async {
    final query = _box
        .query(Product_.sku.equals(sku, caseSensitive: false))
        .build();
    try {
      return query.findFirst();
    } finally {
      query.close();
    }
  }

  Future<List<Product>> getAll({int offset = 0, int limit = 50}) async {
    final query = _box.query().build();
    try {
      final results = query.find();
      if (offset >= results.length) return <Product>[];
      return results.skip(offset).take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<bool> deleteById(int id) async {
    return Future.value(_box.remove(id));
  }

  Future<void> updateStock({required int productId, required int delta}) async {
    await DatabaseService.instance.runWriteVoid(() {
      final product = _box.get(productId);
      if (product == null) {
        return;
      }
      product.stock = product.stock + delta;
      _box.put(product);
    });
  }
}
