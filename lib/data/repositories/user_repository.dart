import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/user.dart';
import '../services/database_service.dart';

class UserRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(AppUser user) async {
    final companion = UsersCompanion(
      id: user.id == 0 ? const Value.absent() : Value(user.id),
      username: Value(user.username),
      password: Value(user.password),
      roleValue: Value(user.roleValue),
      createdAt: Value(user.createdAt),
    );
    final id = await _db
        .into(_db.users)
        .insert(companion, mode: InsertMode.insertOrReplace);
    user.id = id;
    return id;
  }

  Future<AppUser?> getByUsername(String username) async {
    final row = await (_db.select(
      _db.users,
    )..where((t) => t.username.equals(username))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<AppUser?> getById(int id) async {
    final row = await (_db.select(
      _db.users,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<AppUser>> getAll({int limit = 100}) async {
    final rows =
        await (_db.select(_db.users)
              ..orderBy([(t) => OrderingTerm(expression: t.id)])
              ..limit(limit))
            .get();
    return rows.map(_toModel).toList();
  }

  AppUser _toModel(UserRow row) {
    return AppUser()
      ..id = row.id
      ..username = row.username
      ..password = row.password
      ..roleValue = row.roleValue
      ..createdAt = row.createdAt;
  }
}
