import 'package:objectbox/objectbox.dart' as ob;
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';
import '../models/product.dart';
import '../models/store.dart' as model;
import '../models/user.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService instance = DatabaseService._internal();

  ob.Store? _store;

  ob.Store get store {
    final value = _store;
    if (value == null) {
      throw StateError('DatabaseService not initialized. Call init() first.');
    }
    return value;
  }

  Future<void> init() async {
    if (_store != null) return;
    final dir = await getApplicationDocumentsDirectory();
    _store = await openStore(directory: dir.path);
  }

  Future<void> reopen() async {
    final current = _store;
    if (current != null) {
      current.close();
      _store = null;
    }
    await init();
  }

  Future<T> runWrite<T>(T Function() action) async {
    return Future<T>(() => store.runInTransaction(ob.TxMode.write, action));
  }

  Future<void> runWriteVoid(void Function() action) async {
    await Future<void>(() {
      store.runInTransaction(ob.TxMode.write, () {
        action();
        return true;
      });
    });
  }

  Future<void> seedIfEmpty() async {
    final products = store.box<Product>();
    if (products.isEmpty()) {
      final seedProducts = List.generate(10, (i) {
        return Product()
          ..name = 'Sản phẩm ${i + 1}'
          ..sku = 'SKU${1000 + i}'
          ..costPrice = (i + 1) * 8000.0
          ..salePrice = (i + 1) * 10000.0
          ..stock = 10 + i
          ..lowStockThreshold = 5
          ..category = 'Danh mục ${(i % 3) + 1}';
      });
      products.putMany(seedProducts);
    }

    final users = store.box<AppUser>();
    if (users.isEmpty()) {
      users.putMany([
        AppUser()
          ..username = 'admin'
          ..password = 'admin'
          ..role = UserRole.admin,
        AppUser()
          ..username = 'manager'
          ..password = 'manager'
          ..role = UserRole.manager,
        AppUser()
          ..username = 'cashier'
          ..password = 'cashier'
          ..role = UserRole.cashier,
      ]);
    }

    final stores = store.box<model.Store>();
    if (stores.isEmpty()) {
      stores.put(
        model.Store()
          ..name = 'Cửa hàng chính'
          ..address = 'Địa chỉ mặc định'
          ..isActive = true
          ..createdAt = DateTime.now(),
      );
    }
  }
}
