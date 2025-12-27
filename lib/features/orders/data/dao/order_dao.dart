import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart' hide Order;

import '../../../../core/database/app_database.dart';

part 'order_dao.g.dart';

/// Data Access Object for Orders
@lazySingleton
@DriftAccessor(tables: [Orders, OrderItems, Products, Customers])
class OrderDao extends DatabaseAccessor<AppDatabase> with _$OrderDaoMixin {
  OrderDao(super.db);

  /// Generate order number
  Future<String> generateOrderNumber() async {
    final now = DateTime.now();
    final dateStr =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final count =
        await (selectOnly(orders)
              ..addColumns([orders.id.count()])
              ..where(
                orders.createdAt.isBiggerOrEqualValue(
                  DateTime(now.year, now.month, now.day),
                ),
              ))
            .getSingle();
    final orderCount = (count.read(orders.id.count()) ?? 0) + 1;
    return 'ORD-$dateStr-${orderCount.toString().padLeft(3, '0')}';
  }

  /// Get all orders
  Future<List<Order>> getAllOrders() {
    return (select(
      orders,
    )..orderBy([(o) => OrderingTerm.desc(o.createdAt)])).get();
  }

  /// Get orders by date range
  Future<List<Order>> getOrdersByDateRange(DateTime start, DateTime end) {
    return (select(orders)
          ..where((o) => o.createdAt.isBetweenValues(start, end))
          ..orderBy([(o) => OrderingTerm.desc(o.createdAt)]))
        .get();
  }

  /// Get today's orders
  Future<List<Order>> getTodaysOrders() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return getOrdersByDateRange(startOfDay, endOfDay);
  }

  /// Get order by ID
  Future<Order?> getOrderById(int id) {
    return (select(orders)..where((o) => o.id.equals(id))).getSingleOrNull();
  }

  /// Get order items for an order
  Future<List<OrderItem>> getOrderItems(int orderId) {
    return (select(orderItems)..where((i) => i.orderId.equals(orderId))).get();
  }

  /// Create order with items
  Future<int> createOrder({
    required String orderNumber,
    int? customerId,
    required double subtotal,
    double discount = 0,
    required double total,
    double paidAmount = 0,
    String paymentMethod = 'cash',
    String? note,
    required List<OrderItemData> items,
  }) async {
    return transaction(() async {
      // Insert order
      final orderId = await into(orders).insert(
        OrdersCompanion.insert(
          orderNumber: orderNumber,
          customerId: Value(customerId),
          subtotal: subtotal,
          discount: Value(discount),
          total: total,
          paidAmount: Value(paidAmount),
          paymentMethod: Value(paymentMethod),
          note: Value(note),
        ),
      );

      // Insert order items
      for (final item in items) {
        await into(orderItems).insert(
          OrderItemsCompanion.insert(
            orderId: orderId,
            productId: item.productId,
            productName: item.productName,
            price: item.price,
            quantity: item.quantity,
            subtotal: item.subtotal,
          ),
        );

        // Update product quantity - get current quantity first
        final product = await (select(
          products,
        )..where((p) => p.id.equals(item.productId))).getSingleOrNull();
        if (product != null) {
          final newQuantity = product.quantity - item.quantity;
          await (update(
            products,
          )..where((p) => p.id.equals(item.productId))).write(
            ProductsCompanion(
              quantity: Value(newQuantity < 0 ? 0 : newQuantity),
            ),
          );
        }
      }

      return orderId;
    });
  }

  /// Get total revenue for today
  Future<double> getTodaysRevenue() async {
    final todaysOrders = await getTodaysOrders();
    double total = 0.0;
    for (final order in todaysOrders) {
      total += order.total;
    }
    return total;
  }

  /// Get order count for today
  Future<int> getTodaysOrderCount() async {
    final todaysOrders = await getTodaysOrders();
    return todaysOrders.length;
  }

  /// Watch all orders (stream)
  Stream<List<Order>> watchAllOrders() {
    return (select(
      orders,
    )..orderBy([(o) => OrderingTerm.desc(o.createdAt)])).watch();
  }
}

/// Order item data for creating orders
class OrderItemData {
  final int productId;
  final String productName;
  final double price;
  final int quantity;
  final double subtotal;

  OrderItemData({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.subtotal,
  });
}
