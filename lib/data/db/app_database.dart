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
    ProductVariants,
    Promotions,
    PurchaseOrders,
    Returns,
    StockAdjustments,
    StockTransfers,
    Stores,
    Suppliers,
    Users,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}${Platform.pathSeparator}basic_store.sqlite');
    return NativeDatabase.createInBackground(file);
  });
}
