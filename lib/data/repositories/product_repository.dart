import 'package:isar/isar.dart';

import '../models/product.dart';
import '../services/database_service.dart';

class ProductRepository {
  Isar get _isar => DatabaseService.instance.isar;

  Future<int> create(Product product) async {
    return _isar.writeTxn(() async {
      return await _isar.products.put(product);
    });
  }

  Future<Product?> getById(int id) async {
    return await _isar.products.get(id);
  }

  Future<Product?> getBySku(String sku) async {
    return await _isar.products.filter().skuEqualTo(sku, caseSensitive: false).findFirst();
  }

  Future<List<Product>> getAll({int offset = 0, int limit = 50}) async {
    return await _isar.products.where().offset(offset).limit(limit).findAll();
  }

  Future<bool> deleteById(int id) async {
    return _isar.writeTxn(() async {
      return await _isar.products.delete(id);
    });
  }

  Future<void> updateStock({required int productId, required int delta}) async {
    await _isar.writeTxn(() async {
      final product = await _isar.products.get(productId);
      if (product == null) return;
      product.stock = product.stock + delta;
      await _isar.products.put(product);
    });
  }
}


