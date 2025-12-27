import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/database/app_database.dart';
import '../../data/dao/order_dao.dart';

/// Order DAO provider
final orderDaoProvider = Provider<OrderDao>((ref) {
  return getIt<OrderDao>();
});

/// Cart item model for creating orders
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get subtotal => product.price * quantity;
}

/// Cart notifier (Riverpod 3.0 pattern)
class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addProduct(Product product) {
    final existingIndex = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
      // Increase quantity
      final newState = [...state];
      newState[existingIndex].quantity++;
      state = newState;
    } else {
      // Add new item
      state = [...state, CartItem(product: product)];
    }
  }

  void removeProduct(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeProduct(productId);
      return;
    }

    final newState = state.map((item) {
      if (item.product.id == productId) {
        return CartItem(product: item.product, quantity: quantity);
      }
      return item;
    }).toList();
    state = newState;
  }

  void increaseQuantity(int productId) {
    final newState = state.map((item) {
      if (item.product.id == productId) {
        return CartItem(product: item.product, quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    state = newState;
  }

  void decreaseQuantity(int productId) {
    final item = state.firstWhere((item) => item.product.id == productId);
    if (item.quantity <= 1) {
      removeProduct(productId);
    } else {
      final newState = state.map((item) {
        if (item.product.id == productId) {
          return CartItem(product: item.product, quantity: item.quantity - 1);
        }
        return item;
      }).toList();
      state = newState;
    }
  }

  void clear() => state = [];

  double get subtotal => state.fold(0.0, (sum, item) => sum + item.subtotal);

  int get totalItems => state.fold(0, (sum, item) => sum + item.quantity);
}

/// Cart provider
final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);

/// Selected customer for order (Riverpod 3.0 pattern)
class SelectedCustomerNotifier extends Notifier<Customer?> {
  @override
  Customer? build() => null;

  void select(Customer customer) => state = customer;
  void clear() => state = null;
}

/// Selected customer provider
final selectedCustomerProvider =
    NotifierProvider<SelectedCustomerNotifier, Customer?>(
      SelectedCustomerNotifier.new,
    );

/// Order discount notifier (Riverpod 3.0 pattern)
class OrderDiscountNotifier extends Notifier<double> {
  @override
  double build() => 0;

  void setDiscount(double discount) => state = discount;
  void clear() => state = 0;
}

/// Order discount provider
final orderDiscountProvider = NotifierProvider<OrderDiscountNotifier, double>(
  OrderDiscountNotifier.new,
);

/// Orders list notifier (Riverpod 3.0 pattern)
class OrdersNotifier extends Notifier<AsyncValue<List<Order>>> {
  late OrderDao _dao;

  @override
  AsyncValue<List<Order>> build() {
    _dao = ref.watch(orderDaoProvider);
    _loadOrders();
    return const AsyncValue.loading();
  }

  Future<void> _loadOrders() async {
    state = const AsyncValue.loading();
    try {
      final orders = await _dao.getAllOrders();
      state = AsyncValue.data(orders);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _loadOrders();

  Future<void> loadTodaysOrders() async {
    state = const AsyncValue.loading();
    try {
      final orders = await _dao.getTodaysOrders();
      state = AsyncValue.data(orders);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Orders list provider
final ordersProvider =
    NotifierProvider<OrdersNotifier, AsyncValue<List<Order>>>(
      OrdersNotifier.new,
    );

/// Today's stats notifier (Riverpod 3.0 pattern)
class TodaysStatsNotifier extends Notifier<AsyncValue<TodaysStats>> {
  late OrderDao _dao;

  @override
  AsyncValue<TodaysStats> build() {
    _dao = ref.watch(orderDaoProvider);
    _loadStats();
    return const AsyncValue.loading();
  }

  Future<void> _loadStats() async {
    state = const AsyncValue.loading();
    try {
      final revenue = await _dao.getTodaysRevenue();
      final orderCount = await _dao.getTodaysOrderCount();
      state = AsyncValue.data(
        TodaysStats(revenue: revenue, orderCount: orderCount),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _loadStats();
}

/// Today's stats provider
final todaysStatsProvider =
    NotifierProvider<TodaysStatsNotifier, AsyncValue<TodaysStats>>(
      TodaysStatsNotifier.new,
    );

/// Today's stats model
class TodaysStats {
  final double revenue;
  final int orderCount;

  TodaysStats({required this.revenue, required this.orderCount});
}
