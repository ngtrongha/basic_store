import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';

import '../data/db/app_database.dart';
import '../data/repositories/audit_log_repository.dart';
import '../data/repositories/customer_repository.dart';
import '../data/repositories/goods_receipt_repository.dart';
import '../data/repositories/order_repository.dart';
import '../data/repositories/payment_repository.dart';
import '../data/repositories/product_bundle_repository.dart';
import '../data/repositories/product_price_repository.dart';
import '../data/repositories/product_repository.dart';
import '../data/repositories/product_unit_repository.dart';
import '../data/repositories/product_variant_repository.dart';
import '../data/repositories/purchase_order_repository.dart';
import '../data/repositories/return_repository.dart';
import '../data/repositories/stock_adjustment_repository.dart';
import '../data/repositories/stock_transfer_repository.dart';
import '../data/repositories/store_repository.dart';
import '../data/repositories/supplier_repository.dart';
import '../data/repositories/unit_repository.dart';
import '../data/repositories/user_repository.dart';
import '../data/services/auth_service.dart';
import '../data/services/inventory_service.dart';
import '../data/services/invoice_service.dart';
import '../data/services/multi_store_service.dart';
import '../data/services/purchasing_service.dart';
import '../data/services/reporting_service.dart';
import '../data/services/return_service.dart';
import '../router/app_router.dart';

@module
abstract class AppModule {
  // ============ Core ============
  @lazySingleton
  Talker get talker => Talker();

  @lazySingleton
  AppRouter get appRouter => AppRouter();

  @lazySingleton
  AppDatabase get database => AppDatabase();

  // ============ Repositories ============
  @lazySingleton
  ProductRepository get productRepository => ProductRepository();

  @lazySingleton
  CustomerRepository get customerRepository => CustomerRepository();

  @lazySingleton
  OrderRepository get orderRepository => OrderRepository();

  @lazySingleton
  PaymentRepository get paymentRepository => PaymentRepository();

  @lazySingleton
  UserRepository get userRepository => UserRepository();

  @lazySingleton
  SupplierRepository get supplierRepository => SupplierRepository();

  @lazySingleton
  StoreRepository get storeRepository => StoreRepository();

  @lazySingleton
  UnitRepository get unitRepository => UnitRepository();

  @lazySingleton
  ProductUnitRepository get productUnitRepository => ProductUnitRepository();

  @lazySingleton
  ProductVariantRepository get productVariantRepository =>
      ProductVariantRepository();

  @lazySingleton
  ProductPriceRepository get productPriceRepository => ProductPriceRepository();

  @lazySingleton
  ProductBundleRepository get productBundleRepository =>
      ProductBundleRepository();

  @lazySingleton
  StockAdjustmentRepository get stockAdjustmentRepository =>
      StockAdjustmentRepository();

  @lazySingleton
  StockTransferRepository get stockTransferRepository =>
      StockTransferRepository();

  @lazySingleton
  GoodsReceiptRepository get goodsReceiptRepository => GoodsReceiptRepository();

  @lazySingleton
  PurchaseOrderRepository get purchaseOrderRepository =>
      PurchaseOrderRepository();

  @lazySingleton
  ReturnRepository get returnRepository => ReturnRepository();

  @lazySingleton
  AuditLogRepository get auditLogRepository => AuditLogRepository();

  // ============ Services ============
  @lazySingleton
  AuthService get authService => AuthService();

  @lazySingleton
  InventoryService get inventoryService => InventoryService();

  @lazySingleton
  InvoiceService get invoiceService => InvoiceService();

  @lazySingleton
  ReportingService get reportingService => ReportingService();

  @lazySingleton
  ReturnService get returnService => ReturnService();

  @lazySingleton
  PurchasingService get purchasingService => PurchasingService();

  @lazySingleton
  MultiStoreService get multiStoreService => MultiStoreService();
}
