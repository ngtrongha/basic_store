import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/supplier.dart';
import '../services/database_service.dart';

class SupplierRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(Supplier supplier) async {
    final companion = SuppliersCompanion(
      id: supplier.id == 0 ? const Value.absent() : Value(supplier.id),
      name: Value(supplier.name),
      contactName: Value(supplier.contactName),
      phone: Value(supplier.phone),
      email: Value(supplier.email),
      address: Value(supplier.address),
      createdAt: Value(supplier.createdAt),
    );
    final id = await _db
        .into(_db.suppliers)
        .insert(companion, mode: InsertMode.insertOrReplace);
    supplier.id = id;
    return id;
  }

  Future<Supplier?> getById(int id) async {
    final row = await (_db.select(
      _db.suppliers,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<Supplier>> getAll({int limit = 1000}) async {
    final rows =
        await (_db.select(_db.suppliers)
              ..orderBy([(t) => OrderingTerm(expression: t.id)])
              ..limit(limit))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<void> update(Supplier supplier) async {
    await create(supplier);
  }

  Future<bool> delete(int id) async {
    final deleted = await (_db.delete(
      _db.suppliers,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  Future<List<Supplier>> search({String? query, int limit = 100}) async {
    final q = query?.trim();
    final select = _db.select(_db.suppliers)
      ..orderBy([(t) => OrderingTerm(expression: t.id)])
      ..limit(limit);
    if (q != null && q.isNotEmpty) {
      select.where((t) => t.name.like('%$q%'));
    }
    final rows = await select.get();
    return rows.map(_toModel).toList();
  }

  Supplier _toModel(SupplierRow row) {
    return Supplier()
      ..id = row.id
      ..name = row.name
      ..contactName = row.contactName
      ..phone = row.phone
      ..email = row.email
      ..address = row.address
      ..createdAt = row.createdAt;
  }
}
