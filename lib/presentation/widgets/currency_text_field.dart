import 'package:flutter/material.dart';

class CurrencyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CurrencyTextField({super.key, required this.controller, this.label = 'Giá bán'});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixText: 'đ ',
        border: const OutlineInputBorder(),
      ),
    );
  }
}


