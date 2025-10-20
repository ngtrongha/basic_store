import 'package:flutter/material.dart';

import '../../data/models/store.dart';
import '../../data/services/multi_store_service.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final _service = MultiStoreService();
  List<Store> _stores = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  Future<void> _loadStores() async {
    setState(() => _loading = true);
    try {
      final stores = await _service.getActiveStores();
      if (mounted) setState(() => _stores = stores);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _addStore() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) => _StoreDialog(),
    );

    if (result == null) return;

    try {
      await _service.createStore(
        result['name']!,
        result['address']!,
        phone: result['phone'],
        email: result['email'],
      );
      _loadStores();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã thêm cửa hàng')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý cửa hàng'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadStores),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _stores.isEmpty
          ? const Center(child: Text('Chưa có cửa hàng nào'))
          : ListView.builder(
              itemCount: _stores.length,
              itemBuilder: (context, index) {
                final store = _stores[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(store.name.substring(0, 1).toUpperCase()),
                    ),
                    title: Text(store.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(store.address),
                        if (store.phone != null) Text('📞 ${store.phone}'),
                        if (store.email != null) Text('✉️ ${store.email}'),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'transfers') {
                          Navigator.of(
                            context,
                          ).pushNamed('/stock-transfers', arguments: store.id);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'transfers',
                          child: Row(
                            children: [
                              Icon(Icons.local_shipping),
                              SizedBox(width: 8),
                              Text('Chuyển kho'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStore,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _StoreDialog extends StatefulWidget {
  @override
  State<_StoreDialog> createState() => _StoreDialogState();
}

class _StoreDialogState extends State<_StoreDialog> {
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thêm cửa hàng'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Tên cửa hàng',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _addressCtrl,
            decoration: const InputDecoration(
              labelText: 'Địa chỉ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phoneCtrl,
            decoration: const InputDecoration(
              labelText: 'Số điện thoại',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _emailCtrl,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        FilledButton(
          onPressed: () {
            if (_nameCtrl.text.trim().isEmpty ||
                _addressCtrl.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vui lòng nhập tên và địa chỉ')),
              );
              return;
            }
            Navigator.of(context).pop({
              'name': _nameCtrl.text.trim(),
              'address': _addressCtrl.text.trim(),
              'phone': _phoneCtrl.text.trim().isEmpty
                  ? null
                  : _phoneCtrl.text.trim(),
              'email': _emailCtrl.text.trim().isEmpty
                  ? null
                  : _emailCtrl.text.trim(),
            });
          },
          child: const Text('Thêm'),
        ),
      ],
    );
  }
}
