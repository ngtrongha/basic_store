import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

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
        title: Text(AppLocalizations.of(context)!.addCustomer),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.customerName,
              ),
            ),
            TextField(
              controller: phoneCtrl,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.customerPhone,
              ),
            ),
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.customerEmail,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
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
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.customers),
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
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
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
                        '${AppLocalizations.of(context)!.customerPoints}: ${c.points}',
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
