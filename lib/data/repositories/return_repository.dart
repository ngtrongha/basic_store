import '../../objectbox.g.dart';
import '../models/return.dart';
import '../services/database_service.dart';

class ReturnRepository {
  Box<Return> get _box => DatabaseService.instance.store.box<Return>();

  Future<int> create(Return return_) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(return_));
  }

  Future<Return?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<Return>> getAll({int limit = 1000}) async {
    final query = _box.query().build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<void> update(Return return_) async {
    await DatabaseService.instance
        .runWrite<int>(() => _box.put(return_));
  }

  Future<bool> delete(int id) async {
    return Future.value(_box.remove(id));
  }

  Future<List<Return>> getByOrderId(int orderId) async {
    final builder =
        _box.query(Return_.originalOrderId.equals(orderId));
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<List<Return>> getByCustomerId(int customerId) async {
    final builder =
        _box.query(Return_.customerId.equals(customerId));
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }
}
