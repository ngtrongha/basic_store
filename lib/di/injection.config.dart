// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:basic_store/data/db/app_database.dart' as _i378;
import 'package:basic_store/data/repositories/audit_log_repository.dart'
    as _i13;
import 'package:basic_store/data/repositories/customer_repository.dart'
    as _i1029;
import 'package:basic_store/data/repositories/goods_receipt_repository.dart'
    as _i891;
import 'package:basic_store/data/repositories/order_repository.dart' as _i325;
import 'package:basic_store/data/repositories/payment_repository.dart' as _i513;
import 'package:basic_store/data/repositories/product_bundle_repository.dart'
    as _i832;
import 'package:basic_store/data/repositories/product_price_repository.dart'
    as _i660;
import 'package:basic_store/data/repositories/product_repository.dart'
    as _i1036;
import 'package:basic_store/data/repositories/product_unit_repository.dart'
    as _i378;
import 'package:basic_store/data/repositories/product_variant_repository.dart'
    as _i784;
import 'package:basic_store/data/repositories/purchase_order_repository.dart'
    as _i112;
import 'package:basic_store/data/repositories/return_repository.dart' as _i511;
import 'package:basic_store/data/repositories/stock_adjustment_repository.dart'
    as _i64;
import 'package:basic_store/data/repositories/stock_transfer_repository.dart'
    as _i382;
import 'package:basic_store/data/repositories/store_repository.dart' as _i323;
import 'package:basic_store/data/repositories/supplier_repository.dart'
    as _i1018;
import 'package:basic_store/data/repositories/unit_repository.dart' as _i26;
import 'package:basic_store/data/repositories/user_repository.dart' as _i307;
import 'package:basic_store/data/services/auth_service.dart' as _i774;
import 'package:basic_store/data/services/inventory_service.dart' as _i419;
import 'package:basic_store/data/services/invoice_service.dart' as _i182;
import 'package:basic_store/data/services/multi_store_service.dart' as _i67;
import 'package:basic_store/data/services/purchasing_service.dart' as _i831;
import 'package:basic_store/data/services/reporting_service.dart' as _i1019;
import 'package:basic_store/data/services/return_service.dart' as _i324;
import 'package:basic_store/di/app_module.dart' as _i866;
import 'package:basic_store/router/app_router.dart' as _i111;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker/talker.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i993.Talker>(() => appModule.talker);
    gh.lazySingleton<_i111.AppRouter>(() => appModule.appRouter);
    gh.lazySingleton<_i378.AppDatabase>(() => appModule.database);
    gh.lazySingleton<_i1036.ProductRepository>(
      () => appModule.productRepository,
    );
    gh.lazySingleton<_i1029.CustomerRepository>(
      () => appModule.customerRepository,
    );
    gh.lazySingleton<_i325.OrderRepository>(() => appModule.orderRepository);
    gh.lazySingleton<_i513.PaymentRepository>(
      () => appModule.paymentRepository,
    );
    gh.lazySingleton<_i307.UserRepository>(() => appModule.userRepository);
    gh.lazySingleton<_i1018.SupplierRepository>(
      () => appModule.supplierRepository,
    );
    gh.lazySingleton<_i323.StoreRepository>(() => appModule.storeRepository);
    gh.lazySingleton<_i26.UnitRepository>(() => appModule.unitRepository);
    gh.lazySingleton<_i378.ProductUnitRepository>(
      () => appModule.productUnitRepository,
    );
    gh.lazySingleton<_i784.ProductVariantRepository>(
      () => appModule.productVariantRepository,
    );
    gh.lazySingleton<_i660.ProductPriceRepository>(
      () => appModule.productPriceRepository,
    );
    gh.lazySingleton<_i832.ProductBundleRepository>(
      () => appModule.productBundleRepository,
    );
    gh.lazySingleton<_i64.StockAdjustmentRepository>(
      () => appModule.stockAdjustmentRepository,
    );
    gh.lazySingleton<_i382.StockTransferRepository>(
      () => appModule.stockTransferRepository,
    );
    gh.lazySingleton<_i891.GoodsReceiptRepository>(
      () => appModule.goodsReceiptRepository,
    );
    gh.lazySingleton<_i112.PurchaseOrderRepository>(
      () => appModule.purchaseOrderRepository,
    );
    gh.lazySingleton<_i511.ReturnRepository>(() => appModule.returnRepository);
    gh.lazySingleton<_i13.AuditLogRepository>(
      () => appModule.auditLogRepository,
    );
    gh.lazySingleton<_i774.AuthService>(() => appModule.authService);
    gh.lazySingleton<_i419.InventoryService>(() => appModule.inventoryService);
    gh.lazySingleton<_i182.InvoiceService>(() => appModule.invoiceService);
    gh.lazySingleton<_i1019.ReportingService>(() => appModule.reportingService);
    gh.lazySingleton<_i324.ReturnService>(() => appModule.returnService);
    gh.lazySingleton<_i831.PurchasingService>(
      () => appModule.purchasingService,
    );
    gh.lazySingleton<_i67.MultiStoreService>(() => appModule.multiStoreService);
    return this;
  }
}

class _$AppModule extends _i866.AppModule {}
