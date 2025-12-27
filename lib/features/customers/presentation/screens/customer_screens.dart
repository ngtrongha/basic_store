import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Customer List Screen - TODO')),
    );
  }
}

@RoutePage()
class CustomerFormScreen extends StatelessWidget {
  const CustomerFormScreen({super.key, this.customerId});

  final int? customerId;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Customer Form Screen - TODO')),
    );
  }
}
