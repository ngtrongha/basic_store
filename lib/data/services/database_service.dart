import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/user.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService instance = DatabaseService._internal();

  AppDatabase? _db;

  AppDatabase get db {
    final value = _db;
    if (value == null) {
      throw StateError('DatabaseService not initialized. Call init() first.');
    }
    return value;
  }

  Future<void> init() async {
    if (_db != null) return;
    _db = AppDatabase();
    // Force open early to surface any IO errors before runApp().
    await db.customSelect('SELECT 1').getSingleOrNull();
  }

  Future<void> reopen() async {
    final current = _db;
    if (current != null) {
      await current.close();
      _db = null;
    }
    await init();
  }

  Future<T> runWrite<T>(Future<T> Function(AppDatabase db) action) async {
    return db.transaction(() => action(db));
  }

  Future<void> runWriteVoid(
    Future<void> Function(AppDatabase db) action,
  ) async {
    await db.transaction(() => action(db));
  }

  Future<void> seedIfEmpty() async {
    final hasProduct = await db.select(db.products).getSingleOrNull();
    if (hasProduct == null) {
      final seedProducts = List.generate(10, (i) {
        return ProductsCompanion.insert(
          name: 'Sản phẩm ${i + 1}',
          sku: 'SKU${1000 + i}',
          costPrice: Value((i + 1) * 8000.0),
          salePrice: Value((i + 1) * 10000.0),
          stock: Value(10 + i),
          lowStockThreshold: const Value(5),
          category: Value('Danh mục ${(i % 3) + 1}'),
        );
      });
      await db.batch((batch) {
        batch.insertAll(db.products, seedProducts);
      });
    }

    final hasUser = await db.select(db.users).getSingleOrNull();
    if (hasUser == null) {
      await db.batch((batch) {
        batch.insertAll(db.users, [
          UsersCompanion.insert(
            username: 'admin',
            password: 'admin',
            roleValue: UserRole.admin.index,
          ),
          UsersCompanion.insert(
            username: 'manager',
            password: 'manager',
            roleValue: UserRole.manager.index,
          ),
          UsersCompanion.insert(
            username: 'cashier',
            password: 'cashier',
            roleValue: UserRole.cashier.index,
          ),
        ]);
      });
    }

    final hasStore = await db.select(db.stores).getSingleOrNull();
    if (hasStore == null) {
      await db
          .into(db.stores)
          .insert(
            StoresCompanion.insert(
              name: 'Cửa hàng chính',
              address: const Value('Địa chỉ mặc định'),
              isActive: const Value(true),
              createdAt: Value(DateTime.now()),
            ),
          );
    }
  }
}
