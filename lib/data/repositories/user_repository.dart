import 'package:isar/isar.dart';

import '../models/user.dart';
import '../services/database_service.dart';

class UserRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(AppUser user) async {
    return _isar.writeTxn(() => _isar.appUsers.put(user));
  }

  Future<AppUser?> getByUsername(String username) async {
    return _isar.appUsers
        .filter()
        .usernameEqualTo(username, caseSensitive: false)
        .findFirst();
  }

  Future<List<AppUser>> getAll({int limit = 100}) async {
    return _isar.appUsers.where().limit(limit).findAll();
  }
}
