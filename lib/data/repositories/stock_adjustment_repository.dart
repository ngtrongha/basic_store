import 'package:isar/isar.dart';
import '../models/stock_adjustment.dart';
import '../services/database_service.dart';

class StockAdjustmentRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(StockAdjustment adjustment) async {
    return _isar.writeTxn(() => _isar.stockAdjustments.put(adjustment));
  }

  Future<StockAdjustment?> getById(int id) async {
    return _isar.stockAdjustments.get(id);
  }

  Future<List<StockAdjustment>> getAll({int limit = 1000}) async {
    return _isar.stockAdjustments.where().limit(limit).findAll();
  }

  Future<void> update(StockAdjustment adjustment) async {
    await _isar.writeTxn(() => _isar.stockAdjustments.put(adjustment));
  }

  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.stockAdjustments.delete(id));
  }

  Future<List<StockAdjustment>> getByProductId(int productId) async {
    return _isar.stockAdjustments
        .filter()
        .productIdEqualTo(productId)
        .findAll();
  }

  Future<List<StockAdjustment>> getExpiringSoon() async {
    return _isar.stockAdjustments.where().findAll();
  }
}
