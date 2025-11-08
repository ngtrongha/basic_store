import '../../objectbox.g.dart';
import '../models/product_variant.dart';
import '../services/database_service.dart';

class ProductVariantRepository {
  Box<ProductVariant> get _box =>
      DatabaseService.instance.store.box<ProductVariant>();

  Future<int> create(ProductVariant variant) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(variant));
  }

  Future<void> upsert(ProductVariant variant) async {
    await DatabaseService.instance.runWrite<int>(() => _box.put(variant));
  }

  Future<ProductVariant?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<ProductVariant>> getByProduct(int productId) async {
    final builder = _box.query(ProductVariant_.productId.equals(productId));
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<List<ProductVariant>> getActiveByProduct(int productId) async {
    final condition =
        ProductVariant_.productId.equals(productId) &
        ProductVariant_.isActive.equals(true);
    final builder = _box.query(condition);
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<bool> delete(int id) async {
    return Future.value(_box.remove(id));
  }
}
