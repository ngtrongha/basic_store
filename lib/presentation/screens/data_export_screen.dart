import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../data/services/data_export_service.dart';
import 'package:intl/intl.dart';

@RoutePage()
class DataExportScreen extends StatefulWidget {
  const DataExportScreen({super.key});

  @override
  State<DataExportScreen> createState() => _DataExportScreenState();
}

class _DataExportScreenState extends State<DataExportScreen> {
  final _exportService = DataExportService();
  bool _loading = false;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _endDate = DateTime.now();
    _startDate = DateTime.now().subtract(const Duration(days: 30));
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
    }
  }

  Future<void> _exportData(
    Future<void> Function() exportFunction,
    String dataType,
  ) async {
    setState(() => _loading = true);
    try {
      await exportFunction();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppLocalizations.of(context)!.success}: $dataType',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppLocalizations.of(context)!.error}: $dataType: $e',
            ),
          ),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xuất dữ liệu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _selectDateRange,
            tooltip: 'Chọn khoảng thời gian',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date range info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Khoảng thời gian: ${_formatDate(_startDate)} - ${_formatDate(_endDate)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: _selectDateRange,
                            child: const Text('Thay đổi'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Export all data
                  const Text(
                    'Xuất toàn bộ dữ liệu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _exportData(
                        () => _exportService.exportAllDataToJson(),
                        'toàn bộ dữ liệu (JSON)',
                      ),
                      icon: const Icon(Icons.download),
                      label: const Text('Xuất tất cả (JSON)'),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Export specific data types
                  const Text(
                    'Xuất dữ liệu theo loại',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  _buildExportButton(
                    AppLocalizations.of(context)!.products,
                    Icons.inventory,
                    () => _exportService.exportProductsToCsv(),
                    AppLocalizations.of(context)!.products,
                  ),

                  _buildExportButton(
                    AppLocalizations.of(context)!.orders,
                    Icons.receipt,
                    () => _exportService.exportOrdersToCsv(
                      startDate: _startDate,
                      endDate: _endDate,
                    ),
                    AppLocalizations.of(context)!.orders,
                  ),

                  _buildExportButton(
                    AppLocalizations.of(context)!.customers,
                    Icons.people,
                    () => _exportService.exportCustomersToCsv(),
                    AppLocalizations.of(context)!.customers,
                  ),

                  _buildExportButton(
                    AppLocalizations.of(context)!.inventory,
                    Icons.warehouse,
                    () => _exportService.exportInventoryToCsv(),
                    AppLocalizations.of(context)!.inventory,
                  ),

                  _buildExportButton(
                    AppLocalizations.of(context)!.suppliers,
                    Icons.local_shipping,
                    () => _exportService.exportSuppliersToCsv(),
                    AppLocalizations.of(context)!.suppliers,
                  ),

                  _buildExportButton(
                    'Thanh toán',
                    Icons.payment,
                    () => _exportService.exportPaymentsToCsv(
                      startDate: _startDate,
                      endDate: _endDate,
                    ),
                    'Thanh toán',
                  ),

                  _buildExportButton(
                    AppLocalizations.of(context)!.auditLog,
                    Icons.history,
                    () => _exportService.exportAuditLogToCsv(),
                    AppLocalizations.of(context)!.auditLog,
                  ),

                  const SizedBox(height: 24),

                  // Info card
                  Card(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info, color: Colors.blue.shade700),
                              const SizedBox(width: 8),
                              Text(
                                'Thông tin xuất dữ liệu',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '• Dữ liệu sẽ được xuất dưới định dạng CSV hoặc JSON\n'
                            '• File sẽ được chia sẻ qua ứng dụng khác trên thiết bị\n'
                            '• Dữ liệu xuất bao gồm tất cả thông tin hiện có\n'
                            '• Có thể chọn khoảng thời gian cho dữ liệu đơn hàng và thanh toán',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildExportButton(
    String title,
    IconData icon,
    Future<void> Function() exportFunction,
    String dataType,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.download),
        onTap: () => _exportData(exportFunction, dataType),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
