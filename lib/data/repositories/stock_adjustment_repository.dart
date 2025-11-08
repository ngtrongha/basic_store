import '../../objectbox.g.dart';
import '../models/stock_adjustment.dart';
import '../services/database_service.dart';

class StockAdjustmentRepository {
  Box<StockAdjustment> get _box =>
      DatabaseService.instance.store.box<StockAdjustment>();

  Future<int> create(StockAdjustment adjustment) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(adjustment));
  }

  Future<StockAdjustment?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<StockAdjustment>> getAll({int limit = 1000}) async {
    final query = _box.query().build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<void> update(StockAdjustment adjustment) async {
    await DatabaseService.instance.runWrite<int>(() => _box.put(adjustment));
  }

  Future<bool> delete(int id) async {
    return Future.value(_box.remove(id));
  }

  Future<List<StockAdjustment>> getByProductId(int productId) async {
    final builder = _box.query(StockAdjustment_.productId.equals(productId));
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<List<StockAdjustment>> getExpiringSoon() async {
    final query = _box.query().build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }
}
