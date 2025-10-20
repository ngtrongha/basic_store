import 'dart:typed_data';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../models/order.dart';
import 'settings_service.dart';
import '../models/promotion.dart';
import 'totals_calculator.dart';

class InvoiceService {
  Future<Uint8List> generateInvoicePdf(
    Order order, {
    String? storeName,
    Promotion? coupon,
  }) async {
    final store = storeName ?? await SettingsService.getStoreName();
    final doc = pw.Document();

    final breakdown = await const TotalsCalculator().compute(
      items: order.items,
      coupon: coupon,
    );

    doc.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Text(
                store,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('Sản phẩm'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('SL'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('Đơn giá'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('Thành tiền'),
                      ),
                    ],
                  ),
                  ...order.items.map(
                    (it) => pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text('#${it.productId}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text('${it.quantity}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(it.price.toStringAsFixed(0)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            (it.price * it.quantity).toStringAsFixed(0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Column(
                children: [
                  _kv('Tạm tính', breakdown.subtotal),
                  if (breakdown.cartDiscount > 0)
                    _kv('Giảm giá', -breakdown.cartDiscount),
                  if (breakdown.vatAmount > 0) _kv('VAT', breakdown.vatAmount),
                  if (breakdown.serviceFee > 0)
                    _kv('Phí dịch vụ', breakdown.serviceFee),
                  pw.Divider(),
                  _kvBold('Tổng cộng', breakdown.grandTotal),
                ],
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  Future<File> saveToTemp(Uint8List bytes, String fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<void> shareInvoice(
    Order order, {
    String? storeName,
    Promotion? coupon,
  }) async {
    final bytes = await generateInvoicePdf(
      order,
      storeName: storeName,
      coupon: coupon,
    );
    final file = await saveToTemp(bytes, 'hoa_don_${order.id}.pdf');
    await Share.shareXFiles([XFile(file.path)], text: 'Hóa đơn #${order.id}');
  }
}

pw.Widget _kv(String label, double value) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [pw.Text(label), pw.Text(value.toStringAsFixed(0))],
  );
}

pw.Widget _kvBold(String label, double value) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text(
        value.toStringAsFixed(0),
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      ),
    ],
  );
}
