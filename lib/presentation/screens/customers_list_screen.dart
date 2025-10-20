import 'package:flutter/material.dart';

import '../../data/models/customer.dart';
import '../../data/repositories/customer_repository.dart';

class CustomersListScreen extends StatefulWidget {
  const CustomersListScreen({super.key});

  @override
  State<CustomersListScreen> createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen> {
  final _repo = CustomerRepository();
  final _searchCtrl = TextEditingController();
  List<Customer> _customers = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final list = await _repo.search(limit: 200);
    setState(() {
      _customers = list;
    });
  }

  Future<void> _createQuick() async {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm khách hàng'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Tên'),
            ),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(labelText: 'SĐT'),
            ),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () async {
              final c = Customer()
                ..name = nameCtrl.text.trim()
                ..phone = phoneCtrl.text.trim().isEmpty
                    ? null
                    : phoneCtrl.text.trim()
                ..email = emailCtrl.text.trim().isEmpty
                    ? null
                    : emailCtrl.text.trim()
                ..tier = 'Bronze'
                ..points = 0;
              await _repo.create(c);
              if (mounted) Navigator.pop(context);
              await _load();
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khách hàng'),
        actions: [
          IconButton(
            onPressed: _createQuick,
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchCtrl,
              decoration: const InputDecoration(
                hintText: 'Tìm theo tên/SĐT/email',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (q) async {
                final list = await _repo.search(query: q, limit: 200);
                if (mounted) setState(() => _customers = list);
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                itemCount: _customers.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final c = _customers[index];
                  return ListTile(
                    title: Text(c.name),
                    subtitle: Text(
                      [
                        if (c.phone != null) c.phone!,
                        if (c.email != null) c.email!,
                        'Điểm: ${c.points}',
                      ].join(' • '),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
