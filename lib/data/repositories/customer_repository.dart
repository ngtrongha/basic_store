import '../../objectbox.g.dart';

import '../models/customer.dart';
import '../services/database_service.dart';

class CustomerRepository {
  Box<Customer> get _box => DatabaseService.instance.store.box<Customer>();

  Future<int> create(Customer customer) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(customer));
  }

  Future<bool> deleteById(int id) async {
    return Future.value(_box.remove(id));
  }

  Future<Customer?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<Customer>> search({String? query, int limit = 100}) async {
    if (query == null || query.trim().isEmpty) {
      final q = _box.query().build();
      try {
        final results = q.find();
        if (results.length <= limit) return results;
        return results.take(limit).toList();
      } finally {
        q.close();
      }
    }
    final q = query.trim();
    final condition =
        Customer_.name.contains(q, caseSensitive: false) |
        Customer_.phone.equals(q, caseSensitive: false) |
        Customer_.email.equals(q, caseSensitive: false);
    final queryBuilt = _box.query(condition).build();
    try {
      final results = queryBuilt.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      queryBuilt.close();
    }
  }

  Future<void> addPoints(int customerId, int points) async {
    await DatabaseService.instance.runWriteVoid(() {
      final customer = _box.get(customerId);
      if (customer == null) {
        return;
      }
      customer.points = customer.points + points;
      _box.put(customer);
    });
  }

  Future<List<Customer>> getAll({int limit = 1000}) async {
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
