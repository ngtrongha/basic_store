import 'package:isar/isar.dart';
import '../models/supplier.dart';
import '../services/database_service.dart';

class SupplierRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(Supplier supplier) async {
    return _isar.writeTxn(() => _isar.suppliers.put(supplier));
  }

  Future<Supplier?> getById(int id) async {
    return _isar.suppliers.get(id);
  }

  Future<List<Supplier>> getAll({int limit = 1000}) async {
    return _isar.suppliers.where().limit(limit).findAll();
  }

  Future<void> update(Supplier supplier) async {
    await _isar.writeTxn(() => _isar.suppliers.put(supplier));
  }

  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.suppliers.delete(id));
  }

  Future<List<Supplier>> search({String? query, int limit = 100}) async {
    if (query == null || query.trim().isEmpty) {
      return _isar.suppliers.where().limit(limit).findAll();
    }
    final q = query.trim();
    return _isar.suppliers
        .filter()
        .nameContains(q, caseSensitive: false)
        .limit(limit)
        .findAll();
  }
}
