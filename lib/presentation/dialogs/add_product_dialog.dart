import 'package:flutter/material.dart';

import '../../data/models/product.dart';

class AddProductDialog extends StatefulWidget {
  const AddProductDialog({super.key});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _skuCtrl = TextEditingController();
  final _costCtrl = TextEditingController();
  final _saleCtrl = TextEditingController();
  final _stockCtrl = TextEditingController(text: '0');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _skuCtrl.dispose();
    _costCtrl.dispose();
    _saleCtrl.dispose();
    _stockCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thêm sản phẩm'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
                validator: (v) => (v == null || v.isEmpty) ? 'Nhập tên' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _skuCtrl,
                decoration: const InputDecoration(labelText: 'SKU'),
                validator: (v) => (v == null || v.isEmpty) ? 'Nhập SKU' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _costCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Giá nhập'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _saleCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Giá bán'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _stockCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Tồn kho'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            final p = Product()
              ..name = _nameCtrl.text.trim()
              ..sku = _skuCtrl.text.trim()
              ..costPrice = double.tryParse(_costCtrl.text.trim()) ?? 0
              ..salePrice = double.tryParse(_saleCtrl.text.trim()) ?? 0
              ..stock = int.tryParse(_stockCtrl.text.trim()) ?? 0;
            Navigator.of(context).pop(p);
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
