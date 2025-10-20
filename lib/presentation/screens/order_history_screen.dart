import 'package:basic_store/data/models/return.dart';
import 'package:flutter/material.dart';

import '../../data/models/order.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/services/invoice_service.dart';
import '../../data/services/return_service.dart';
import '../dialogs/return_dialog.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final _repo = OrderRepository();
  final _returnService = ReturnService();
  List<Order> _orders = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final items = await _repo.getAll(limit: 200);
    setState(() {
      _orders = items..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch sử đơn hàng')),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView.separated(
          itemCount: _orders.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final o = _orders[index];
            return ListTile(
              title: Text('Đơn #${o.id}'),
              subtitle: Text('${o.createdAt}  •  ${o.items.length} sp'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${o.totalAmount.toStringAsFixed(0)} đ'),
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'share') {
                        await InvoiceService().shareInvoice(
                          o,
                          storeName: 'Basic Store',
                        );
                      } else if (value == 'return') {
                        final result = await showDialog<Map<String, dynamic>>(
                          context: context,
                          builder: (_) => ReturnDialog(order: o),
                        );
                        if (result != null) {
                          try {
                            final returnId = await _returnService.processReturn(
                              originalOrderId: o.id,
                              items: result['items'] as List<ReturnItem>,
                              reason: result['reason'] as String,
                              notes: result['notes'] as String,
                              customerId: o.customerId,
                            );
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Đã tạo phiếu trả hàng #$returnId',
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Lỗi: $e')),
                              );
                            }
                          }
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            Icon(Icons.share),
                            SizedBox(width: 8),
                            Text('Chia sẻ hóa đơn'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'return',
                        child: Row(
                          children: [
                            Icon(Icons.keyboard_return),
                            SizedBox(width: 8),
                            Text('Trả hàng'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () async {
                await InvoiceService().shareInvoice(
                  o,
                  storeName: 'Basic Store',
                );
              },
            );
          },
        ),
      ),
    );
  }
}
