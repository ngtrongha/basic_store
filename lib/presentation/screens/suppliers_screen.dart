import 'package:flutter/material.dart';

import '../../data/models/supplier.dart';
import '../../data/repositories/supplier_repository.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  final _repo = SupplierRepository();
  final _searchCtrl = TextEditingController();
  List<Supplier> _suppliers = const [];

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
      _suppliers = list;
    });
  }

  Future<void> _createQuick() async {
    final nameCtrl = TextEditingController();
    final contactCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final addressCtrl = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm nhà cung cấp'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Tên NCC'),
              ),
              TextField(
                controller: contactCtrl,
                decoration: const InputDecoration(labelText: 'Người liên hệ'),
              ),
              TextField(
                controller: phoneCtrl,
                decoration: const InputDecoration(labelText: 'SĐT'),
              ),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(labelText: 'Địa chỉ'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () async {
              final s = Supplier()
                ..name = nameCtrl.text.trim()
                ..contactName = contactCtrl.text.trim().isEmpty
                    ? null
                    : contactCtrl.text.trim()
                ..phone = phoneCtrl.text.trim().isEmpty
                    ? null
                    : phoneCtrl.text.trim()
                ..email = emailCtrl.text.trim().isEmpty
                    ? null
                    : emailCtrl.text.trim()
                ..address = addressCtrl.text.trim().isEmpty
                    ? null
                    : addressCtrl.text.trim();
              await _repo.create(s);
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
        title: const Text('Nhà cung cấp'),
        actions: [
          IconButton(
            onPressed: _createQuick,
            icon: const Icon(Icons.person_add_alt_1),
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
                hintText: 'Tìm theo tên/email/SĐT',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (q) async {
                final list = await _repo.search(query: q, limit: 200);
                if (mounted) setState(() => _suppliers = list);
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                itemCount: _suppliers.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final s = _suppliers[index];
                  return ListTile(
                    title: Text(s.name),
                    subtitle: Text(
                      [
                        if (s.contactName != null) 'LH: ${s.contactName}',
                        if (s.phone != null) s.phone!,
                        if (s.email != null) s.email!,
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
