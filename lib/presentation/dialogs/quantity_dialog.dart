import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/numeric_keypad.dart';

class QuantityDialog extends StatefulWidget {
  final int initialQuantity;
  final String productName;

  const QuantityDialog({
    super.key,
    required this.initialQuantity,
    required this.productName,
  });

  @override
  State<QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  late String _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialQuantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 500,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${AppLocalizations.of(context)!.quantity}: ${widget.productName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: NumericKeypad(
                initialValue: _currentValue,
                onKeyPressed: (key) {
                  setState(() {
                    if (_currentValue == '0' && key != '0') {
                      _currentValue = key;
                    } else {
                      _currentValue += key;
                    }
                  });
                },
                onBackspace: () {
                  setState(() {
                    if (_currentValue.length > 1) {
                      _currentValue = _currentValue.substring(
                        0,
                        _currentValue.length - 1,
                      );
                    } else {
                      _currentValue = '0';
                    }
                  });
                },
                onEnter: () {
                  final quantity = int.tryParse(_currentValue) ?? 0;
                  Navigator.of(context).pop(quantity);
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      final quantity = int.tryParse(_currentValue) ?? 0;
                      Navigator.of(context).pop(quantity);
                    },
                    child: Text(AppLocalizations.of(context)!.yes),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
