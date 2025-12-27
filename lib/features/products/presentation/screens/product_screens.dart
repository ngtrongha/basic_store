import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Product List Screen - TODO')),
    );
  }
}

@RoutePage()
class ProductFormScreen extends StatelessWidget {
  const ProductFormScreen({super.key, this.productId});

  final int? productId;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Product Form Screen - TODO')),
    );
  }
}
