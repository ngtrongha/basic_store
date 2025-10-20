import 'package:flutter/material.dart';
import '../../data/services/advanced_reporting_service.dart';
import 'package:intl/intl.dart';

class AdvancedReportsScreen extends StatefulWidget {
  const AdvancedReportsScreen({super.key});

  @override
  State<AdvancedReportsScreen> createState() => _AdvancedReportsScreenState();
}

class _AdvancedReportsScreenState extends State<AdvancedReportsScreen>
    with TickerProviderStateMixin {
  final _reportingService = AdvancedReportingService();
  late TabController _tabController;

  DateTime? _startDate;
  DateTime? _endDate;

  Map<String, dynamic> _salesAnalytics = {};
  Map<String, dynamic> _customerAnalytics = {};
  Map<String, dynamic> _inventoryAnalytics = {};
  Map<String, dynamic> _profitabilityAnalysis = {};

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _endDate = DateTime.now();
    _startDate = DateTime.now().subtract(const Duration(days: 30));
    _loadAllReports();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAllReports() async {
    setState(() => _loading = true);
    try {
      final results = await Future.wait([
        _reportingService.getSalesAnalytics(
          startDate: _startDate,
          endDate: _endDate,
        ),
        _reportingService.getCustomerAnalytics(),
        _reportingService.getInventoryAnalytics(),
        _reportingService.getProfitabilityAnalysis(
          startDate: _startDate,
          endDate: _endDate,
        ),
      ]);

      setState(() {
        _salesAnalytics = results[0];
        _customerAnalytics = results[1];
        _inventoryAnalytics = results[2];
        _profitabilityAnalysis = results[3];
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _selectDateRange() async {
    final dates = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );

    if (dates != null) {
      setState(() {
        _startDate = dates.start;
        _endDate = dates.end;
      });
      _loadAllReports();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo nâng cao'),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _selectDateRange,
            tooltip: 'Chọn khoảng thời gian',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAllReports,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Bán hàng'),
            Tab(text: 'Khách hàng'),
            Tab(text: 'Kho hàng'),
            Tab(text: 'Lợi nhuận'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildSalesTab(),
                _buildCustomerTab(),
                _buildInventoryTab(),
                _buildProfitabilityTab(),
              ],
            ),
    );
  }

  Widget _buildSalesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateRangeInfo(),
          const SizedBox(height: 16),
          _buildMetricCard(
            'Tổng doanh thu',
            _formatCurrency(_salesAnalytics['totalRevenue'] ?? 0.0),
            Icons.attach_money,
            Colors.green,
          ),
          _buildMetricCard(
            'Tổng đơn hàng',
            '${_salesAnalytics['totalOrders'] ?? 0}',
            Icons.receipt,
            Colors.blue,
          ),
          _buildMetricCard(
            'Giá trị đơn hàng TB',
            _formatCurrency(_salesAnalytics['averageOrderValue'] ?? 0.0),
            Icons.trending_up,
            Colors.orange,
          ),

          const SizedBox(height: 24),
          const Text(
            'Sản phẩm bán chạy',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...(_salesAnalytics['topProducts'] as List<dynamic>? ?? []).map(
            (item) => _buildProductCard(
              item['product'].name,
              item['quantity'],
              _formatCurrency(item['revenue']),
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            'Doanh thu theo ngày',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...(_salesAnalytics['salesByDay'] as List<dynamic>? ?? []).map(
            (item) => _buildDaySalesCard(
              item['date'],
              _formatCurrency(item['revenue']),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMetricCard(
            'Tổng khách hàng',
            '${_customerAnalytics['totalCustomers'] ?? 0}',
            Icons.people,
            Colors.purple,
          ),
          _buildMetricCard(
            'Giá trị khách hàng TB',
            _formatCurrency(_customerAnalytics['averageCustomerValue'] ?? 0.0),
            Icons.person,
            Colors.teal,
          ),

          const SizedBox(height: 24),
          const Text(
            'Khách hàng VIP',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...(_customerAnalytics['topCustomers'] as List<dynamic>? ?? []).map(
            (item) => _buildCustomerCard(
              item['customer'].name,
              item['orderCount'],
              _formatCurrency(item['totalSpent']),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMetricCard(
            'Tổng sản phẩm',
            '${_inventoryAnalytics['totalProducts'] ?? 0}',
            Icons.inventory,
            Colors.indigo,
          ),
          _buildMetricCard(
            'Giá trị tồn kho',
            _formatCurrency(_inventoryAnalytics['inventoryValue'] ?? 0.0),
            Icons.warehouse,
            Colors.brown,
          ),

          const SizedBox(height: 24),
          const Text(
            'Sắp hết hàng',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          ...(_inventoryAnalytics['lowStockProducts'] as List<dynamic>? ?? [])
              .map(
                (product) => _buildLowStockCard(
                  product.name,
                  product.stock,
                  product.lowStockThreshold,
                ),
              ),

          const SizedBox(height: 24),
          const Text(
            'Sản phẩm bán chạy',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...(_inventoryAnalytics['fastMovingProducts'] as List<dynamic>? ?? [])
              .map(
                (item) => _buildProductCard(
                  item['product'].name,
                  item['quantitySold'],
                  'Đã bán',
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildProfitabilityTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateRangeInfo(),
          const SizedBox(height: 16),
          _buildMetricCard(
            'Tổng doanh thu',
            _formatCurrency(_profitabilityAnalysis['totalRevenue'] ?? 0.0),
            Icons.attach_money,
            Colors.green,
          ),
          _buildMetricCard(
            'Tổng chi phí',
            _formatCurrency(_profitabilityAnalysis['totalCost'] ?? 0.0),
            Icons.money_off,
            Colors.red,
          ),
          _buildMetricCard(
            'Lợi nhuận gộp',
            _formatCurrency(_profitabilityAnalysis['grossProfit'] ?? 0.0),
            Icons.trending_up,
            Colors.blue,
          ),
          _buildMetricCard(
            'Tỷ suất lợi nhuận',
            '${(_profitabilityAnalysis['grossMargin'] ?? 0.0).toStringAsFixed(1)}%',
            Icons.percent,
            Colors.orange,
          ),

          const SizedBox(height: 24),
          const Text(
            'Lợi nhuận theo sản phẩm',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...(_profitabilityAnalysis['productProfitability']
                      as List<dynamic>? ??
                  [])
              .map(
                (item) => _buildProfitabilityCard(
                  item['product'].name,
                  _formatCurrency(item['revenue']),
                  _formatCurrency(item['cost']),
                  _formatCurrency(item['profit']),
                  '${item['margin'].toStringAsFixed(1)}%',
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildDateRangeInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.date_range),
            const SizedBox(width: 8),
            Text(
              'Từ ${_formatDate(_startDate)} đến ${_formatDate(_endDate)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildProductCard(String name, int quantity, String revenue) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        title: Text(name),
        subtitle: Text('Số lượng: $quantity'),
        trailing: Text(
          revenue,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildCustomerCard(String name, int orders, String totalSpent) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        title: Text(name),
        subtitle: Text('Đơn hàng: $orders'),
        trailing: Text(
          totalSpent,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLowStockCard(String name, int stock, int threshold) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        title: Text(name),
        subtitle: Text('Tồn kho: $stock (Ngưỡng: $threshold)'),
        trailing: const Icon(Icons.warning, color: Colors.red),
      ),
    );
  }

  Widget _buildDaySalesCard(String date, String revenue) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        title: Text(_formatDate(DateTime.parse(date))),
        trailing: Text(
          revenue,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildProfitabilityCard(
    String name,
    String revenue,
    String cost,
    String profit,
    String margin,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Doanh thu: $revenue'), Text('Chi phí: $cost')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lợi nhuận: $profit',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Tỷ suất: $margin',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(amount);
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
