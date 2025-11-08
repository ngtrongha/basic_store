import '../../objectbox.g.dart';

import '../models/payment.dart';
import '../services/database_service.dart';

class PaymentRepository {
  Box<Payment> get _box => DatabaseService.instance.store.box<Payment>();

  Future<List<int>> createAll(List<Payment> payments) async {
    return DatabaseService.instance.runWrite<List<int>>(
      () => _box.putMany(payments),
    );
  }

  Future<List<Payment>> getByOrderId(int orderId) async {
    final builder = _box.query(Payment_.orderId.equals(orderId));
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<void> deleteByOrderId(int orderId) async {
    await DatabaseService.instance.runWriteVoid(() {
      final builder = _box.query(Payment_.orderId.equals(orderId));
      final query = builder.build();
      try {
        query.remove();
      } finally {
        query.close();
      }
    });
  }

  Future<List<Payment>> getAll({int limit = 1000}) async {
    final query = _box.query().build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<List<Payment>> getByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final builder = _box.query(
      Payment_.createdAt.between(
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch,
      ),
    )..order(Payment_.createdAt, flags: Order.descending);
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }
}
