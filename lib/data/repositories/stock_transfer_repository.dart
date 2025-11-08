import '../../objectbox.g.dart';
import '../models/stock_transfer.dart';
import '../services/database_service.dart';

class StockTransferRepository {
  Box<StockTransfer> get _box =>
      DatabaseService.instance.store.box<StockTransfer>();

  Future<int> create(StockTransfer transfer) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(transfer));
  }

  Future<StockTransfer?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<StockTransfer>> getAll({int limit = 100}) async {
    final builder = _box.query()
      ..order(StockTransfer_.createdAt, flags: Order.descending);
    final query = builder.build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<List<StockTransfer>> getByStore(int storeId) async {
    final builder = _box.query(StockTransfer_.fromStoreId.equals(storeId))
      ..order(StockTransfer_.createdAt, flags: Order.descending);
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<List<StockTransfer>> getByStatus(String status) async {
    final builder = _box.query(StockTransfer_.status.equals(status));
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<void> update(StockTransfer transfer) async {
    await DatabaseService.instance.runWrite<int>(() => _box.put(transfer));
  }

  Future<bool> delete(int id) async {
    return Future.value(_box.remove(id));
  }
}
