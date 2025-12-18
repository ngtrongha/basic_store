import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../data/models/unit.dart';
import '../../data/repositories/unit_repository.dart';
import '../../l10n/app_localizations.dart';

@RoutePage()
class UnitsScreen extends StatefulWidget {
  const UnitsScreen({super.key});

  @override
  State<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  final _repo = UnitRepository();
  final _searchCtrl = TextEditingController();
  List<Unit> _units = const [];

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
    final list = await _repo.getAll(limit: 1000);
    if (!mounted) return;
    setState(() => _units = list);
  }

  Future<void> _createQuick() async {
    final nameCtrl = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm đơn vị'),
        content: TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(
            labelText: 'Tên đơn vị (vd: Thùng, Lốc, Lon)',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              if (name.isEmpty) return;
              final u = Unit()
                ..name = name
                ..key = UnitRepository.normalizeKey(name)
                ..isActive = true
                ..createdAt = DateTime.now();
              await _repo.create(u);
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn vị'),
        actions: [
          IconButton(
            onPressed: _createQuick,
            icon: const Icon(Icons.add),
            tooltip: l10n.addUnit,
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
                hintText: l10n.search,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (q) async {
                final list = await _repo.search(query: q, limit: 500);
                if (mounted) setState(() => _units = list);
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                itemCount: _units.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final u = _units[index];
                  return ListTile(
                    title: Text(u.name),
                    subtitle: Text('key: ${u.key}'),
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
