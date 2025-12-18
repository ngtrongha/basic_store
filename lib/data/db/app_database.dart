import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AuditLogs,
    Customers,
    GoodsReceipts,
    Orders,
    Payments,
    ProductBundles,
    ProductPrices,
    Products,
    ProductUnits,
    ProductVariants,
    Promotions,
    PurchaseOrders,
    Returns,
    StockAdjustments,
    StockTransfers,
    Stores,
    Suppliers,
    Units,
    Users,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // v2 adds Units and ProductUnits.
      if (from < 2) {
        await m.createTable(units);
        await m.createTable(productUnits);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}${Platform.pathSeparator}basic_store.sqlite');
    return NativeDatabase.createInBackground(file);
  });
}
