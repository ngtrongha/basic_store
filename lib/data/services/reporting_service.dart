import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../models/product.dart';
import '../repositories/order_repository.dart';
import '../repositories/product_repository.dart';

class ReportingService {
  final _orderRepo = OrderRepository();
  final _productRepo = ProductRepository();

  Future<Map<String, dynamic>> getSalesSummary({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final orders = await _orderRepo.getAll(limit: 1000);

    DateTime start =
        startDate ?? DateTime.now().subtract(const Duration(days: 30));
    DateTime end = endDate ?? DateTime.now();

    final filteredOrders = orders.where((order) {
      return order.createdAt.isAfter(start) && order.createdAt.isBefore(end);
    }).toList();

    double totalRevenue = 0;
    int totalOrders = filteredOrders.length;
    Map<int, int> productSales = {};
    Map<int, double> productRevenue = {};

    for (final order in filteredOrders) {
      totalRevenue += order.totalAmount;

      for (final item in order.items) {
        productSales[item.productId] =
            (productSales[item.productId] ?? 0) + item.quantity;
        productRevenue[item.productId] =
            (productRevenue[item.productId] ?? 0) +
            (item.price * item.quantity);
      }
    }

    return {
      'totalRevenue': totalRevenue,
      'totalOrders': totalOrders,
      'averageOrderValue': totalOrders > 0 ? totalRevenue / totalOrders : 0,
      'productSales': productSales,
      'productRevenue': productRevenue,
      'period': {'start': start, 'end': end},
    };
  }

  Future<List<Map<String, dynamic>>> getTopProducts({
    int limit = 10,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final summary = await getSalesSummary(
      startDate: startDate,
      endDate: endDate,
    );
    final productSales = summary['productSales'] as Map<int, int>;
    final productRevenue = summary['productRevenue'] as Map<int, double>;

    final products = await _productRepo.getAll(limit: 1000);
    final productMap = {for (var p in products) p.id: p};

    final topProducts = <Map<String, dynamic>>[];

    for (final entry in productSales.entries) {
      final productId = entry.key;
      final quantity = entry.value;
      final revenue = productRevenue[productId] ?? 0;
      final product = productMap[productId];

      if (product != null) {
        final margin = revenue - (product.costPrice * quantity);
        final marginPercent = revenue > 0 ? (margin / revenue) * 100 : 0;

        topProducts.add({
          'product': product,
          'quantity': quantity,
          'revenue': revenue,
          'margin': margin,
          'marginPercent': marginPercent,
        });
      }
    }

    topProducts.sort(
      (a, b) => (b['revenue'] as double).compareTo(a['revenue'] as double),
    );
    return topProducts.take(limit).toList();
  }

  Future<String> exportToCSV({DateTime? startDate, DateTime? endDate}) async {
    final summary = await getSalesSummary(
      startDate: startDate,
      endDate: endDate,
    );
    final topProducts = await getTopProducts(
      startDate: startDate,
      endDate: endDate,
    );

    final csv = StringBuffer();
    csv.writeln('Báo cáo bán hàng');
    csv.writeln('Từ: ${summary['period']['start'].toString().split(' ')[0]}');
    csv.writeln('Đến: ${summary['period']['end'].toString().split(' ')[0]}');
    csv.writeln('');
    csv.writeln('Tổng quan');
    csv.writeln('Tổng doanh thu,${summary['totalRevenue'].toStringAsFixed(0)}');
    csv.writeln('Tổng đơn hàng,${summary['totalOrders']}');
    csv.writeln(
      'Giá trị đơn hàng trung bình,${summary['averageOrderValue'].toStringAsFixed(0)}',
    );
    csv.writeln('');
    csv.writeln('Sản phẩm bán chạy');
    csv.writeln(
      'Tên sản phẩm,SKU,Số lượng,Doanh thu,Lợi nhuận,Tỷ lệ lợi nhuận',
    );

    for (final item in topProducts) {
      final product = item['product'] as Product;
      csv.writeln(
        '${product.name},${product.sku},${item['quantity']},${item['revenue'].toStringAsFixed(0)},${item['margin'].toStringAsFixed(0)},${item['marginPercent'].toStringAsFixed(1)}%',
      );
    }

    return csv.toString();
  }

  Future<Uint8List> exportToPDF({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final summary = await getSalesSummary(
      startDate: startDate,
      endDate: endDate,
    );
    final topProducts = await getTopProducts(
      startDate: startDate,
      endDate: endDate,
    );

    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Text(
                'Báo cáo bán hàng',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                'Từ: ${summary['period']['start'].toString().split(' ')[0]} - Đến: ${summary['period']['end'].toString().split(' ')[0]}',
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 20),

              pw.Text(
                'Tổng quan',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Tổng doanh thu:'),
                  pw.Text('${summary['totalRevenue'].toStringAsFixed(0)} đ'),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Tổng đơn hàng:'),
                  pw.Text('${summary['totalOrders']}'),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Giá trị đơn hàng trung bình:'),
                  pw.Text(
                    '${summary['averageOrderValue'].toStringAsFixed(0)} đ',
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              pw.Text(
                'Sản phẩm bán chạy',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          'Sản phẩm',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          'SL',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          'Doanh thu',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          'Lợi nhuận',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ...topProducts.map((item) {
                    final product = item['product'] as Product;
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(product.name),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text('${item['quantity']}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            '${item['revenue'].toStringAsFixed(0)} đ',
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            '${item['margin'].toStringAsFixed(0)} đ',
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  Future<File> saveReportToFile(String content, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsString(content, flush: true);
    return file;
  }

  Future<File> savePdfToFile(Uint8List bytes, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
