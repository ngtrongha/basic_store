import 'package:flutter/material.dart';

import '../../data/models/order.dart';
import '../../data/models/return.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';

class ReturnDialog extends StatefulWidget {
  final Order order;

  const ReturnDialog({super.key, required this.order});

  @override
  State<ReturnDialog> createState() => _ReturnDialogState();
}

class _ReturnDialogState extends State<ReturnDialog> {
  final List<ReturnItem> _returnItems = [];
  final _reasonCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _productRepo = ProductRepository();
  final Map<int, Product> _products = {};

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _reasonCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    for (final item in widget.order.items) {
      final product = await _productRepo.getById(item.productId);
      if (product != null) {
        _products[item.productId] = product;
      }
    }
    setState(() {});
  }

  void _addReturnItem(int productId, int maxQuantity) {
    final existingIndex = _returnItems.indexWhere(
      (item) => item.productId == productId,
    );
    if (existingIndex != -1) {
      final current = _returnItems[existingIndex];
      if (current.quantity.abs() < maxQuantity) {
        setState(() {
          _returnItems[existingIndex] = ReturnItem()
            ..productId = productId
            ..quantity =
                current.quantity -
                1 // negative quantity
            ..price = current.price
            ..reason = current.reason;
        });
      }
    } else {
      final orderItem = widget.order.items.firstWhere(
        (item) => item.productId == productId,
      );
      setState(() {
        _returnItems.add(
          ReturnItem()
            ..productId = productId
            ..quantity =
                -1 // negative quantity
            ..price = orderItem.price
            ..reason = 'defective',
        );
      });
    }
  }

  void _removeReturnItem(int productId) {
    setState(() {
      _returnItems.removeWhere((item) => item.productId == productId);
    });
  }

  double get _totalRefund => _returnItems.fold(
    0.0,
    (sum, item) => sum + (item.price * item.quantity.abs()),
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Trả hàng - Đơn #${widget.order.id}'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Order items
            const Text(
              'Sản phẩm trong đơn:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...widget.order.items.map((orderItem) {
              final product = _products[orderItem.productId];
              final returnItem = _returnItems.firstWhere(
                (item) => item.productId == orderItem.productId,
                orElse: () => ReturnItem()..quantity = 0,
              );
              final returnQty = returnItem.quantity.abs();

              return Card(
                child: ListTile(
                  title: Text(product?.name ?? 'SP #${orderItem.productId}'),
                  subtitle: Text(
                    'SL: ${orderItem.quantity} • Giá: ${orderItem.price.toStringAsFixed(0)} đ',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (returnQty > 0) ...[
                        Text('Trả: $returnQty'),
                        const SizedBox(width: 8),
                      ],
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: returnQty > 0
                            ? () => _addReturnItem(
                                orderItem.productId,
                                orderItem.quantity,
                              )
                            : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: returnQty < orderItem.quantity
                            ? () => _addReturnItem(
                                orderItem.productId,
                                orderItem.quantity,
                              )
                            : null,
                      ),
                      if (returnQty > 0)
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _removeReturnItem(orderItem.productId),
                        ),
                    ],
                  ),
                ),
              );
            }),

            if (_returnItems.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              Text('Tổng hoàn: ${_totalRefund.toStringAsFixed(0)} đ'),
              const SizedBox(height: 16),
              TextField(
                controller: _reasonCtrl,
                decoration: const InputDecoration(
                  labelText: 'Lý do trả hàng',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _notesCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ghi chú',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        FilledButton(
          onPressed: _returnItems.isNotEmpty && _reasonCtrl.text.isNotEmpty
              ? () => Navigator.of(context).pop({
                  'items': _returnItems,
                  'reason': _reasonCtrl.text,
                  'notes': _notesCtrl.text,
                })
              : null,
          child: const Text('Xác nhận trả hàng'),
        ),
      ],
    );
  }
}
