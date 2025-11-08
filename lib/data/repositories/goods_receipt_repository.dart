import 'package:objectbox/objectbox.dart';
import '../models/goods_receipt.dart';
import '../services/database_service.dart';

class GoodsReceiptRepository {
  Box<GoodsReceipt> get _box =>
      DatabaseService.instance.store.box<GoodsReceipt>();

  Future<int> create(GoodsReceipt receipt) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(receipt));
  }

  Future<GoodsReceipt?> getById(int id) async {
    return Future.value(_box.get(id));
  }

  Future<List<GoodsReceipt>> getAll({int limit = 1000}) async {
    final query = _box.query().build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }

  Future<void> update(GoodsReceipt receipt) async {
    await DatabaseService.instance.runWrite<int>(() => _box.put(receipt));
  }

  Future<bool> delete(int id) async {
    return Future.value(_box.remove(id));
  }
}
