import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/product.dart';
import '../../data/models/user.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(true) bool isLoading,
    @Default(0) int totalProducts,
    @Default(0) int totalOrders,
    @Default(0.0) double totalRevenue,
    @Default(0) int lowStockCount,
    @Default(0) int totalCustomers,
    @Default(0.0) double todayRevenue,
    @Default(0) int todayOrders,
    AppUser? currentUser,
    String? errorMessage,
    // Product lists
    @Default([]) List<Product> recentProducts,
    @Default([]) List<Product> lowStockProducts,
    @Default([]) List<ProductSalesInfo> bestSellingProducts,
  }) = _DashboardState;

  factory DashboardState.initial() => const DashboardState();
}

class ProductSalesInfo {
  final Product product;
  final int soldQuantity;
  final double totalRevenue;

  const ProductSalesInfo({
    required this.product,
    required this.soldQuantity,
    required this.totalRevenue,
  });
}
