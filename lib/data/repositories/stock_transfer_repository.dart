import 'package:isar/isar.dart';
import '../models/stock_transfer.dart';
import '../services/database_service.dart';

class StockTransferRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(StockTransfer transfer) async {
    return _isar.writeTxn(() => _isar.stockTransfers.put(transfer));
  }

  Future<StockTransfer?> getById(int id) async {
    return _isar.stockTransfers.get(id);
  }

  Future<List<StockTransfer>> getAll({int limit = 100}) async {
    return _isar.stockTransfers
        .where()
        .sortByCreatedAtDesc()
        .limit(limit)
        .findAll();
  }

  Future<List<StockTransfer>> getByStore(int storeId) async {
    return _isar.stockTransfers
        .filter()
        .fromStoreIdEqualTo(storeId)
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<List<StockTransfer>> getByStatus(String status) async {
    return _isar.stockTransfers.filter().statusEqualTo(status).findAll();
  }

  Future<void> update(StockTransfer transfer) async {
    await _isar.writeTxn(() => _isar.stockTransfers.put(transfer));
  }

  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.stockTransfers.delete(id));
  }
}
