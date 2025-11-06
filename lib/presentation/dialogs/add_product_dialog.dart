import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

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
      title: Text(AppLocalizations.of(context)!.addProduct),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.productName,
                ),
                validator: (v) => (v == null || v.isEmpty)
                    ? AppLocalizations.of(context)!.warning
                    : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _skuCtrl,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.sku,
                ),
                validator: (v) => (v == null || v.isEmpty)
                    ? AppLocalizations.of(context)!.warning
                    : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _costCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.costPrice,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _saleCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.salePrice,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _stockCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.stock,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
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
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
