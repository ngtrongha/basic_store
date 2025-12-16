import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/store.dart' as model;
import '../services/database_service.dart';

class StoreRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(model.Store store) async {
    final companion = StoresCompanion(
      id: store.id == 0 ? const Value.absent() : Value(store.id),
      name: Value(store.name),
      address: Value(store.address),
      phone: Value(store.phone),
      email: Value(store.email),
      isActive: Value(store.isActive),
      createdAt: Value(store.createdAt),
    );
    final id = await _db
        .into(_db.stores)
        .insert(companion, mode: InsertMode.insertOrReplace);
    store.id = id;
    return id;
  }

  Future<model.Store?> getById(int id) async {
    final row = await (_db.select(
      _db.stores,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<model.Store>> getAll({int limit = 100}) async {
    final rows =
        await (_db.select(_db.stores)
              ..orderBy([(t) => OrderingTerm(expression: t.id)])
              ..limit(limit))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<List<model.Store>> getActiveStores() async {
    final rows =
        await (_db.select(_db.stores)
              ..where((t) => t.isActive.equals(true))
              ..orderBy([(t) => OrderingTerm(expression: t.id)]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<void> update(model.Store store) async {
    await create(store);
  }

  Future<bool> delete(int id) async {
    final deleted = await (_db.delete(
      _db.stores,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  model.Store _toModel(StoreRow row) {
    return model.Store()
      ..id = row.id
      ..name = row.name
      ..address = row.address
      ..phone = row.phone
      ..email = row.email
      ..isActive = row.isActive
      ..createdAt = row.createdAt;
  }
}
