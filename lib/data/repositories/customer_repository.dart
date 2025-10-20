import 'package:isar/isar.dart';

import '../models/customer.dart';
import '../services/database_service.dart';

class CustomerRepository {
  Isar get _isar => DatabaseService.instance.isar;

  Future<int> create(Customer customer) async {
    return _isar.writeTxn(() async => _isar.customers.put(customer));
  }

  Future<bool> deleteById(int id) async {
    return _isar.writeTxn(() async => _isar.customers.delete(id));
  }

  Future<Customer?> getById(int id) async {
    return _isar.customers.get(id);
  }

  Future<List<Customer>> search({String? query, int limit = 100}) async {
    if (query == null || query.trim().isEmpty) {
      return _isar.customers.where().limit(limit).findAll();
    }
    final q = query.trim();
    return _isar.customers
        .filter()
        .nameContains(q, caseSensitive: false)
        .or()
        .phoneEqualTo(q, caseSensitive: false)
        .or()
        .emailEqualTo(q, caseSensitive: false)
        .limit(limit)
        .findAll();
  }

  Future<void> addPoints(int customerId, int points) async {
    await _isar.writeTxn(() async {
      final c = await _isar.customers.get(customerId);
      if (c == null) return;
      c.points = c.points + points;
      await _isar.customers.put(c);
    });
  }

  Future<List<Customer>> getAll({int limit = 1000}) async {
    return _isar.customers.where().limit(limit).findAll();
  }
}
