import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/goods_receipt.dart';
import '../services/database_service.dart';

class GoodsReceiptRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(GoodsReceipt receipt) async {
    final companion = GoodsReceiptsCompanion(
      id: receipt.id == 0 ? const Value.absent() : Value(receipt.id),
      supplierId: Value(receipt.supplierId),
      purchaseOrderId: Value(receipt.purchaseOrderId),
      receivedAt: Value(receipt.receivedAt),
      itemsJson: Value(receipt.itemsJson),
      notes: Value(receipt.notes),
    );
    final id = await _db
        .into(_db.goodsReceipts)
        .insert(companion, mode: InsertMode.insertOrReplace);
    receipt.id = id;
    return id;
  }

  Future<GoodsReceipt?> getById(int id) async {
    final row = await (_db.select(
      _db.goodsReceipts,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<GoodsReceipt>> getAll({int limit = 1000}) async {
    final rows =
        await (_db.select(_db.goodsReceipts)
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.receivedAt,
                  mode: OrderingMode.desc,
                ),
              ])
              ..limit(limit))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<void> update(GoodsReceipt receipt) async {
    await create(receipt);
  }

  Future<bool> delete(int id) async {
    final deleted = await (_db.delete(
      _db.goodsReceipts,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  GoodsReceipt _toModel(GoodsReceiptRow row) {
    return GoodsReceipt()
      ..id = row.id
      ..supplierId = row.supplierId
      ..purchaseOrderId = row.purchaseOrderId
      ..receivedAt = row.receivedAt
      ..itemsJson = row.itemsJson
      ..notes = row.notes;
  }
}
