import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/product_variant.dart';
import '../services/database_service.dart';

class ProductVariantRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(ProductVariant variant) async {
    return upsert(variant).then((_) => variant.id);
  }

  Future<void> upsert(ProductVariant variant) async {
    final companion = ProductVariantsCompanion(
      id: variant.id == 0 ? const Value.absent() : Value(variant.id),
      productId: Value(variant.productId),
      size: Value(variant.size),
      color: Value(variant.color),
      sku: Value(variant.sku),
      priceOverride: Value(variant.priceOverride),
      stock: Value(variant.stock),
      isActive: Value(variant.isActive),
      createdAt: Value(variant.createdAt),
    );
    final id = await _db
        .into(_db.productVariants)
        .insert(companion, mode: InsertMode.insertOrReplace);
    variant.id = id;
  }

  Future<ProductVariant?> getById(int id) async {
    final row = await (_db.select(
      _db.productVariants,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<ProductVariant>> getByProduct(int productId) async {
    final rows =
        await (_db.select(_db.productVariants)
              ..where((t) => t.productId.equals(productId))
              ..orderBy([(t) => OrderingTerm(expression: t.id)]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<List<ProductVariant>> getActiveByProduct(int productId) async {
    final rows =
        await (_db.select(_db.productVariants)
              ..where(
                (t) => t.productId.equals(productId) & t.isActive.equals(true),
              )
              ..orderBy([(t) => OrderingTerm(expression: t.id)]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<bool> delete(int id) async {
    final deleted = await (_db.delete(
      _db.productVariants,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  ProductVariant _toModel(ProductVariantRow row) {
    return ProductVariant()
      ..id = row.id
      ..productId = row.productId
      ..size = row.size
      ..color = row.color
      ..sku = row.sku
      ..priceOverride = row.priceOverride
      ..stock = row.stock
      ..isActive = row.isActive
      ..createdAt = row.createdAt;
  }
}
