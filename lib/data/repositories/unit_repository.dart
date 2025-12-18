import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/unit.dart' as model;
import '../services/database_service.dart';

class UnitRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(model.Unit unit) async {
    final companion = UnitsCompanion(
      id: unit.id == 0 ? const Value.absent() : Value(unit.id),
      name: Value(unit.name),
      key: Value(unit.key),
      isActive: Value(unit.isActive),
      createdAt: Value(unit.createdAt),
    );
    final id = await _db
        .into(_db.units)
        .insert(companion, mode: InsertMode.insertOrReplace);
    unit.id = id;
    return id;
  }

  Future<void> upsert(model.Unit unit) async {
    await create(unit);
  }

  Future<model.Unit?> getById(int id) async {
    final row = await (_db.select(
      _db.units,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<model.Unit?> getByKey(String key) async {
    final k = normalizeKey(key);
    if (k.isEmpty) return null;
    final row = await (_db.select(
      _db.units,
    )..where((t) => t.key.equals(k))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<model.Unit>> getAll({int limit = 500}) async {
    final rows =
        await (_db.select(_db.units)
              ..orderBy([(t) => OrderingTerm(expression: t.name)])
              ..limit(limit))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<List<model.Unit>> search({String? query, int limit = 200}) async {
    final q = query?.trim();
    final select = _db.select(_db.units)
      ..orderBy([(t) => OrderingTerm(expression: t.name)])
      ..limit(limit);

    if (q != null && q.isNotEmpty) {
      final pattern = '%$q%';
      final keyPattern = '%${normalizeKey(q)}%';
      select.where((t) => t.name.like(pattern) | t.key.like(keyPattern));
    }

    final rows = await select.get();
    return rows.map(_toModel).toList();
  }

  Future<bool> deleteById(int id) async {
    final deleted = await (_db.delete(
      _db.units,
    )..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  model.Unit _toModel(UnitRow row) {
    return model.Unit()
      ..id = row.id
      ..name = row.name
      ..key = row.key
      ..isActive = row.isActive
      ..createdAt = row.createdAt;
  }

  /// Normalize Vietnamese text to a stable key for unit matching.
  /// - lowercases
  /// - removes Vietnamese diacritics
  /// - keeps only [a-z0-9 ] and collapses whitespace
  static String normalizeKey(String input) {
    final lower = input.toLowerCase().trim();
    if (lower.isEmpty) return '';

    var s = lower;

    s = s.replaceAll('đ', 'd');

    s = s.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    s = s.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    s = s.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    s = s.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    s = s.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    s = s.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');

    s = s
        .replaceAll(RegExp(r'[^a-z0-9\s]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    return s;
  }
}
