import 'package:isar/isar.dart';
import '../models/purchase_order.dart';
import '../services/database_service.dart';

class PurchaseOrderRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(PurchaseOrder order) async {
    return _isar.writeTxn(() => _isar.purchaseOrders.put(order));
  }

  Future<PurchaseOrder?> getById(int id) async {
    return _isar.purchaseOrders.get(id);
  }

  Future<List<PurchaseOrder>> getAll({int limit = 1000}) async {
    return _isar.purchaseOrders.where().limit(limit).findAll();
  }

  Future<void> update(PurchaseOrder order) async {
    await _isar.writeTxn(() => _isar.purchaseOrders.put(order));
  }

  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.purchaseOrders.delete(id));
  }
}
