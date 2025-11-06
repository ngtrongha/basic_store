import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

import '../../data/models/purchase_order.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';

class PurchaseOrderDialog extends StatefulWidget {
  final int supplierId;
  const PurchaseOrderDialog({super.key, required this.supplierId});

  @override
  State<PurchaseOrderDialog> createState() => _PurchaseOrderDialogState();
}

class _PurchaseOrderDialogState extends State<PurchaseOrderDialog> {
  final _productRepo = ProductRepository();
  List<Product> _products = [];
  final List<PurchaseOrderItem> _items = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await _productRepo.getAll(limit: 500);
    setState(() => _products = products);
  }

  void _addItem(Product p) {
    setState(() {
      _items.add(
        PurchaseOrderItem()
          ..productId = p.id
          ..quantity = 1
          ..unitCost = p.costPrice,
      );
    });
  }

  void _updateQty(int index, int qty) {
    if (qty <= 0) return;
    setState(() => _items[index].quantity = qty);
  }

  void _updateCost(int index, double cost) {
    if (cost <= 0) return;
    setState(() => _items[index].unitCost = cost);
  }

  double get _totalCost =>
      _items.fold(0.0, (sum, it) => sum + it.unitCost * it.quantity);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addSupplier),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Product>(
              items: _products
                  .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
                  .toList(),
              onChanged: (p) {
                if (p != null) _addItem(p);
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.addProduct,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (_items.isNotEmpty)
              SizedBox(
                height: 240,
                child: ListView.separated(
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final it = _items[index];
                    final product = _products.firstWhere(
                      (p) => p.id == it.productId,
                      orElse: () => Product()
                        ..id = it.productId
                        ..name = 'SP #${it.productId}'
                        ..sku = ''
                        ..salePrice = 0
                        ..costPrice = it.unitCost
                        ..stock = 0
                        ..lowStockThreshold = 0,
                    );
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  context,
                                )!.quantity,
                              ),
                              onChanged: (v) => _updateQty(
                                index,
                                int.tryParse(v) ?? it.quantity,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.price,
                              ),
                              onChanged: (v) => _updateCost(
                                index,
                                double.tryParse(v) ?? it.unitCost,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        '${(it.unitCost * it.quantity).toStringAsFixed(0)} đ',
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Tổng: ${_totalCost.toStringAsFixed(0)} đ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        FilledButton(
          onPressed: _items.isNotEmpty
              ? () {
                  final po = PurchaseOrder()
                    ..supplierId = widget.supplierId
                    ..createdAt = DateTime.now()
                    ..status = 'open'
                    ..items = _items;
                  Navigator.pop(context, po);
                }
              : null,
          child: const Text('Tạo đơn'),
        ),
      ],
    );
  }
}
