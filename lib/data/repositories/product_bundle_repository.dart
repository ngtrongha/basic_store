import '../../objectbox.g.dart';
import '../models/product_bundle.dart';
import '../services/database_service.dart';

class ProductBundleRepository {
  Box<ProductBundle> get _box =>
      DatabaseService.instance.store.box<ProductBundle>();

  Future<int> create(ProductBundle bundle) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(bundle));
  }

  Future<void> upsert(ProductBundle bundle) async {
    await DatabaseService.instance.runWrite<int>(() => _box.put(bundle));
  }

  Future<ProductBundle?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<ProductBundle>> getAll({int limit = 200}) async {
    final builder = _box.query()
      ..order(ProductBundle_.createdAt, flags: Order.descending);
    final query = builder.build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<bool> delete(int id) async {
    return Future.value(_box.remove(id));
  }
}
