import 'package:isar/isar.dart';
import '../models/product_bundle.dart';
import '../services/database_service.dart';

class ProductBundleRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(ProductBundle bundle) async {
    return _isar.writeTxn(() => _isar.productBundles.put(bundle));
  }

  Future<void> upsert(ProductBundle bundle) async {
    await _isar.writeTxn(() => _isar.productBundles.put(bundle));
  }

  Future<ProductBundle?> getById(int id) async {
    return _isar.productBundles.get(id);
  }

  Future<List<ProductBundle>> getAll({int limit = 200}) async {
    return _isar.productBundles
        .where()
        .sortByCreatedAtDesc()
        .limit(limit)
        .findAll();
  }

  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.productBundles.delete(id));
  }
}
