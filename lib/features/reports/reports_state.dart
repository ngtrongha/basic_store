import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/product.dart';

part 'reports_state.freezed.dart';

@freezed
abstract class ReportsState with _$ReportsState {
  const factory ReportsState({
    @Default(true) bool isLoading,
    @Default(false) bool isExporting,
    required DateTime startDate,
    required DateTime endDate,
    @Default(0.0) double totalRevenue,
    @Default(0) int totalOrders,
    @Default(0.0) double averageOrderValue,
    @Default([]) List<TopProductInfo> topProducts,
    String? errorMessage,
  }) = _ReportsState;

  factory ReportsState.initial() => ReportsState(
    startDate: DateTime.now().subtract(const Duration(days: 30)),
    endDate: DateTime.now(),
  );
}

class TopProductInfo {
  final Product product;
  final int quantity;
  final double revenue;
  final double margin;
  final double marginPercent;

  const TopProductInfo({
    required this.product,
    required this.quantity,
    required this.revenue,
    required this.margin,
    required this.marginPercent,
  });
}
