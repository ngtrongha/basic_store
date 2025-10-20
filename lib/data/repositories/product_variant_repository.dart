import 'package:isar/isar.dart';
import '../models/product_variant.dart';
import '../services/database_service.dart';

class ProductVariantRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(ProductVariant variant) async {
    return _isar.writeTxn(() => _isar.productVariants.put(variant));
  }

  Future<void> upsert(ProductVariant variant) async {
    await _isar.writeTxn(() => _isar.productVariants.put(variant));
  }

  Future<ProductVariant?> getById(int id) async {
    return _isar.productVariants.get(id);
  }

  Future<List<ProductVariant>> getByProduct(int productId) async {
    return _isar.productVariants.filter().productIdEqualTo(productId).findAll();
  }

  Future<List<ProductVariant>> getActiveByProduct(int productId) async {
    return _isar.productVariants
        .filter()
        .productIdEqualTo(productId)
        .and()
        .isActiveEqualTo(true)
        .findAll();
  }

  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.productVariants.delete(id));
  }
}
