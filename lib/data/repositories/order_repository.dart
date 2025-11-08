import 'package:objectbox/objectbox.dart' as ob;

import '../../objectbox.g.dart';
import '../models/order.dart' as model;
import '../services/database_service.dart';

class OrderRepository {
  ob.Box<model.Order> get _box =>
      DatabaseService.instance.store.box<model.Order>();

  Future<int> create(model.Order order) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(order));
  }

  Future<model.Order?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<model.Order>> getAll({int offset = 0, int limit = 50}) async {
    final query = _box.query().build();
    try {
      final results = query.find();
      if (offset >= results.length) return <model.Order>[];
      return results.skip(offset).take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<List<model.Order>> getByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final builder = _box.query(
      Order_.createdAt.between(
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch,
      ),
    )..order(Order_.createdAt, flags: ob.Order.descending);
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }
}
