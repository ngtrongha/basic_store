import 'package:isar/isar.dart';
import '../models/return.dart';
import '../services/database_service.dart';

class ReturnRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(Return return_) async {
    return _isar.writeTxn(() => _isar.returns.put(return_));
  }

  Future<Return?> getById(int id) async {
    return _isar.returns.get(id);
  }

  Future<List<Return>> getAll({int limit = 1000}) async {
    return _isar.returns.where().limit(limit).findAll();
  }

  Future<void> update(Return return_) async {
    await _isar.writeTxn(() => _isar.returns.put(return_));
  }

  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.returns.delete(id));
  }

  Future<List<Return>> getByOrderId(int orderId) async {
    return _isar.returns.where().findAll();
  }

  Future<List<Return>> getByCustomerId(int customerId) async {
    return _isar.returns.filter().customerIdEqualTo(customerId).findAll();
  }
}
