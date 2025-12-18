import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/services/reporting_service.dart';
import '../../di/injection.dart';
import 'reports_state.dart';

final reportsControllerProvider =
    NotifierProvider<ReportsController, ReportsState>(ReportsController.new);

class ReportsController extends Notifier<ReportsState> {
  ReportingService get _reportingService => getIt<ReportingService>();

  @override
  ReportsState build() {
    Future.microtask(_loadData);
    return ReportsState.initial();
  }

  Future<void> _loadData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final summary = await _reportingService.getSalesSummary(
        startDate: state.startDate,
        endDate: state.endDate,
      );

      final topProductsData = await _reportingService.getTopProducts(
        startDate: state.startDate,
        endDate: state.endDate,
      );

      final topProducts = topProductsData.map((item) {
        return TopProductInfo(
          product: item['product'],
          quantity: item['quantity'] as int,
          revenue: (item['revenue'] as num).toDouble(),
          margin: (item['margin'] as num).toDouble(),
          marginPercent: (item['marginPercent'] as num).toDouble(),
        );
      }).toList();

      state = state.copyWith(
        isLoading: false,
        totalRevenue: (summary['totalRevenue'] as num?)?.toDouble() ?? 0.0,
        totalOrders: (summary['totalOrders'] as int?) ?? 0,
        averageOrderValue:
            (summary['averageOrderValue'] as num?)?.toDouble() ?? 0.0,
        topProducts: topProducts,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Không thể tải báo cáo. Vui lòng thử lại.',
      );
    }
  }

  void setDateRange(DateTime start, DateTime end) {
    state = state.copyWith(startDate: start, endDate: end);
    _loadData();
  }

  void setQuickRange(QuickDateRange range) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime start;
    DateTime end = now;

    switch (range) {
      case QuickDateRange.today:
        start = today;
      case QuickDateRange.yesterday:
        start = today.subtract(const Duration(days: 1));
        end = today.subtract(const Duration(seconds: 1));
      case QuickDateRange.last7Days:
        start = today.subtract(const Duration(days: 6));
      case QuickDateRange.last30Days:
        start = today.subtract(const Duration(days: 29));
      case QuickDateRange.thisMonth:
        start = DateTime(now.year, now.month, 1);
      case QuickDateRange.lastMonth:
        final lastMonth = DateTime(now.year, now.month - 1, 1);
        start = lastMonth;
        end = DateTime(
          now.year,
          now.month,
          1,
        ).subtract(const Duration(seconds: 1));
      case QuickDateRange.thisYear:
        start = DateTime(now.year, 1, 1);
    }

    setDateRange(start, end);
  }

  Future<File?> exportCSV() async {
    state = state.copyWith(isExporting: true);

    try {
      final csv = await _reportingService.exportToCSV(
        startDate: state.startDate,
        endDate: state.endDate,
      );

      final fileName =
          'bao_cao_${_formatDateForFile(state.startDate)}_${_formatDateForFile(state.endDate)}.csv';

      final file = await _reportingService.saveReportToFile(csv, fileName);
      state = state.copyWith(isExporting: false);
      return file;
    } catch (e) {
      state = state.copyWith(
        isExporting: false,
        errorMessage: 'Không thể xuất CSV',
      );
      return null;
    }
  }

  Future<File?> exportPDF() async {
    state = state.copyWith(isExporting: true);

    try {
      final pdfBytes = await _reportingService.exportToPDF(
        startDate: state.startDate,
        endDate: state.endDate,
      );

      final fileName =
          'bao_cao_${_formatDateForFile(state.startDate)}_${_formatDateForFile(state.endDate)}.pdf';

      final file = await _reportingService.savePdfToFile(pdfBytes, fileName);
      state = state.copyWith(isExporting: false);
      return file;
    } catch (e) {
      state = state.copyWith(
        isExporting: false,
        errorMessage: 'Không thể xuất PDF',
      );
      return null;
    }
  }

  Future<void> shareFile(File file) async {
    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], text: 'Báo cáo'),
    );
  }

  String _formatDateForFile(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> refresh() async {
    await _loadData();
  }
}

enum QuickDateRange {
  today,
  yesterday,
  last7Days,
  last30Days,
  thisMonth,
  lastMonth,
  thisYear,
}
