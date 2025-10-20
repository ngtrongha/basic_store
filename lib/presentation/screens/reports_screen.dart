import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/services/reporting_service.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _reportingService = ReportingService();

  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  Map<String, dynamic> _summary = {};
  List<Map<String, dynamic>> _topProducts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _guardAndLoad();
  }

  Future<void> _guardAndLoad() async {
    final allowed = await AuthService().hasRole(UserRole.manager);
    if (!allowed && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cần quyền quản lý để xem báo cáo')),
      );
      Navigator.of(context).pop();
      return;
    }
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() => _isLoading = true);

    try {
      final summary = await _reportingService.getSalesSummary(
        startDate: _startDate,
        endDate: _endDate,
      );
      final topProducts = await _reportingService.getTopProducts(
        startDate: _startDate,
        endDate: _endDate,
      );

      setState(() {
        _summary = summary;
        _topProducts = topProducts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    }
  }

  Future<void> _selectDateRange() async {
    final dates = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
    );

    if (dates != null) {
      setState(() {
        _startDate = dates.start;
        _endDate = dates.end;
      });
      _loadReports();
    }
  }

  Future<void> _exportCSV() async {
    try {
      final csv = await _reportingService.exportToCSV(
        startDate: _startDate,
        endDate: _endDate,
      );
      final file = await _reportingService.saveReportToFile(
        csv,
        'bao_cao_${_startDate.toString().split(' ')[0]}_${_endDate.toString().split(' ')[0]}.csv',
      );

      if (mounted) {
        await Share.shareXFiles([XFile(file.path)], text: 'Báo cáo CSV');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi xuất CSV: $e')));
      }
    }
  }

  Future<void> _exportPDF() async {
    try {
      final pdfBytes = await _reportingService.exportToPDF(
        startDate: _startDate,
        endDate: _endDate,
      );
      final file = await _reportingService.savePdfToFile(
        pdfBytes,
        'bao_cao_${_startDate.toString().split(' ')[0]}_${_endDate.toString().split(' ')[0]}.pdf',
      );

      if (mounted) {
        await Share.shareXFiles([XFile(file.path)], text: 'Báo cáo PDF');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi xuất PDF: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _selectDateRange,
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _exportCSV,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _exportPDF,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadReports,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Date range display
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.date_range),
                      title: const Text('Khoảng thời gian'),
                      subtitle: Text(
                        '${_startDate.toString().split(' ')[0]} - ${_endDate.toString().split(' ')[0]}',
                      ),
                      trailing: const Icon(Icons.edit),
                      onTap: _selectDateRange,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Summary
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tổng quan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildSummaryItem(
                                  'Doanh thu',
                                  '${_summary['totalRevenue']?.toStringAsFixed(0) ?? '0'} đ',
                                  Icons.attach_money,
                                  Colors.green,
                                ),
                              ),
                              Expanded(
                                child: _buildSummaryItem(
                                  'Đơn hàng',
                                  '${_summary['totalOrders'] ?? 0}',
                                  Icons.receipt,
                                  Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildSummaryItem(
                                  'Giá trị TB',
                                  '${_summary['averageOrderValue']?.toStringAsFixed(0) ?? '0'} đ',
                                  Icons.analytics,
                                  Colors.orange,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Top products
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sản phẩm bán chạy',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ..._topProducts.map((item) {
                            final product = item['product'];
                            return ListTile(
                              title: Text(product.name),
                              subtitle: Text('SKU: ${product.sku}'),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'SL: ${item['quantity']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${item['revenue'].toStringAsFixed(0)} đ',
                                  ),
                                  Text(
                                    'LN: ${item['marginPercent'].toStringAsFixed(1)}%',
                                    style: TextStyle(
                                      color: item['margin'] >= 0
                                          ? Colors.green
                                          : Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
