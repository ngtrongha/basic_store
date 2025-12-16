import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/stock_adjustment.dart';
import '../services/database_service.dart';

class StockAdjustmentRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(StockAdjustment adjustment) async {
    final companion = StockAdjustmentsCompanion(
      id: adjustment.id == 0 ? const Value.absent() : Value(adjustment.id),
      productId: Value(adjustment.productId),
      delta: Value(adjustment.delta),
      reason: Value(adjustment.reason),
      notes: Value(adjustment.notes),
      createdAt: Value(adjustment.createdAt),
      batchNumber: Value(adjustment.batchNumber),
      expiryDate: Value(adjustment.expiryDate),
    );
    final id = await _db
        .into(_db.stockAdjustments)
        .insert(companion, mode: InsertMode.insertOrReplace);
    adjustment.id = id;
    return id;
  }

  Future<StockAdjustment?> getById(int id) async {
    final row = await (_db.select(
      _db.stockAdjustments,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<StockAdjustment>> getAll({int limit = 1000}) async {
    final rows =
        await (_db.select(_db.stockAdjustments)
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

  Future<void> update(StockAdjustment adjustment) async {
    await create(adjustment);
  }

  Future<bool> delete(int id) async {
    final deleted = await (_db.delete(
      _db.stockAdjustments,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  Future<List<StockAdjustment>> getByProductId(int productId) async {
    final rows =
        await (_db.select(_db.stockAdjustments)
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

  Future<List<StockAdjustment>> getExpiringSoon() async {
    final rows =
        await (_db.select(_db.stockAdjustments)
              ..where((t) => t.expiryDate.isNotNull())
              ..orderBy([(t) => OrderingTerm(expression: t.expiryDate)]))
            .get();
    return rows.map(_toModel).toList();
  }

  StockAdjustment _toModel(StockAdjustmentRow row) {
    return StockAdjustment()
      ..id = row.id
      ..productId = row.productId
      ..delta = row.delta
      ..reason = row.reason
      ..notes = row.notes
      ..createdAt = row.createdAt
      ..batchNumber = row.batchNumber
      ..expiryDate = row.expiryDate;
  }
}
