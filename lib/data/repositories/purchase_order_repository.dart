import 'package:objectbox/objectbox.dart';
import '../models/purchase_order.dart';
import '../services/database_service.dart';

class PurchaseOrderRepository {
  Box<PurchaseOrder> get _box =>
      DatabaseService.instance.store.box<PurchaseOrder>();

  Future<int> create(PurchaseOrder order) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(order));
  }

  Future<PurchaseOrder?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<PurchaseOrder>> getAll({int limit = 1000}) async {
    final query = _box.query().build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<void> update(PurchaseOrder order) async {
    await DatabaseService.instance.runWrite<int>(() => _box.put(order));
  }

  Future<bool> delete(int id) async {
    return Future.value(_box.remove(id));
  }
}
