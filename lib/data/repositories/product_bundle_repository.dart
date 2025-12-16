import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/product_bundle.dart';
import '../services/database_service.dart';

class ProductBundleRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(ProductBundle bundle) async {
    return upsert(bundle).then((_) => bundle.id);
  }

  Future<void> upsert(ProductBundle bundle) async {
    final companion = ProductBundlesCompanion(
      id: bundle.id == 0 ? const Value.absent() : Value(bundle.id),
      name: Value(bundle.name),
      sku: Value(bundle.sku),
      price: Value(bundle.price),
      itemsJson: Value(bundle.itemsJson),
      isActive: Value(bundle.isActive),
      createdAt: Value(bundle.createdAt),
    );
    final id = await _db
        .into(_db.productBundles)
        .insert(companion, mode: InsertMode.insertOrReplace);
    bundle.id = id;
  }

  Future<ProductBundle?> getById(int id) async {
    final row = await (_db.select(
      _db.productBundles,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<ProductBundle>> getAll({int limit = 200}) async {
    final rows =
        await (_db.select(_db.productBundles)
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ])
              ..limit(limit))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<bool> delete(int id) async {
    final deleted = await (_db.delete(
      _db.productBundles,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  ProductBundle _toModel(ProductBundleRow row) {
    return ProductBundle()
      ..id = row.id
      ..name = row.name
      ..sku = row.sku
      ..price = row.price
      ..itemsJson = row.itemsJson
      ..isActive = row.isActive
      ..createdAt = row.createdAt;
  }
}
