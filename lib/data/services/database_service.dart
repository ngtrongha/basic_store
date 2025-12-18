import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/app_database.dart';
import '../models/payment.dart';
import '../models/user.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService instance = DatabaseService._internal();

  static const String _demoSeededKey = 'demo_data_seeded_v1';

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
    // Always ensure core data exists (admin + store + units + base product units).
    await _ensureCoreData();

    // Demo dataset should be seeded only once (first launch).
    await _seedDemoDataOnce();
  }

  Future<void> _ensureCoreData() async {
    // ---- Admin user ----
    final admin = await (db.select(
      db.users,
    )..where((t) => t.username.equals('admin'))).getSingleOrNull();
    if (admin == null) {
      await db
          .into(db.users)
          .insert(
            UsersCompanion.insert(
              username: 'admin',
              password: 'admin',
              roleValue: UserRole.admin.index,
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }

    // ---- Store ----
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

    // ---- Units (UoM) ----
    final now = DateTime.now();
    await db.batch((batch) {
      batch.insertAll(db.units, [
        UnitsCompanion.insert(name: 'Cái', key: 'cai', createdAt: Value(now)),
        UnitsCompanion.insert(name: 'Lon', key: 'lon', createdAt: Value(now)),
        UnitsCompanion.insert(name: 'Chai', key: 'chai', createdAt: Value(now)),
        UnitsCompanion.insert(
          name: 'Thùng',
          key: 'thung',
          createdAt: Value(now),
        ),
        UnitsCompanion.insert(name: 'Lốc', key: 'loc', createdAt: Value(now)),
        UnitsCompanion.insert(name: 'Hộp', key: 'hop', createdAt: Value(now)),
        UnitsCompanion.insert(name: 'Gói', key: 'goi', createdAt: Value(now)),
        UnitsCompanion.insert(name: 'Bịch', key: 'bi', createdAt: Value(now)),
        UnitsCompanion.insert(name: 'Túi', key: 'tui', createdAt: Value(now)),
        UnitsCompanion.insert(name: 'Khay', key: 'khay', createdAt: Value(now)),
        UnitsCompanion.insert(name: 'Cây', key: 'cay', createdAt: Value(now)),
        UnitsCompanion.insert(name: 'Bộ', key: 'bo', createdAt: Value(now)),
        UnitsCompanion.insert(name: 'Cặp', key: 'cap', createdAt: Value(now)),
      ], mode: InsertMode.insertOrIgnore);
    });

    // Ensure every product has at least one base/default unit mapping.
    final baseUnitId = await _ensureUnitIdByKeyOrCreate(
      name: 'Cái',
      key: 'cai',
    );

    final products = await db.select(db.products).get();
    for (final p in products) {
      final existing =
          await (db.select(db.productUnits)
                ..where((t) => t.productId.equals(p.id))
                ..limit(1))
              .getSingleOrNull();
      if (existing != null) continue;

      await db
          .into(db.productUnits)
          .insert(
            ProductUnitsCompanion.insert(
              productId: p.id,
              unitId: baseUnitId,
              factor: const Value(1.0),
              isBase: const Value(true),
              isDefault: const Value(true),
              createdAt: Value(DateTime.now()),
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  Future<int> _ensureUnitIdByKeyOrCreate({
    required String name,
    required String key,
  }) async {
    final existing = await (db.select(
      db.units,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    if (existing != null) return existing.id;

    final inserted = await db
        .into(db.units)
        .insert(
          UnitsCompanion.insert(
            name: name,
            key: key,
            createdAt: Value(DateTime.now()),
          ),
          mode: InsertMode.insertOrIgnore,
        );

    if (inserted > 0) return inserted;

    // If insert was ignored due to a race, fetch again.
    final again = await (db.select(
      db.units,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    if (again == null) {
      throw StateError('Failed to ensure unit key=$key');
    }
    return again.id;
  }

  Future<void> _seedDemoDataOnce() async {
    final prefs = await SharedPreferences.getInstance();
    final seeded = prefs.getBool(_demoSeededKey) ?? false;
    if (seeded) return;

    await db.transaction(() async {
      await _seedDemoProductsIfNeeded();
      await _seedDemoCustomersIfNeeded();
      await _seedDemoOrdersAndPaymentsIfNeeded();
    });

    await prefs.setBool(_demoSeededKey, true);
  }

  Future<void> _seedDemoProductsIfNeeded() async {
    final hasProduct = await db.select(db.products).getSingleOrNull();
    if (hasProduct != null) return;

    await db.batch((batch) {
      batch.insertAll(db.products, [
        ProductsCompanion.insert(
          name: 'Tiger',
          sku: 'TIGER',
          costPrice: const Value(16000.0),
          salePrice: const Value(20000.0),
          stock: const Value(240),
          lowStockThreshold: const Value(48),
          category: const Value('Bia'),
        ),
        ProductsCompanion.insert(
          name: 'Coca',
          sku: 'COCA',
          costPrice: const Value(7000.0),
          salePrice: const Value(10000.0),
          stock: const Value(300),
          lowStockThreshold: const Value(60),
          category: const Value('Nước ngọt'),
        ),
        ProductsCompanion.insert(
          name: 'Pepsi',
          sku: 'PEPSI',
          costPrice: const Value(7000.0),
          salePrice: const Value(10000.0),
          stock: const Value(240),
          lowStockThreshold: const Value(48),
          category: const Value('Nước ngọt'),
        ),
        ProductsCompanion.insert(
          name: 'Aquafina',
          sku: 'AQUA',
          costPrice: const Value(3500.0),
          salePrice: const Value(6000.0),
          stock: const Value(480),
          lowStockThreshold: const Value(96),
          category: const Value('Nước suối'),
        ),
        ProductsCompanion.insert(
          name: 'Oreo',
          sku: 'OREO',
          costPrice: const Value(9000.0),
          salePrice: const Value(12000.0),
          stock: const Value(120),
          lowStockThreshold: const Value(20),
          category: const Value('Bánh kẹo'),
        ),
        ProductsCompanion.insert(
          name: 'Mì Hảo Hảo',
          sku: 'HAOHAO',
          costPrice: const Value(2800.0),
          salePrice: const Value(4000.0),
          stock: const Value(600),
          lowStockThreshold: const Value(120),
          category: const Value('Mì gói'),
        ),
        ProductsCompanion.insert(
          name: 'Sữa Vinamilk',
          sku: 'VINAMILK',
          costPrice: const Value(6000.0),
          salePrice: const Value(9000.0),
          stock: const Value(200),
          lowStockThreshold: const Value(40),
          category: const Value('Sữa'),
        ),
        ProductsCompanion.insert(
          name: 'Khăn giấy',
          sku: 'TISSUE',
          costPrice: const Value(12000.0),
          salePrice: const Value(18000.0),
          stock: const Value(80),
          lowStockThreshold: const Value(15),
          category: const Value('Gia dụng'),
        ),
      ]);
    });

    // Add some example unit conversions for voice ordering / POS demo.
    await _seedDemoProductUnits();
  }

  Future<void> _seedDemoProductUnits() async {
    final lonId = await _ensureUnitIdByKeyOrCreate(name: 'Lon', key: 'lon');
    final chaiId = await _ensureUnitIdByKeyOrCreate(name: 'Chai', key: 'chai');
    final locId = await _ensureUnitIdByKeyOrCreate(name: 'Lốc', key: 'loc');
    final thungId = await _ensureUnitIdByKeyOrCreate(
      name: 'Thùng',
      key: 'thung',
    );
    final goiId = await _ensureUnitIdByKeyOrCreate(name: 'Gói', key: 'goi');
    final hopId = await _ensureUnitIdByKeyOrCreate(name: 'Hộp', key: 'hop');

    final tiger = await (db.select(
      db.products,
    )..where((t) => t.sku.equals('TIGER'))).getSingleOrNull();
    final coca = await (db.select(
      db.products,
    )..where((t) => t.sku.equals('COCA'))).getSingleOrNull();
    final pepsi = await (db.select(
      db.products,
    )..where((t) => t.sku.equals('PEPSI'))).getSingleOrNull();
    final aqua = await (db.select(
      db.products,
    )..where((t) => t.sku.equals('AQUA'))).getSingleOrNull();
    final oreo = await (db.select(
      db.products,
    )..where((t) => t.sku.equals('OREO'))).getSingleOrNull();
    final haohao = await (db.select(
      db.products,
    )..where((t) => t.sku.equals('HAOHAO'))).getSingleOrNull();
    final vinamilk = await (db.select(
      db.products,
    )..where((t) => t.sku.equals('VINAMILK'))).getSingleOrNull();
    final tissue = await (db.select(
      db.products,
    )..where((t) => t.sku.equals('TISSUE'))).getSingleOrNull();

    final now = DateTime.now();

    Future<void> upsertAll(List<ProductUnitsCompanion> rows) async {
      if (rows.isEmpty) return;
      await db.batch((batch) {
        batch.insertAll(db.productUnits, rows, mode: InsertMode.insertOrIgnore);
      });
    }

    await upsertAll([
      if (tiger != null) ...[
        ProductUnitsCompanion.insert(
          productId: tiger.id,
          unitId: lonId,
          factor: const Value(1.0),
          isBase: const Value(true),
          isDefault: const Value(true),
          createdAt: Value(now),
        ),
        ProductUnitsCompanion.insert(
          productId: tiger.id,
          unitId: locId,
          factor: const Value(6.0),
          isBase: const Value(false),
          isDefault: const Value(false),
          createdAt: Value(now),
        ),
        ProductUnitsCompanion.insert(
          productId: tiger.id,
          unitId: thungId,
          factor: const Value(24.0),
          isBase: const Value(false),
          isDefault: const Value(false),
          createdAt: Value(now),
        ),
      ],
      if (coca != null) ...[
        ProductUnitsCompanion.insert(
          productId: coca.id,
          unitId: lonId,
          factor: const Value(1.0),
          isBase: const Value(true),
          isDefault: const Value(true),
          createdAt: Value(now),
        ),
        ProductUnitsCompanion.insert(
          productId: coca.id,
          unitId: locId,
          factor: const Value(6.0),
          isBase: const Value(false),
          isDefault: const Value(false),
          createdAt: Value(now),
        ),
        ProductUnitsCompanion.insert(
          productId: coca.id,
          unitId: thungId,
          factor: const Value(24.0),
          isBase: const Value(false),
          isDefault: const Value(false),
          createdAt: Value(now),
        ),
      ],
      if (pepsi != null) ...[
        ProductUnitsCompanion.insert(
          productId: pepsi.id,
          unitId: lonId,
          factor: const Value(1.0),
          isBase: const Value(true),
          isDefault: const Value(true),
          createdAt: Value(now),
        ),
        ProductUnitsCompanion.insert(
          productId: pepsi.id,
          unitId: locId,
          factor: const Value(6.0),
          isBase: const Value(false),
          isDefault: const Value(false),
          createdAt: Value(now),
        ),
        ProductUnitsCompanion.insert(
          productId: pepsi.id,
          unitId: thungId,
          factor: const Value(24.0),
          isBase: const Value(false),
          isDefault: const Value(false),
          createdAt: Value(now),
        ),
      ],
      if (aqua != null) ...[
        ProductUnitsCompanion.insert(
          productId: aqua.id,
          unitId: chaiId,
          factor: const Value(1.0),
          isBase: const Value(true),
          isDefault: const Value(true),
          createdAt: Value(now),
        ),
        ProductUnitsCompanion.insert(
          productId: aqua.id,
          unitId: thungId,
          factor: const Value(24.0),
          isBase: const Value(false),
          isDefault: const Value(false),
          createdAt: Value(now),
        ),
      ],
      if (oreo != null)
        ProductUnitsCompanion.insert(
          productId: oreo.id,
          unitId: goiId,
          factor: const Value(1.0),
          isBase: const Value(true),
          isDefault: const Value(true),
          createdAt: Value(now),
        ),
      if (haohao != null)
        ProductUnitsCompanion.insert(
          productId: haohao.id,
          unitId: goiId,
          factor: const Value(1.0),
          isBase: const Value(true),
          isDefault: const Value(true),
          createdAt: Value(now),
        ),
      if (vinamilk != null)
        ProductUnitsCompanion.insert(
          productId: vinamilk.id,
          unitId: hopId,
          factor: const Value(1.0),
          isBase: const Value(true),
          isDefault: const Value(true),
          createdAt: Value(now),
        ),
      if (tissue != null)
        ProductUnitsCompanion.insert(
          productId: tissue.id,
          unitId: hopId,
          factor: const Value(1.0),
          isBase: const Value(true),
          isDefault: const Value(true),
          createdAt: Value(now),
        ),
    ]);
  }

  Future<void> _seedDemoCustomersIfNeeded() async {
    final hasCustomer = await db.select(db.customers).getSingleOrNull();
    if (hasCustomer != null) return;

    await db.batch((batch) {
      batch.insertAll(db.customers, [
        CustomersCompanion.insert(
          name: 'Nguyễn Văn A',
          phone: const Value('0900000001'),
          email: const Value('a@demo.local'),
          tier: const Value('Bronze'),
          points: const Value(0),
        ),
        CustomersCompanion.insert(
          name: 'Trần Thị B',
          phone: const Value('0900000002'),
          email: const Value('b@demo.local'),
          tier: const Value('Silver'),
          points: const Value(0),
        ),
        CustomersCompanion.insert(
          name: 'Lê Văn C',
          phone: const Value('0900000003'),
          email: const Value('c@demo.local'),
          tier: const Value('Gold'),
          points: const Value(0),
        ),
      ]);
    });
  }

  Future<void> _seedDemoOrdersAndPaymentsIfNeeded() async {
    final hasOrder = await db.select(db.orders).getSingleOrNull();
    if (hasOrder != null) return;

    final products = await db.select(db.products).get();
    if (products.isEmpty) return;

    final customers = await db.select(db.customers).get();
    final customerIds = customers.map((c) => c.id).toList(growable: false);

    // Helper to lookup product by SKU (seed uses stable SKUs).
    ProductRow? bySku(String sku) {
      for (final p in products) {
        if (p.sku == sku) return p;
      }
      return null;
    }

    final tiger = bySku('TIGER') ?? products.first;
    final coca = bySku('COCA') ?? products[products.length > 1 ? 1 : 0];
    final haohao = bySku('HAOHAO');

    final lonUnitId = await (db.select(
      db.units,
    )..where((t) => t.key.equals('lon'))).getSingleOrNull();
    final thungUnitId = await (db.select(
      db.units,
    )..where((t) => t.key.equals('thung'))).getSingleOrNull();

    final now = DateTime.now();

    // Seed 12 orders in the last 12 days.
    for (var i = 0; i < 12; i++) {
      final createdAt = now.subtract(Duration(days: 12 - i));

      final items = <Map<String, dynamic>>[];

      // Tiger: sometimes by thùng, otherwise by lon.
      final tigerByThung = i % 4 == 0 && thungUnitId != null;
      final tigerQty = tigerByThung ? 1 : (1 + (i % 3));
      final tigerFactor = tigerByThung ? 24.0 : 1.0;
      final tigerUnitId = tigerByThung ? thungUnitId.id : lonUnitId?.id;
      final tigerUnitName = tigerByThung ? 'Thùng' : (lonUnitId?.name ?? 'Lon');
      final tigerPrice = tiger.salePrice * tigerFactor;
      items.add({
        'productId': tiger.id,
        'quantity': tigerQty,
        'price': tigerPrice,
        if (tigerUnitId != null) 'unitId': tigerUnitId,
        if (tigerFactor != 1.0) 'unitFactor': tigerFactor,
        'unitName': tigerUnitName,
      });

      // Coca: always by lon.
      final cocaQty = 1 + ((i + 1) % 2);
      final cocaPrice = coca.salePrice;
      items.add({
        'productId': coca.id,
        'quantity': cocaQty,
        'price': cocaPrice,
        if (lonUnitId != null) 'unitId': lonUnitId.id,
        'unitName': lonUnitId?.name ?? 'Lon',
      });

      // Optional 3rd item: mì gói.
      if (haohao != null && i.isOdd) {
        final qty = 3 + (i % 4);
        items.add({
          'productId': haohao.id,
          'quantity': qty,
          'price': haohao.salePrice,
        });
      }

      final total = items.fold<double>(
        0.0,
        (sum, it) =>
            sum + ((it['price'] as num).toDouble() * (it['quantity'] as int)),
      );
      final pointsDelta = (total / 10000).floor();

      final orderId = await db
          .into(db.orders)
          .insert(
            OrdersCompanion.insert(
              createdAt: Value(createdAt),
              totalAmount: Value(total),
              customerId: customerIds.isEmpty
                  ? const Value.absent()
                  : Value(customerIds[i % customerIds.length]),
              pointsDelta: Value(pointsDelta),
              itemsJson: Value(jsonEncode(items)),
              changeAmount: const Value(0.0),
            ),
          );

      // Payment: mix methods for analytics demo.
      final method = switch (i % 3) {
        0 => PaymentMethod.cash,
        1 => PaymentMethod.card,
        _ => PaymentMethod.ewallet,
      };
      await db
          .into(db.payments)
          .insert(
            PaymentsCompanion.insert(
              orderId: orderId,
              methodValue: method.index,
              value: const Value(0.0),
              amount: Value(total),
              createdAt: Value(createdAt),
            ),
          );

      // Reduce stock in base units (unitFactor default 1.0).
      for (final it in items) {
        final productId = (it['productId'] as num).toInt();
        final qty = (it['quantity'] as num).toInt();
        final factor = (it['unitFactor'] as num?)?.toDouble() ?? 1.0;
        final delta = -(qty * factor).round();
        final row = await (db.select(
          db.products,
        )..where((t) => t.id.equals(productId))).getSingleOrNull();
        if (row == null) continue;
        await (db.update(db.products)..where((t) => t.id.equals(productId)))
            .write(ProductsCompanion(stock: Value(row.stock + delta)));
      }
    }
  }
}
