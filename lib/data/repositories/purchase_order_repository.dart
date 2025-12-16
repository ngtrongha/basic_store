import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/purchase_order.dart';
import '../services/database_service.dart';

class PurchaseOrderRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(PurchaseOrder order) async {
    final companion = PurchaseOrdersCompanion(
      id: order.id == 0 ? const Value.absent() : Value(order.id),
      supplierId: Value(order.supplierId),
      createdAt: Value(order.createdAt),
      status: Value(order.status),
      itemsJson: Value(order.itemsJson),
    );
    final id = await _db
        .into(_db.purchaseOrders)
        .insert(companion, mode: InsertMode.insertOrReplace);
    order.id = id;
    return id;
  }

  Future<PurchaseOrder?> getById(int id) async {
    final row = await (_db.select(
      _db.purchaseOrders,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<PurchaseOrder>> getAll({int limit = 1000}) async {
    final rows =
        await (_db.select(_db.purchaseOrders)
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

  Future<void> update(PurchaseOrder order) async {
    await create(order);
  }

  Future<bool> delete(int id) async {
    final deleted = await (_db.delete(
      _db.purchaseOrders,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  PurchaseOrder _toModel(PurchaseOrderRow row) {
    return PurchaseOrder()
      ..id = row.id
      ..supplierId = row.supplierId
      ..createdAt = row.createdAt
      ..status = row.status
      ..itemsJson = row.itemsJson;
  }
}
