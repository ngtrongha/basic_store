import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

import '../../data/models/payment.dart';
import '../../data/models/promotion.dart';

class CheckoutDialog extends StatefulWidget {
  final double totalAmount;
  final Promotion? appliedCoupon;

  const CheckoutDialog({
    super.key,
    required this.totalAmount,
    this.appliedCoupon,
  });

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  final List<Payment> _payments = [];
  final _cashCtrl = TextEditingController();
  final _cardCtrl = TextEditingController();
  final _ewalletCtrl = TextEditingController();

  @override
  void dispose() {
    _cashCtrl.dispose();
    _cardCtrl.dispose();
    _ewalletCtrl.dispose();
    super.dispose();
  }

  double get _totalPaid => _payments.fold(0.0, (sum, p) => sum + p.amount);
  double get _change => _totalPaid - widget.totalAmount;
  bool get _isComplete => _totalPaid >= widget.totalAmount;

  void _addPayment(PaymentMethod method, double amount) {
    if (amount <= 0) return;
    setState(() {
      _payments.add(
        Payment()
          ..method = method
          ..amount = amount,
      );
    });
  }

  void _removePayment(int index) {
    setState(() {
      _payments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.checkout),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${AppLocalizations.of(context)!.total}: ${widget.totalAmount.toStringAsFixed(0)} đ',
            ),
            if (widget.appliedCoupon != null)
              Text(
                '${AppLocalizations.of(context)!.couponCode}: ${widget.appliedCoupon!.couponCode}',
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cashCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.cash,
                      prefixText: 'đ ',
                    ),
                    onSubmitted: (value) {
                      final amount = double.tryParse(value) ?? 0;
                      if (amount > 0) {
                        _addPayment(PaymentMethod.cash, amount);
                        _cashCtrl.clear();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _cardCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.card,
                      prefixText: 'đ ',
                    ),
                    onSubmitted: (value) {
                      final amount = double.tryParse(value) ?? 0;
                      if (amount > 0) {
                        _addPayment(PaymentMethod.card, amount);
                        _cardCtrl.clear();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _ewalletCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.eWallet,
                      prefixText: 'đ ',
                    ),
                    onSubmitted: (value) {
                      final amount = double.tryParse(value) ?? 0;
                      if (amount > 0) {
                        _addPayment(PaymentMethod.ewallet, amount);
                        _ewalletCtrl.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_payments.isNotEmpty) ...[
              Text(
                AppLocalizations.of(context)!.paymentMethod,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ..._payments.asMap().entries.map((entry) {
                final index = entry.key;
                final payment = entry.value;
                return ListTile(
                  title: Text(_getMethodName(payment.method)),
                  subtitle: Text('${payment.amount.toStringAsFixed(0)} đ'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removePayment(index),
                  ),
                );
              }),
              const Divider(),
              Text('Đã trả: ${_totalPaid.toStringAsFixed(0)} đ'),
              if (_change > 0)
                Text('Tiền thừa: ${_change.toStringAsFixed(0)} đ'),
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
          onPressed: _isComplete
              ? () => Navigator.of(context).pop(_payments)
              : null,
          child: Text(AppLocalizations.of(context)!.yes),
        ),
      ],
    );
  }

  String _getMethodName(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'Tiền mặt';
      case PaymentMethod.card:
        return 'Thẻ';
      case PaymentMethod.ewallet:
        return 'Ví điện tử';
    }
  }
}
