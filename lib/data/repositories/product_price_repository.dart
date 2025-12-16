import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/product_price.dart';
import '../services/database_service.dart';

class ProductPriceRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(ProductPrice price) async {
    final companion = ProductPricesCompanion(
      id: price.id == 0 ? const Value.absent() : Value(price.id),
      productId: Value(price.productId),
      storeId: Value(price.storeId),
      price: Value(price.price),
      createdAt: Value(price.createdAt),
      validFrom: Value(price.validFrom),
      validTo: Value(price.validTo),
    );
    final id = await _db
        .into(_db.productPrices)
        .insert(companion, mode: InsertMode.insertOrReplace);
    price.id = id;
    return id;
  }

  Future<ProductPrice?> getById(int id) async {
    final row = await (_db.select(
      _db.productPrices,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<ProductPrice>> getByProduct(int productId) async {
    final rows =
        await (_db.select(_db.productPrices)
              ..where((t) => t.productId.equals(productId))
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<List<ProductPrice>> getByStore(int storeId) async {
    final rows =
        await (_db.select(_db.productPrices)
              ..where((t) => t.storeId.equals(storeId))
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<ProductPrice?> getCurrentPrice(int productId, int storeId) async {
    final row =
        await (_db.select(_db.productPrices)
              ..where(
                (t) =>
                    t.productId.equals(productId) & t.storeId.equals(storeId),
              )
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ])
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<void> update(ProductPrice price) async {
    await create(price);
  }

  Future<bool> delete(int id) async {
    final deleted = await (_db.delete(
      _db.productPrices,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  ProductPrice _toModel(ProductPriceRow row) {
    return ProductPrice()
      ..id = row.id
      ..productId = row.productId
      ..storeId = row.storeId
      ..price = row.price
      ..createdAt = row.createdAt
      ..validFrom = row.validFrom
      ..validTo = row.validTo;
  }
}
