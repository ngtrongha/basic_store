import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/return.dart';
import '../services/database_service.dart';

class ReturnRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(Return return_) async {
    final companion = ReturnsCompanion(
      id: return_.id == 0 ? const Value.absent() : Value(return_.id),
      originalOrderId: Value(return_.originalOrderId),
      createdAt: Value(return_.createdAt),
      reason: Value(return_.reason),
      notes: Value(return_.notes),
      refundAmount: Value(return_.refundAmount),
      itemsJson: Value(return_.itemsJson),
      customerId: Value(return_.customerId),
    );
    final id = await _db
        .into(_db.returns)
        .insert(companion, mode: InsertMode.insertOrReplace);
    return_.id = id;
    return id;
  }

  Future<Return?> getById(int id) async {
    final row = await (_db.select(
      _db.returns,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<Return>> getAll({int limit = 1000}) async {
    final rows =
        await (_db.select(_db.returns)
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

  Future<void> update(Return return_) async {
    await create(return_);
  }

  Future<bool> delete(int id) async {
    final deleted = await (_db.delete(
      _db.returns,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  Future<List<Return>> getByOrderId(int orderId) async {
    final rows =
        await (_db.select(_db.returns)
              ..where((t) => t.originalOrderId.equals(orderId))
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<List<Return>> getByCustomerId(int customerId) async {
    final rows =
        await (_db.select(_db.returns)
              ..where((t) => t.customerId.equals(customerId))
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows.map(_toModel).toList();
  }

  Return _toModel(ReturnRow row) {
    return Return()
      ..id = row.id
      ..originalOrderId = row.originalOrderId
      ..createdAt = row.createdAt
      ..reason = row.reason
      ..notes = row.notes
      ..refundAmount = row.refundAmount
      ..itemsJson = row.itemsJson
      ..customerId = row.customerId;
  }
}
