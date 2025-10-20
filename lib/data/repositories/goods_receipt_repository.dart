import 'package:isar/isar.dart';
import '../models/goods_receipt.dart';
import '../services/database_service.dart';

class GoodsReceiptRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(GoodsReceipt receipt) async {
    return _isar.writeTxn(() => _isar.goodsReceipts.put(receipt));
  }

  Future<GoodsReceipt?> getById(int id) async {
    return _isar.goodsReceipts.get(id);
  }

  Future<List<GoodsReceipt>> getAll({int limit = 1000}) async {
    return _isar.goodsReceipts.where().limit(limit).findAll();
  }

  Future<void> update(GoodsReceipt receipt) async {
    await _isar.writeTxn(() => _isar.goodsReceipts.put(receipt));
  }

  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.goodsReceipts.delete(id));
  }
}
