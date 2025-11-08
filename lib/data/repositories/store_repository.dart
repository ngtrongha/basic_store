import '../../objectbox.g.dart';
import '../models/store.dart' as model;
import '../services/database_service.dart';

class StoreRepository {
  Box<model.Store> get _box =>
      DatabaseService.instance.store.box<model.Store>();

  Future<int> create(model.Store store) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(store));
  }

  Future<model.Store?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<model.Store>> getAll({int limit = 100}) async {
    final query = _box.query().build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<List<model.Store>> getActiveStores() async {
    final builder = _box.query(Store_.isActive.equals(true));
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<void> update(model.Store store) async {
    await DatabaseService.instance.runWrite<int>(() => _box.put(store));
  }

  Future<bool> delete(int id) async {
    return Future.value(_box.remove(id));
  }
}
