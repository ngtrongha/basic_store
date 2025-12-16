import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/stock_transfer.dart';
import '../services/database_service.dart';

class StockTransferRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(StockTransfer transfer) async {
    final companion = StockTransfersCompanion(
      id: transfer.id == 0 ? const Value.absent() : Value(transfer.id),
      fromStoreId: Value(transfer.fromStoreId),
      toStoreId: Value(transfer.toStoreId),
      productId: Value(transfer.productId),
      quantity: Value(transfer.quantity),
      status: Value(transfer.status),
      notes: Value(transfer.notes),
      createdAt: Value(transfer.createdAt),
      completedAt: Value(transfer.completedAt),
    );
    final id = await _db
        .into(_db.stockTransfers)
        .insert(companion, mode: InsertMode.insertOrReplace);
    transfer.id = id;
    return id;
  }

  Future<StockTransfer?> getById(int id) async {
    final row = await (_db.select(
      _db.stockTransfers,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<StockTransfer>> getAll({int limit = 100}) async {
    final rows =
        await (_db.select(_db.stockTransfers)
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

  Future<List<StockTransfer>> getByStore(int storeId) async {
    final rows =
        await (_db.select(_db.stockTransfers)
              ..where((t) => t.fromStoreId.equals(storeId))
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<List<StockTransfer>> getByStatus(String status) async {
    final rows =
        await (_db.select(_db.stockTransfers)
              ..where((t) => t.status.equals(status))
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<void> update(StockTransfer transfer) async {
    await create(transfer);
  }

  Future<bool> delete(int id) async {
    final deleted = await (_db.delete(
      _db.stockTransfers,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  StockTransfer _toModel(StockTransferRow row) {
    return StockTransfer()
      ..id = row.id
      ..fromStoreId = row.fromStoreId
      ..toStoreId = row.toStoreId
      ..productId = row.productId
      ..quantity = row.quantity
      ..status = row.status
      ..notes = row.notes
      ..createdAt = row.createdAt
      ..completedAt = row.completedAt;
  }
}
