import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

import '../../data/models/supplier.dart';
import '../../data/repositories/supplier_repository.dart';

@RoutePage()
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
        title: Text(AppLocalizations.of(context)!.addSupplier),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.supplierName,
                ),
              ),
              TextField(
                controller: contactCtrl,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.supplierContact,
                ),
              ),
              TextField(
                controller: phoneCtrl,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.storePhone,
                ),
              ),
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.storeEmail,
                ),
              ),
              TextField(
                controller: addressCtrl,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.supplierAddress,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
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
        title: Text(AppLocalizations.of(context)!.suppliers),
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
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
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
