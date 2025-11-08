import '../../objectbox.g.dart';

import '../models/user.dart';
import '../services/database_service.dart';

class UserRepository {
  Box<AppUser> get _box => DatabaseService.instance.store.box<AppUser>();

  Future<int> create(AppUser user) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(user));
  }

  Future<AppUser?> getByUsername(String username) async {
    final builder =
        _box.query(AppUser_.username.equals(username, caseSensitive: false));
    final query = builder.build();
    try {
      return query.findFirst();
    } finally {
      query.close();
    }
  }

  Future<AppUser?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<AppUser>> getAll({int limit = 100}) async {
    final query = _box.query().build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }
}
