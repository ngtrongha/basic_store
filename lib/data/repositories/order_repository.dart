import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/order.dart' as model;
import '../services/database_service.dart';

class OrderRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(model.Order order) async {
    final companion = OrdersCompanion(
      id: order.id == 0 ? const Value.absent() : Value(order.id),
      createdAt: Value(order.createdAt),
      totalAmount: Value(order.totalAmount),
      customerId: Value(order.customerId),
      pointsDelta: Value(order.pointsDelta),
      itemsJson: Value(order.itemsJson),
      changeAmount: Value(order.change),
    );
    final id = await _db
        .into(_db.orders)
        .insert(companion, mode: InsertMode.insertOrReplace);
    order.id = id;
    return id;
  }

  Future<model.Order?> getById(int id) async {
    final row = await (_db.select(
      _db.orders,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<model.Order>> getAll({int offset = 0, int limit = 50}) async {
    final rows =
        await (_db.select(_db.orders)
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ])
              ..limit(limit, offset: offset))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<List<model.Order>> getByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final rows =
        await (_db.select(_db.orders)
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

  model.Order _toModel(OrderRow row) {
    return model.Order()
      ..id = row.id
      ..createdAt = row.createdAt
      ..totalAmount = row.totalAmount
      ..customerId = row.customerId
      ..pointsDelta = row.pointsDelta
      ..itemsJson = row.itemsJson
      ..change = row.changeAmount;
  }
}
