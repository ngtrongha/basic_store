import '../repositories/order_repository.dart';
import '../repositories/product_repository.dart';
import '../repositories/customer_repository.dart';
import '../repositories/payment_repository.dart';
import '../models/product.dart';

class AdvancedReportingService {
  final _orderRepo = OrderRepository();
  final _productRepo = ProductRepository();
  final _customerRepo = CustomerRepository();
  final _paymentRepo = PaymentRepository();

  // Sales Analytics
  Future<Map<String, dynamic>> getSalesAnalytics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final orders = await _orderRepo.getByDateRange(
      startDate ?? DateTime.now().subtract(const Duration(days: 30)),
      endDate ?? DateTime.now(),
    );

    if (orders.isEmpty) {
      return {
        'totalRevenue': 0.0,
        'totalOrders': 0,
        'averageOrderValue': 0.0,
        'topProducts': <Map<String, dynamic>>[],
        'salesByDay': <Map<String, dynamic>>[],
        'paymentMethods': <Map<String, dynamic>>{},
      };
    }

    // Calculate metrics
    final totalRevenue = orders.fold<double>(
      0,
      (sum, order) => sum + order.totalAmount,
    );
    final totalOrders = orders.length;
    final averageOrderValue = totalRevenue / totalOrders;

    // Top products
    final productSales = <int, double>{};
    for (final order in orders) {
      for (final item in order.items) {
        productSales[item.productId] =
            (productSales[item.productId] ?? 0) + (item.price * item.quantity);
      }
    }

