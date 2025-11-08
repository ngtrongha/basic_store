import '../../objectbox.g.dart';
import '../models/supplier.dart';
import '../services/database_service.dart';

class SupplierRepository {
  Box<Supplier> get _box => DatabaseService.instance.store.box<Supplier>();

  Future<int> create(Supplier supplier) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(supplier));
  }

  Future<Supplier?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<Supplier>> getAll({int limit = 1000}) async {
    final query = _box.query().build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<void> update(Supplier supplier) async {
    await DatabaseService.instance
        .runWrite<int>(() => _box.put(supplier));
  }

  Future<bool> delete(int id) async {
    return Future.value(_box.remove(id));
  }

  Future<List<Supplier>> search({String? query, int limit = 100}) async {
    if (query == null || query.trim().isEmpty) {
      final searchQuery = _box.query().build();
      try {
        final results = searchQuery.find();
        if (results.length <= limit) return results;
        return results.take(limit).toList();
      } finally {
        searchQuery.close();
      }
    }
    final q = query.trim();
    final queryBuilt =
        _box.query(Supplier_.name.contains(q, caseSensitive: false)).build();
    try {
      final results = queryBuilt.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      queryBuilt.close();
    }
  }
}
