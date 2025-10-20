import 'package:isar/isar.dart';
import '../models/product_price.dart';
import '../services/database_service.dart';

class ProductPriceRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(ProductPrice price) async {
    return _isar.writeTxn(() => _isar.productPrices.put(price));
  }

  Future<ProductPrice?> getById(int id) async {
    return _isar.productPrices.get(id);
  }

  Future<List<ProductPrice>> getByProduct(int productId) async {
    return _isar.productPrices.filter().productIdEqualTo(productId).findAll();
  }

  Future<List<ProductPrice>> getByStore(int storeId) async {
    return _isar.productPrices.filter().storeIdEqualTo(storeId).findAll();
  }

  Future<ProductPrice?> getCurrentPrice(int productId, int storeId) async {
    return _isar.productPrices
        .filter()
        .productIdEqualTo(productId)
        .and()
        .storeIdEqualTo(storeId)
        .sortByCreatedAtDesc()
        .findFirst();
  }

  Future<void> update(ProductPrice price) async {
    await _isar.writeTxn(() => _isar.productPrices.put(price));
  }

  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.productPrices.delete(id));
  }
}
