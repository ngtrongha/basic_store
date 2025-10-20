import 'package:isar/isar.dart';

import '../models/order.dart';
import '../services/database_service.dart';

class OrderRepository {
  Isar get _isar => DatabaseService.instance.isar;

  Future<int> create(Order order) async {
    return _isar.writeTxn(() async {
      return await _isar.orders.put(order);
    });
  }

  Future<Order?> getById(int id) async {
    return await _isar.orders.get(id);
  }

  Future<List<Order>> getAll({int offset = 0, int limit = 50}) async {
    return await _isar.orders.where().offset(offset).limit(limit).findAll();
  }

  Future<List<Order>> getByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _isar.orders
        .filter()
        .createdAtBetween(startDate, endDate)
        .sortByCreatedAtDesc()
        .findAll();
  }
}
