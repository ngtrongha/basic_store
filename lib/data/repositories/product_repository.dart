import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/product.dart';
import '../services/database_service.dart';

class ProductRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(Product product) async {
    final companion = ProductsCompanion(
      id: product.id == 0 ? const Value.absent() : Value(product.id),
      name: Value(product.name),
      sku: Value(product.sku),
      costPrice: Value(product.costPrice),
      salePrice: Value(product.salePrice),
      stock: Value(product.stock),
      lowStockThreshold: Value(product.lowStockThreshold),
      category: Value(product.category),
      description: Value(product.description),
      barcode: Value(product.barcode),
    );
    final id = await _db
        .into(_db.products)
        .insert(companion, mode: InsertMode.insertOrReplace);
    product.id = id;
    return id;
  }

  Future<Product?> getById(int id) async {
    final row = await (_db.select(
      _db.products,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<Product?> getBySku(String sku) async {
    final row = await (_db.select(
      _db.products,
    )..where((t) => t.sku.equals(sku))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<Product>> getAll({int offset = 0, int limit = 50}) async {
    final query = _db.select(_db.products)
      ..orderBy([(t) => OrderingTerm(expression: t.id)])
      ..limit(limit, offset: offset);
    final rows = await query.get();
    return rows.map(_toModel).toList();
  }

  Future<bool> deleteById(int id) async {
    final deleted = await (_db.delete(
      _db.products,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  Future<void> updateStock({required int productId, required int delta}) async {
    await DatabaseService.instance.runWriteVoid((db) async {
      final row = await (db.select(
        db.products,
      )..where((t) => t.id.equals(productId))).getSingleOrNull();
      if (row == null) return;
      await (db.update(db.products)..where((t) => t.id.equals(productId)))
          .write(ProductsCompanion(stock: Value(row.stock + delta)));
    });
  }

  Product _toModel(ProductRow row) {
    return Product()
      ..id = row.id
      ..name = row.name
      ..sku = row.sku
      ..costPrice = row.costPrice
      ..salePrice = row.salePrice
      ..stock = row.stock
      ..lowStockThreshold = row.lowStockThreshold
      ..category = row.category
      ..description = row.description
      ..barcode = row.barcode;
  }
}
