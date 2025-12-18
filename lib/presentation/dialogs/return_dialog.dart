import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

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

  int _findReturnIndex(OrderItem orderItem) {
    return _returnItems.indexWhere(
      (it) =>
          it.productId == orderItem.productId && it.unitId == orderItem.unitId,
    );
  }

  void _increaseReturnItem(OrderItem orderItem) {
    final idx = _findReturnIndex(orderItem);
    if (idx == -1) {
      setState(() {
        _returnItems.add(
          ReturnItem()
            ..productId = orderItem.productId
            ..unitId = orderItem.unitId
            ..unitFactor = orderItem.unitFactor
            ..unitName = orderItem.unitName
            ..quantity = -1
            ..price = orderItem.price
            ..reason = 'defective',
        );
      });
      return;
    }

    final current = _returnItems[idx];
    if (current.quantity.abs() >= orderItem.quantity) return;

    setState(() {
      _returnItems[idx] = ReturnItem()
        ..productId = current.productId
        ..unitId = current.unitId
        ..unitFactor = current.unitFactor
        ..unitName = current.unitName
        ..quantity = current.quantity - 1
        ..price = current.price
        ..reason = current.reason;
    });
  }

  void _decreaseReturnItem(OrderItem orderItem) {
    final idx = _findReturnIndex(orderItem);
    if (idx == -1) return;
    final current = _returnItems[idx];
    final qty = current.quantity.abs();
    if (qty <= 1) {
      _removeReturnItem(orderItem);
      return;
    }

    setState(() {
      _returnItems[idx] = ReturnItem()
        ..productId = current.productId
        ..unitId = current.unitId
        ..unitFactor = current.unitFactor
        ..unitName = current.unitName
        ..quantity = current.quantity + 1
        ..price = current.price
        ..reason = current.reason;
    });
  }

  void _removeReturnItem(OrderItem orderItem) {
    setState(() {
      _returnItems.removeWhere(
        (it) =>
            it.productId == orderItem.productId &&
            it.unitId == orderItem.unitId,
      );
    });
  }

  double get _totalRefund => _returnItems.fold(
    0.0,
    (sum, item) => sum + (item.price * item.quantity.abs()),
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${AppLocalizations.of(context)!.removeFromCart} - #${widget.order.id}',
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Order items
            Text(
              AppLocalizations.of(context)!.products,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...widget.order.items.map((orderItem) {
              final product = _products[orderItem.productId];
              final idx = _findReturnIndex(orderItem);
              final returnQty = idx == -1
                  ? 0
                  : _returnItems[idx].quantity.abs();
              final unitLabel =
                  orderItem.unitName == null || orderItem.unitName!.isEmpty
                  ? ''
                  : ' ${orderItem.unitName}';

              return Card(
                child: ListTile(
                  title: Text(product?.name ?? 'SP #${orderItem.productId}'),
                  subtitle: Text(
                    'SL: ${orderItem.quantity}$unitLabel • ${AppLocalizations.of(context)!.price}: ${orderItem.price.toStringAsFixed(0)} đ',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (returnQty > 0) ...[
                        Text(
                          '${AppLocalizations.of(context)!.quantity}: $returnQty$unitLabel',
                        ),
                        const SizedBox(width: 8),
                      ],
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: returnQty > 0
                            ? () => _decreaseReturnItem(orderItem)
                            : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: returnQty < orderItem.quantity
                            ? () => _increaseReturnItem(orderItem)
                            : null,
                      ),
                      if (returnQty > 0)
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeReturnItem(orderItem),
                        ),
                    ],
                  ),
                ),
              );
            }),

            if (_returnItems.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              Text(
                '${AppLocalizations.of(context)!.total}: ${_totalRefund.toStringAsFixed(0)} đ',
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _reasonCtrl,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.reason,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _notesCtrl,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.notes,
                  border: const OutlineInputBorder(),
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
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        FilledButton(
          onPressed: _returnItems.isNotEmpty && _reasonCtrl.text.isNotEmpty
              ? () => Navigator.of(context).pop({
                  'items': _returnItems,
                  'reason': _reasonCtrl.text,
                  'notes': _notesCtrl.text,
                })
              : null,
          child: Text(AppLocalizations.of(context)!.yes),
        ),
      ],
    );
  }
}
