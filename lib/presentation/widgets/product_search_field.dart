import 'package:flutter/material.dart';

class ProductSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ProductSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm sản phẩm...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
