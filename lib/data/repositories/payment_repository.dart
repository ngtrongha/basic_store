import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/payment.dart';
import '../services/database_service.dart';

class PaymentRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<List<int>> createAll(List<Payment> payments) async {
    return DatabaseService.instance.runWrite<List<int>>((db) async {
      final ids = <int>[];
      for (final p in payments) {
        final companion = PaymentsCompanion(
          id: p.id == 0 ? const Value.absent() : Value(p.id),
          orderId: Value(p.orderId),
          methodValue: Value(p.methodValue),
          value: Value(p.value),
          amount: Value(p.amount),
          createdAt: Value(p.createdAt),
        );
        final id = await db
            .into(db.payments)
            .insert(companion, mode: InsertMode.insertOrReplace);
        p.id = id;
        ids.add(id);
      }
      return ids;
    });
  }

  Future<List<Payment>> getByOrderId(int orderId) async {
    final rows =
        await (_db.select(_db.payments)
              ..where((t) => t.orderId.equals(orderId))
              ..orderBy([(t) => OrderingTerm(expression: t.id)]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<void> deleteByOrderId(int orderId) async {
    await DatabaseService.instance.runWriteVoid((db) async {
      await (db.delete(
        db.payments,
      )..where((t) => t.orderId.equals(orderId))).go();
    });
  }

  Future<List<Payment>> getAll({int limit = 1000}) async {
    final rows =
        await (_db.select(_db.payments)
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

  Future<List<Payment>> getByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final rows =
        await (_db.select(_db.payments)
              ..where((t) => t.createdAt.isBetweenValues(startDate, endDate))
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows.map(_toModel).toList();
  }

  Payment _toModel(PaymentRow row) {
    return Payment()
      ..id = row.id
      ..orderId = row.orderId
      ..methodValue = row.methodValue
      ..value = row.value
      ..amount = row.amount
      ..createdAt = row.createdAt;
  }
}
