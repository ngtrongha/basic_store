import 'package:flutter/material.dart';

import '../../data/models/product.dart';
import '../../data/models/stock_adjustment.dart';
import '../../data/repositories/product_repository.dart';

class StockAdjustmentDialog extends StatefulWidget {
  final Product? product;

  const StockAdjustmentDialog({super.key, this.product});

  @override
  State<StockAdjustmentDialog> createState() => _StockAdjustmentDialogState();
}

class _StockAdjustmentDialogState extends State<StockAdjustmentDialog> {
  final _productRepo = ProductRepository();
  final _deltaCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _batchCtrl = TextEditingController();

  Product? _selectedProduct;
  List<Product> _products = [];
  AdjustmentReason _selectedReason = AdjustmentReason.manual;
  DateTime? _expiryDate;

  @override
  void initState() {
    super.initState();
    _selectedProduct = widget.product;
    _loadProducts();
  }

  @override
  void dispose() {
    _deltaCtrl.dispose();
    _reasonCtrl.dispose();
    _notesCtrl.dispose();
    _batchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    final products = await _productRepo.getAll(limit: 1000);
    setState(() {
      _products = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Điều chỉnh tồn kho'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Product selection
            DropdownButtonFormField<Product>(
              value: _selectedProduct,
              decoration: const InputDecoration(
                labelText: 'Sản phẩm',
                border: OutlineInputBorder(),
              ),
              items: _products.map((product) {
                return DropdownMenuItem(
                  value: product,
                  child: Text('${product.name} (Tồn: ${product.stock})'),
                );
              }).toList(),
              onChanged: (product) {
                setState(() {
                  _selectedProduct = product;
                });
              },
            ),
            const SizedBox(height: 16),

            // Delta input
            TextField(
              controller: _deltaCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Số lượng điều chỉnh (+/-)',
                border: OutlineInputBorder(),
                helperText: 'Dương để tăng, âm để giảm',
              ),
            ),
            const SizedBox(height: 16),

            // Reason selection
            DropdownButtonFormField<AdjustmentReason>(
              value: _selectedReason,
              decoration: const InputDecoration(
                labelText: 'Lý do',
                border: OutlineInputBorder(),
              ),
              items: AdjustmentReason.values.map((reason) {
                return DropdownMenuItem(
                  value: reason,
                  child: Text(_getReasonText(reason)),
                );
              }).toList(),
              onChanged: (reason) {
                setState(() {
                  _selectedReason = reason!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Batch number
            TextField(
              controller: _batchCtrl,
              decoration: const InputDecoration(
                labelText: 'Số lô (tùy chọn)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Expiry date
            ListTile(
              title: const Text('Ngày hết hạn'),
              subtitle: Text(
                _expiryDate?.toString().split(' ')[0] ?? 'Chưa chọn',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _expiryDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                  );
                  if (date != null) {
                    setState(() {
                      _expiryDate = date;
                    });
                  }
                },
              ),
            ),

            // Notes
            TextField(
              controller: _notesCtrl,
              decoration: const InputDecoration(
                labelText: 'Ghi chú',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        FilledButton(
          onPressed: _canSubmit()
              ? () {
                  final delta = int.tryParse(_deltaCtrl.text) ?? 0;
                  Navigator.of(context).pop({
                    'productId': _selectedProduct!.id,
                    'delta': delta,
                    'reason': _selectedReason.name,
                    'notes': _notesCtrl.text,
                    'batchNumber': _batchCtrl.text.isEmpty
                        ? null
                        : _batchCtrl.text,
                    'expiryDate': _expiryDate,
                  });
                }
              : null,
          child: const Text('Xác nhận'),
        ),
      ],
    );
  }

  bool _canSubmit() {
    return _selectedProduct != null &&
        _deltaCtrl.text.isNotEmpty &&
        int.tryParse(_deltaCtrl.text) != null;
  }

  String _getReasonText(AdjustmentReason reason) {
    switch (reason) {
      case AdjustmentReason.manual:
        return 'Điều chỉnh thủ công';
      case AdjustmentReason.damaged:
        return 'Hàng hư hỏng';
      case AdjustmentReason.expired:
        return 'Hàng hết hạn';
      case AdjustmentReason.theft:
        return 'Mất trộm';
      case AdjustmentReason.found:
        return 'Tìm thấy';
      case AdjustmentReason.transfer:
        return 'Chuyển kho';
      case AdjustmentReason.returned:
        return 'Trả hàng';
      case AdjustmentReason.other:
        return 'Khác';
    }
  }
}