    final topProducts = <Map<String, dynamic>>[];
    for (final entry
        in productSales.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value))) {
      final product = await _productRepo.getById(entry.key);
      if (product != null) {
        topProducts.add({
          'product': product,
          'revenue': entry.value,
          'quantity': orders
              .expand((o) => o.items)
              .where((item) => item.productId == entry.key)
              .fold<int>(0, (sum, item) => sum + item.quantity),
        });
      }
    }

    // Sales by day
    final salesByDay = <String, double>{};
    for (final order in orders) {
      final day =
          '${order.createdAt.year}-${order.createdAt.month.toString().padLeft(2, '0')}-${order.createdAt.day.toString().padLeft(2, '0')}';
      salesByDay[day] = (salesByDay[day] ?? 0) + order.totalAmount;
    }

    final salesByDayList =
        salesByDay.entries
            .map((e) => {'date': e.key, 'revenue': e.value})
            .toList()
          ..sort(
            (a, b) => (a['date'] as String).compareTo(b['date'] as String),
          );

    // Payment methods
    final paymentMethods = <String, double>{};
    for (final order in orders) {
      final payments = await _paymentRepo.getByOrderId(order.id);
      for (final payment in payments) {
        paymentMethods[payment.method.toString()] =
            (paymentMethods[payment.method.toString()] ?? 0) + payment.amount;
      }
    }

    return {
      'totalRevenue': totalRevenue,
      'totalOrders': totalOrders,
      'averageOrderValue': averageOrderValue,
      'topProducts': topProducts.take(10).toList(),
      'salesByDay': salesByDayList,
      'paymentMethods': paymentMethods,
    };
  }

  // Customer Analytics
  Future<Map<String, dynamic>> getCustomerAnalytics() async {
    final customers = await _customerRepo.getAll(limit: 1000);
    final orders = await _orderRepo.getAll(limit: 1000);

    if (customers.isEmpty) {
      return {
        'totalCustomers': 0,
        'averageCustomerValue': 0.0,
        'topCustomers': <Map<String, dynamic>>[],
        'customerGrowth': <Map<String, dynamic>>[],
      };
    }

    // Customer order values
    final customerValues = <int, double>{};
    for (final order in orders) {
      if (order.customerId != null) {
        customerValues[order.customerId!] =
            (customerValues[order.customerId!] ?? 0) + order.totalAmount;
      }
    }

    final totalCustomerValue = customerValues.values.fold<double>(
      0,
      (sum, value) => sum + value,
    );
    final averageCustomerValue = totalCustomerValue / customers.length;

    // Top customers
    final topCustomers = <Map<String, dynamic>>[];
    for (final entry
        in customerValues.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value))) {
      final customer = await _customerRepo.getById(entry.key);
      if (customer != null) {
        final orderCount = orders
            .where((o) => o.customerId == entry.key)
            .length;
        topCustomers.add({
          'customer': customer,
          'totalSpent': entry.value,
          'orderCount': orderCount,
        });
      }
    }

    // Customer growth (by month)
    final customerGrowth = <String, int>{};
    for (final _ in customers) {
      final month =
          '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}';
      customerGrowth[month] = (customerGrowth[month] ?? 0) + 1;
    }

    final customerGrowthList =
        customerGrowth.entries
            .map((e) => {'month': e.key, 'count': e.value})
            .toList()
          ..sort(
            (a, b) => (a['month'] as String).compareTo(b['month'] as String),
          );

    return {
      'totalCustomers': customers.length,
      'averageCustomerValue': averageCustomerValue,
      'topCustomers': topCustomers.take(10).toList(),
      'customerGrowth': customerGrowthList,
    };
  }

  // Inventory Analytics
  Future<Map<String, dynamic>> getInventoryAnalytics() async {
    final products = await _productRepo.getAll(limit: 1000);
    final orders = await _orderRepo.getAll(limit: 1000);

    if (products.isEmpty) {
      return {
        'totalProducts': 0,
        'lowStockProducts': <Product>[],
        'fastMovingProducts': <Map<String, dynamic>>[],
        'slowMovingProducts': <Map<String, dynamic>>[],
        'inventoryValue': 0.0,
      };
    }

    // Product sales
    final productSales = <int, int>{};
    for (final order in orders) {
      for (final item in order.items) {
        productSales[item.productId] =
            (productSales[item.productId] ?? 0) + item.quantity;
      }
    }

    // Low stock products
    final lowStockProducts = products
        .where((p) => p.stock <= p.lowStockThreshold)
        .toList();

    // Fast moving products (top 10 by quantity sold)
    final fastMovingProducts = <Map<String, dynamic>>[];
    for (final entry
        in productSales.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value))) {
      final product = await _productRepo.getById(entry.key);
      if (product != null) {
        fastMovingProducts.add({
          'product': product,
          'quantitySold': entry.value,
        });
      }
    }

    // Slow moving products (products with no sales in last 30 days)
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final recentOrders = orders
        .where((o) => o.createdAt.isAfter(thirtyDaysAgo))
        .toList();
    final recentProductSales = <int>{};
    for (final order in recentOrders) {
      for (final item in order.items) {
        recentProductSales.add(item.productId);
      }
    }

    final slowMovingProducts = products
        .where((p) => !recentProductSales.contains(p.id))
        .map((p) => {'product': p, 'lastSale': 'No sales in 30 days'})
        .toList();

    // Inventory value
    final inventoryValue = products.fold<double>(
      0,
      (sum, product) => sum + (product.costPrice * product.stock),
    );

    return {
      'totalProducts': products.length,
      'lowStockProducts': lowStockProducts,
      'fastMovingProducts': fastMovingProducts.take(10).toList(),
      'slowMovingProducts': slowMovingProducts.take(10).toList(),
      'inventoryValue': inventoryValue,
    };
  }

  // Profitability Analysis
  Future<Map<String, dynamic>> getProfitabilityAnalysis({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final orders = await _orderRepo.getByDateRange(
      startDate ?? DateTime.now().subtract(const Duration(days: 30)),
      endDate ?? DateTime.now(),
    );

    if (orders.isEmpty) {
      return {
        'totalRevenue': 0.0,
        'totalCost': 0.0,
        'grossProfit': 0.0,
        'grossMargin': 0.0,
        'productProfitability': <Map<String, dynamic>>[],
      };
    }

    double totalRevenue = 0;
    double totalCost = 0;

    final productProfitability = <int, Map<String, double>>{};

    for (final order in orders) {
      totalRevenue += order.totalAmount;

      for (final item in order.items) {
        final product = await _productRepo.getById(item.productId);
        if (product != null) {
          final itemCost = product.costPrice * item.quantity;
          totalCost += itemCost;

          if (!productProfitability.containsKey(item.productId)) {
            productProfitability[item.productId] = {
              'revenue': 0.0,
              'cost': 0.0,
              'profit': 0.0,
            };
          }

          productProfitability[item.productId]!['revenue'] =
              productProfitability[item.productId]!['revenue']! +
              (item.price * item.quantity);
          productProfitability[item.productId]!['cost'] =
              productProfitability[item.productId]!['cost']! + itemCost;
          productProfitability[item.productId]!['profit'] =
              productProfitability[item.productId]!['revenue']! -
              productProfitability[item.productId]!['cost']!;
        }
      }
    }

    final grossProfit = totalRevenue - totalCost;
    final grossMargin = totalRevenue > 0
        ? (grossProfit / totalRevenue) * 100
        : 0;

    final productProfitabilityList = <Map<String, dynamic>>[];
    for (final entry in productProfitability.entries) {
      final product = await _productRepo.getById(entry.key);
      if (product != null) {
        final data = entry.value;
        productProfitabilityList.add({
          'product': product,
          'revenue': data['revenue']!,
          'cost': data['cost']!,
          'profit': data['profit']!,
          'margin': data['revenue']! > 0
              ? (data['profit']! / data['revenue']!) * 100
              : 0,
        });
      }
    }

    productProfitabilityList.sort((a, b) => b['profit'].compareTo(a['profit']));

    return {
      'totalRevenue': totalRevenue,
      'totalCost': totalCost,
      'grossProfit': grossProfit,
      'grossMargin': grossMargin,
      'productProfitability': productProfitabilityList.take(10).toList(),
    };
  }
}
