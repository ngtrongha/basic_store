import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/customer.dart';
import '../services/database_service.dart';

class CustomerRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(Customer customer) async {
    final companion = CustomersCompanion(
      id: customer.id == 0 ? const Value.absent() : Value(customer.id),
      name: Value(customer.name),
      phone: Value(customer.phone),
      email: Value(customer.email),
      tier: Value(customer.tier),
      points: Value(customer.points),
    );
    final id = await _db
        .into(_db.customers)
        .insert(companion, mode: InsertMode.insertOrReplace);
    customer.id = id;
    return id;
  }

  Future<bool> deleteById(int id) async {
    final deleted = await (_db.delete(
      _db.customers,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  Future<Customer?> getById(int id) async {
    final row = await (_db.select(
      _db.customers,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<Customer>> search({String? query, int limit = 100}) async {
    final q = query?.trim();
    final select = _db.select(_db.customers)
      ..orderBy([(t) => OrderingTerm(expression: t.id)])
      ..limit(limit);
    if (q != null && q.isNotEmpty) {
      final pattern = '%$q%';
      select.where(
        (t) => t.name.like(pattern) | t.phone.equals(q) | t.email.equals(q),
      );
    }
    final rows = await select.get();
    return rows.map(_toModel).toList();
  }

  Future<void> addPoints(int customerId, int points) async {
    await DatabaseService.instance.runWriteVoid((db) async {
      final row = await (db.select(
        db.customers,
      )..where((t) => t.id.equals(customerId))).getSingleOrNull();
      if (row == null) return;
      await (db.update(db.customers)..where((t) => t.id.equals(customerId)))
          .write(CustomersCompanion(points: Value(row.points + points)));
    });
  }

  Future<List<Customer>> getAll({int limit = 1000}) async {
    final rows =
        await (_db.select(_db.customers)
              ..orderBy([(t) => OrderingTerm(expression: t.id)])
              ..limit(limit))
            .get();
    return rows.map(_toModel).toList();
  }

  Customer _toModel(CustomerRow row) {
    return Customer()
      ..id = row.id
      ..name = row.name
      ..phone = row.phone
      ..email = row.email
      ..tier = row.tier
      ..points = row.points;
  }
}
