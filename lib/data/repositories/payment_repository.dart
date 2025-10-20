import 'package:isar/isar.dart';

import '../models/payment.dart';
import '../services/database_service.dart';

class PaymentRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<List<int>> createAll(List<Payment> payments) async {
    return _isar.writeTxn(() => _isar.payments.putAll(payments));
  }

  Future<List<Payment>> getByOrderId(int orderId) async {
    return _isar.payments.filter().orderIdEqualTo(orderId).findAll();
  }

  Future<void> deleteByOrderId(int orderId) async {
    await _isar.writeTxn(() async {
      await _isar.payments.filter().orderIdEqualTo(orderId).deleteAll();
    });
  }

  Future<List<Payment>> getAll({int limit = 1000}) async {
    return _isar.payments.where().limit(limit).findAll();
  }

  Future<List<Payment>> getByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _isar.payments
        .filter()
        .createdAtBetween(startDate, endDate)
        .sortByCreatedAtDesc()
        .findAll();
  }
}
