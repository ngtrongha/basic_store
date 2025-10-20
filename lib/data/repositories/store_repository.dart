import 'package:isar/isar.dart';
import '../models/store.dart';
import '../services/database_service.dart';

class StoreRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(Store store) async {
    return _isar.writeTxn(() => _isar.stores.put(store));
  }

  Future<Store?> getById(int id) async {
    return _isar.stores.get(id);
  }

  Future<List<Store>> getAll({int limit = 100}) async {
    return _isar.stores.where().limit(limit).findAll();
  }

  Future<List<Store>> getActiveStores() async {
    return _isar.stores.filter().isActiveEqualTo(true).findAll();
  }

  Future<void> update(Store store) async {
    await _isar.writeTxn(() => _isar.stores.put(store));
  }

  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.stores.delete(id));
  }
}
