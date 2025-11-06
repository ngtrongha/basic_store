import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

import '../../data/repositories/product_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/services/inventory_service.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _productRepo = ProductRepository();
  final _orderRepo = OrderRepository();
  final _inventoryService = InventoryService();
  final _authService = AuthService();

  int _totalProducts = 0;
  int _totalOrders = 0;
  double _totalRevenue = 0;
  int _lowStockCount = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final products = await _productRepo.getAll(limit: 1000);
    final orders = await _orderRepo.getAll(limit: 1000);
    final summary = await _inventoryService.getInventorySummary();

    final revenue = orders.fold<double>(
      0,
      (sum, order) => sum + order.totalAmount,
    );

    setState(() {
      _totalProducts = products.length;
      _totalOrders = orders.length;
      _totalRevenue = revenue;
      _lowStockCount = summary['lowStockCount'] as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dashboard),
        actions: [
          FutureBuilder<AppUser?>(
            future: _authService.getCurrentUser(),
            builder: (context, snapshot) {
              final user = snapshot.data;
              return PopupMenuButton<String>(
                icon: CircleAvatar(
                  child: Text(
                    user?.username.substring(0, 1).toUpperCase() ?? '?',
                  ),
                ),
                onSelected: (value) async {
                  if (value == 'logout') {
                    await _authService.logout();
                    if (mounted) {
                      Navigator.of(context).pushReplacementNamed('/login');
                    }
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.logout),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.inventory),
            onPressed: () => Navigator.of(context).pushNamed('/products'),
          ),
          IconButton(
            icon: const Icon(Icons.local_shipping),
            onPressed: () => Navigator.of(context).pushNamed('/suppliers'),
          ),
          IconButton(
            icon: const Icon(Icons.warehouse),
            onPressed: () => Navigator.of(context).pushNamed('/inventory'),
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => Navigator.of(context).pushNamed('/reports'),
          ),
          IconButton(
            icon: const Icon(Icons.assessment),
            onPressed: () =>
                Navigator.of(context).pushNamed('/advanced-reports'),
            tooltip: 'Báo cáo nâng cao',
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () => Navigator.of(context).pushNamed('/data-export'),
            tooltip: 'Xuất dữ liệu',
          ),
          IconButton(
            icon: const Icon(Icons.point_of_sale),
            onPressed: () => Navigator.of(context).pushNamed('/pos'),
          ),
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () => Navigator.of(context).pushNamed('/orders'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.of(context).pushNamed('/audit'),
          ),
          IconButton(
            icon: const Icon(Icons.store),
            onPressed: () => Navigator.of(context).pushNamed('/stores'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadStats,
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildStatCard(
              AppLocalizations.of(context)!.totalProducts,
              _totalProducts.toString(),
              Icons.inventory,
              Colors.blue,
            ),
            _buildStatCard(
              AppLocalizations.of(context)!.totalOrders,
              _totalOrders.toString(),
              Icons.receipt,
              Colors.green,
            ),
            _buildStatCard(
              AppLocalizations.of(context)!.revenue,
              '${_totalRevenue.toStringAsFixed(0)} đ',
              Icons.attach_money,
              Colors.orange,
            ),
            _buildStatCard(
              AppLocalizations.of(context)!.lowStock,
              _lowStockCount.toString(),
              Icons.warning,
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
