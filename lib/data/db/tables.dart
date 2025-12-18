import 'package:drift/drift.dart';

@DataClassName('AuditLogRow')
class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().named('user_id').nullable()();
  TextColumn get action => text()();
  TextColumn get details => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

@DataClassName('CustomerRow')
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable().unique()();
  TextColumn get email => text().nullable().unique()();
  TextColumn get tier => text().nullable()();
  IntColumn get points => integer().withDefault(const Constant(0))();
}

@DataClassName('GoodsReceiptRow')
class GoodsReceipts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get supplierId => integer().named('supplier_id')();
  IntColumn get purchaseOrderId =>
      integer().named('purchase_order_id').nullable()();
  DateTimeColumn get receivedAt =>
      dateTime().named('received_at').withDefault(currentDateAndTime)();
  TextColumn get itemsJson =>
      text().named('items_json').withDefault(const Constant('[]'))();
  TextColumn get notes => text().nullable()();
}

@DataClassName('OrderRow')
class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
  RealColumn get totalAmount =>
      real().named('total_amount').withDefault(const Constant(0.0))();
  IntColumn get customerId => integer().named('customer_id').nullable()();
  IntColumn get pointsDelta =>
      integer().named('points_delta').withDefault(const Constant(0))();
  TextColumn get itemsJson =>
      text().named('items_json').withDefault(const Constant('[]'))();
  RealColumn get changeAmount =>
      real().named('change_amount').withDefault(const Constant(0.0))();
}

@DataClassName('PaymentRow')
class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer().named('order_id')();
  IntColumn get methodValue => integer().named('method_value')();
  RealColumn get value => real().withDefault(const Constant(0.0))();
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

@DataClassName('ProductBundleRow')
class ProductBundles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get sku => text().nullable()();
  RealColumn get price => real().withDefault(const Constant(0.0))();
  TextColumn get itemsJson =>
      text().named('items_json').withDefault(const Constant('[]'))();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

@DataClassName('ProductPriceRow')
class ProductPrices extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().named('product_id')();
  IntColumn get storeId => integer().named('store_id')();
  RealColumn get price => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
  DateTimeColumn get validFrom => dateTime().named('valid_from').nullable()();
  DateTimeColumn get validTo => dateTime().named('valid_to').nullable()();
}

@DataClassName('ProductRow')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get sku => text().unique()();
  RealColumn get costPrice =>
      real().named('cost_price').withDefault(const Constant(0.0))();
  RealColumn get salePrice =>
      real().named('sale_price').withDefault(const Constant(0.0))();
  IntColumn get stock => integer().withDefault(const Constant(0))();
  IntColumn get lowStockThreshold =>
      integer().named('low_stock_threshold').withDefault(const Constant(0))();
  TextColumn get category => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get barcode => text().nullable()();
}

@DataClassName('UnitRow')
class Units extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  /// Normalized key (e.g. "thung", "lon", "cai") used for matching/search.
  TextColumn get key => text().unique()();

  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

@DataClassName('ProductUnitRow')
class ProductUnits extends Table {
  IntColumn get productId =>
      integer().named('product_id').references(Products, #id)();
  IntColumn get unitId => integer().named('unit_id').references(Units, #id)();

  /// Number of base units per 1 of this unit.
  RealColumn get factor => real().withDefault(const Constant(1.0))();

  BoolColumn get isBase =>
      boolean().named('is_base').withDefault(const Constant(false))();
  BoolColumn get isDefault =>
      boolean().named('is_default').withDefault(const Constant(false))();

  /// Optional override sale price for this unit.
  RealColumn get priceOverride => real().named('price_override').nullable()();

  /// Optional per-unit SKU/barcode for scanning.
  TextColumn get sku => text().nullable().unique()();
  TextColumn get barcode => text().nullable().unique()();

  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {productId, unitId};
}

@DataClassName('ProductVariantRow')
class ProductVariants extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().named('product_id')();
  TextColumn get size => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get sku => text().nullable()();
  RealColumn get priceOverride => real().named('price_override').nullable()();
  IntColumn get stock => integer().withDefault(const Constant(0))();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

@DataClassName('PromotionRow')
class Promotions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get couponCode => text().named('coupon_code').nullable()();
  IntColumn get typeValue => integer().named('type_value')();
  RealColumn get value => real().withDefault(const Constant(0.0))();
  DateTimeColumn get startAt => dateTime().named('start_at').nullable()();
  DateTimeColumn get endAt => dateTime().named('end_at').nullable()();
}

@DataClassName('PurchaseOrderRow')
class PurchaseOrders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get supplierId => integer().named('supplier_id')();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
  TextColumn get status => text().withDefault(const Constant('open'))();
  TextColumn get itemsJson =>
      text().named('items_json').withDefault(const Constant('[]'))();
}

@DataClassName('ReturnRow')
class Returns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get originalOrderId => integer().named('original_order_id')();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
  TextColumn get reason => text().withDefault(const Constant(''))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  RealColumn get refundAmount =>
      real().named('refund_amount').withDefault(const Constant(0.0))();
  TextColumn get itemsJson =>
      text().named('items_json').withDefault(const Constant('[]'))();
  IntColumn get customerId => integer().named('customer_id').nullable()();
}

@DataClassName('StockAdjustmentRow')
class StockAdjustments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().named('product_id')();
  IntColumn get delta => integer()();
  TextColumn get reason => text().withDefault(const Constant(''))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
  TextColumn get batchNumber => text().named('batch_number').nullable()();
  DateTimeColumn get expiryDate => dateTime().named('expiry_date').nullable()();
}

@DataClassName('StockTransferRow')
class StockTransfers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fromStoreId => integer().named('from_store_id')();
  IntColumn get toStoreId => integer().named('to_store_id')();
  IntColumn get productId => integer().named('product_id')();
  IntColumn get quantity => integer()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt =>
      dateTime().named('completed_at').nullable()();
}

@DataClassName('StoreRow')
class Stores extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get address => text().withDefault(const Constant(''))();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

@DataClassName('SupplierRow')
class Suppliers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get contactName => text().named('contact_name').nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

@DataClassName('UserRow')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  TextColumn get password => text()();
  IntColumn get roleValue => integer().named('role_value')();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}
