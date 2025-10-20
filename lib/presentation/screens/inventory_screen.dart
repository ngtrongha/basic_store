import 'package:flutter/material.dart';

import '../../data/models/product.dart';
import '../../data/models/stock_adjustment.dart';
import '../../data/services/inventory_service.dart';
import '../../data/repositories/product_repository.dart';
import '../dialogs/stock_adjustment_dialog.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen>
    with TickerProviderStateMixin {
  final _inventoryService = InventoryService();
  final _productRepo = ProductRepository();

  late TabController _tabController;
  List<Product> _products = [];
  List<Product> _lowStockProducts = [];
  List<Product> _outOfStockProducts = [];
  List<StockAdjustment> _recentAdjustments = [];
  Map<String, dynamic> _summary = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final products = await _productRepo.getAll(limit: 1000);
    final lowStock = await _inventoryService.getLowStockProducts();
    final outOfStock = await _inventoryService.getOutOfStockProducts();
    final adjustments = await _inventoryService.getRecentAdjustments();
    final summary = await _inventoryService.getInventorySummary();

    setState(() {
      _products = products;
      _lowStockProducts = lowStock;
      _outOfStockProducts = outOfStock;
      _recentAdjustments = adjustments;
      _summary = summary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý kho'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tổng quan', icon: Icon(Icons.dashboard)),
            Tab(text: 'Sản phẩm', icon: Icon(Icons.inventory)),
            Tab(text: 'Cảnh báo', icon: Icon(Icons.warning)),
            Tab(text: 'Điều chỉnh', icon: Icon(Icons.edit)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSummaryTab(),
          _buildProductsTab(),
          _buildAlertsTab(),
          _buildAdjustmentsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Only manager/admin can adjust stock
          final allowed = await AuthService().hasRole(UserRole.manager);
          if (!allowed && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cần quyền quản lý để điều chỉnh kho'),
              ),
            );
            return;
          }
          final result = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (_) => const StockAdjustmentDialog(),
          );
          if (result != null) {
            try {
              await _inventoryService.adjustStock(
                productId: result['productId'] as int,
                delta: result['delta'] as int,
                reason: result['reason'] as String,
                notes: result['notes'] as String,
                batchNumber: result['batchNumber'] as String?,
                expiryDate: result['expiryDate'] as DateTime?,
              );
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã điều chỉnh tồn kho')),
                );
                _loadData();
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
              }
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryTab() {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tổng quan kho',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryItem(
                          'Tổng sản phẩm',
                          '${_summary['totalProducts'] ?? 0}',
                          Icons.inventory,
                          Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: _buildSummaryItem(
                          'Sắp hết hàng',
                          '${_summary['lowStockCount'] ?? 0}',
                          Icons.warning,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryItem(
                          'Hết hàng',
                          '${_summary['outOfStockCount'] ?? 0}',
                          Icons.error,
                          Colors.red,
                        ),
                      ),
                      Expanded(
                        child: _buildSummaryItem(
                          'Giá trị tồn kho',
                          '${(_summary['totalValue'] ?? 0.0).toStringAsFixed(0)} đ',
                          Icons.attach_money,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_lowStockProducts.isNotEmpty) ...[
            const Text(
              'Sản phẩm sắp hết hàng',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._lowStockProducts
                .take(5)
                .map(
                  (product) => Card(
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text(
                        'Tồn: ${product.stock} (Ngưỡng: ${product.lowStockThreshold})',
                      ),
                      trailing: Text(
                        '${product.salePrice.toStringAsFixed(0)} đ',
                      ),
                    ),
                  ),
                ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildProductsTab() {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          final isLowStock = product.stock <= product.lowStockThreshold;
          final isOutOfStock = product.stock <= 0;

          return Card(
            child: ListTile(
              title: Text(product.name),
              subtitle: Text('SKU: ${product.sku} • Tồn: ${product.stock}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${product.salePrice.toStringAsFixed(0)} đ'),
                  if (isOutOfStock)
                    const Text(
                      'HẾT HÀNG',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else if (isLowStock)
                    const Text(
                      'SẮP HẾT',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              onTap: () async {
                final result = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (_) => StockAdjustmentDialog(product: product),
                );
                if (result != null) {
                  try {
                    await _inventoryService.adjustStock(
                      productId: product.id,
                      delta: result['delta'] as int,
                      reason: result['reason'] as String,
                      notes: result['notes'] as String,
                      batchNumber: result['batchNumber'] as String?,
                      expiryDate: result['expiryDate'] as DateTime?,
                    );
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đã điều chỉnh tồn kho')),
                      );
                      _loadData();
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
                    }
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAlertsTab() {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_outOfStockProducts.isNotEmpty) ...[
            const Text(
              'Sản phẩm hết hàng',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            ..._outOfStockProducts.map(
              (product) => Card(
                color: Colors.red.shade50,
                child: ListTile(
                  leading: const Icon(Icons.error, color: Colors.red),
                  title: Text(product.name),
                  subtitle: Text('SKU: ${product.sku} • Tồn: ${product.stock}'),
                  trailing: Text('${product.salePrice.toStringAsFixed(0)} đ'),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (_lowStockProducts.isNotEmpty) ...[
            const Text(
              'Sản phẩm sắp hết hàng',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            ..._lowStockProducts.map(
              (product) => Card(
                color: Colors.orange.shade50,
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.orange),
                  title: Text(product.name),
                  subtitle: Text(
                    'SKU: ${product.sku} • Tồn: ${product.stock} (Ngưỡng: ${product.lowStockThreshold})',
                  ),
                  trailing: Text('${product.salePrice.toStringAsFixed(0)} đ'),
                ),
              ),
            ),
          ],
          if (_outOfStockProducts.isEmpty && _lowStockProducts.isEmpty)
            const Center(
              child: Text(
                'Không có cảnh báo nào',
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAdjustmentsTab() {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        itemCount: _recentAdjustments.length,
        itemBuilder: (context, index) {
          final adjustment = _recentAdjustments[index];
          return Card(
            child: ListTile(
              title: Text('SP #${adjustment.productId}'),
              subtitle: Text('${adjustment.reason} • ${adjustment.createdAt}'),
              trailing: Text(
                '${adjustment.delta > 0 ? '+' : ''}${adjustment.delta}',
                style: TextStyle(
                  color: adjustment.delta > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
