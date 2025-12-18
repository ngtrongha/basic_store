import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product.dart';
import '../../data/repositories/customer_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/inventory_service.dart';
import '../../di/injection.dart';
import 'dashboard_state.dart';

final dashboardControllerProvider =
    NotifierProvider<DashboardController, DashboardState>(
      DashboardController.new,
    );

class DashboardController extends Notifier<DashboardState> {
  ProductRepository get _productRepo => getIt<ProductRepository>();
  OrderRepository get _orderRepo => getIt<OrderRepository>();
  CustomerRepository get _customerRepo => getIt<CustomerRepository>();
  InventoryService get _inventoryService => getIt<InventoryService>();
  AuthService get _authService => getIt<AuthService>();

  @override
  DashboardState build() {
    Future.microtask(_loadData);
    return DashboardState.initial();
  }

  Future<void> _loadData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final currentUser = await _authService.getCurrentUser();
      final products = await _productRepo.getAll(limit: 1000);
      final orders = await _orderRepo.getAll(limit: 1000);
      final customers = await _customerRepo.getAll();
      final summary = await _inventoryService.getInventorySummary();

      final totalRevenue = orders.fold<double>(
        0,
        (sum, order) => sum + order.totalAmount,
      );

      // Tính doanh thu hôm nay
      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);
      final todayOrders = orders.where((order) {
        return order.createdAt.isAfter(todayStart);
      }).toList();

      final todayRevenue = todayOrders.fold<double>(
        0,
        (sum, order) => sum + order.totalAmount,
      );

      // Sản phẩm mới thêm (5 sản phẩm gần nhất)
      final recentProducts = products.take(5).toList();

      // Sản phẩm sắp hết hàng
      final lowStockProducts = products
          .where((p) => p.stock <= p.lowStockThreshold && p.stock > 0)
          .take(5)
          .toList();

      // Sản phẩm bán chạy (tính từ orders)
      final bestSellingProducts = _calculateBestSellers(orders, products);

      state = state.copyWith(
        isLoading: false,
        currentUser: currentUser,
        totalProducts: products.length,
        totalOrders: orders.length,
        totalRevenue: totalRevenue,
        lowStockCount: summary['lowStockCount'] as int,
        totalCustomers: customers.length,
        todayRevenue: todayRevenue,
        todayOrders: todayOrders.length,
        recentProducts: recentProducts,
        lowStockProducts: lowStockProducts,
        bestSellingProducts: bestSellingProducts,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Không thể tải dữ liệu. Vui lòng thử lại.',
      );
    }
  }

  List<ProductSalesInfo> _calculateBestSellers(
    List orders,
    List<Product> products,
  ) {
    final salesMap = <int, _SalesData>{};

    for (final order in orders) {
      for (final item in order.items) {
        final productId = item.productId;
        if (!salesMap.containsKey(productId)) {
          salesMap[productId] = _SalesData();
        }
        salesMap[productId]!.quantity += item.quantity;
        salesMap[productId]!.revenue += item.price * item.quantity;
      }
    }

    final productMap = {for (var p in products) p.id: p};

    final result = salesMap.entries
        .where((e) => productMap.containsKey(e.key))
        .map(
          (e) => ProductSalesInfo(
            product: productMap[e.key]!,
            soldQuantity: e.value.quantity.toInt(),
            totalRevenue: e.value.revenue.toDouble(),
          ),
        )
        .toList();

    result.sort((a, b) => b.soldQuantity.compareTo(a.soldQuantity));

    return result.take(5).toList();
  }

  Future<void> refresh() async {
    await _loadData();
  }

  Future<void> logout() async {
    await _authService.logout();
    state = state.copyWith(currentUser: null);
  }
}

class _SalesData {
  num quantity = 0;
  num revenue = 0;
}
