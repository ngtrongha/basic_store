import 'package:flutter/material.dart';

import '../../data/models/product.dart';
import '../../data/models/unit.dart';
import '../../data/models/product_unit.dart' as product_model;
import '../../data/repositories/product_unit_repository.dart';
import '../../data/repositories/unit_repository.dart';

class ProductUnitsEditorSheet extends StatefulWidget {
  final Product product;

  const ProductUnitsEditorSheet({super.key, required this.product});

  @override
  State<ProductUnitsEditorSheet> createState() =>
      _ProductUnitsEditorSheetState();
}

class _Draft {
  int unitId;
  String unitName;
  String unitKey;
  double factor;
  bool isBase;
  bool isDefault;
  double? priceOverride;
  String? sku;
  String? barcode;

  _Draft({
    required this.unitId,
    required this.unitName,
    required this.unitKey,
    required this.factor,
    required this.isBase,
    required this.isDefault,
    required this.priceOverride,
    required this.sku,
    required this.barcode,
  });
}

class _ProductUnitsEditorSheetState extends State<ProductUnitsEditorSheet> {
  final _unitRepo = UnitRepository();
  final _puRepo = ProductUnitRepository();

  bool _loading = true;
  List<Unit> _allUnits = const [];
  List<_Draft> _drafts = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final units = await _unitRepo.getAll(limit: 2000);
      final mapped = await _puRepo.getByProductWithUnits(widget.product.id);
      final drafts = mapped
          .map(
            (e) => _Draft(
              unitId: e.unit.id,
              unitName: e.unit.name,
              unitKey: e.unit.key,
              factor: e.productUnit.factor,
              isBase: e.productUnit.isBase,
              isDefault: e.productUnit.isDefault,
              priceOverride: e.productUnit.priceOverride,
              sku: e.productUnit.sku,
              barcode: e.productUnit.barcode,
            ),
          )
          .toList();
      if (!mounted) return;
      setState(() {
        _allUnits = units;
        _drafts = drafts;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _addUnit() async {
    final available = _allUnits
        .where((u) => _drafts.every((d) => d.unitId != u.id))
        .toList();
    if (available.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Không còn đơn vị để thêm')));
      return;
    }

    Unit selected = available.first;
    final factorCtrl = TextEditingController(text: '1');
    final priceCtrl = TextEditingController();
    final skuCtrl = TextEditingController();
    final barcodeCtrl = TextEditingController();
    var makeBase = false;
    var makeDefault = _drafts.isEmpty;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setStateDlg) => AlertDialog(
            title: const Text('Thêm đơn vị cho sản phẩm'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<Unit>(
                    value: selected,
                    items: available
                        .map(
                          (u) => DropdownMenuItem<Unit>(
                            value: u,
                            child: Text('${u.name} (${u.key})'),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (v) {
                      if (v == null) return;
                      setStateDlg(() => selected = v);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Đơn vị',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: factorCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Hệ số (số đơn vị gốc / 1 đơn vị này)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: priceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Giá bán override (tuỳ chọn)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: skuCtrl,
                    decoration: const InputDecoration(
                      labelText: 'SKU (tuỳ chọn)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: barcodeCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Barcode (tuỳ chọn)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    value: makeBase,
                    onChanged: (v) {
                      setStateDlg(() {
                        makeBase = v ?? false;
                        if (makeBase) factorCtrl.text = '1';
                        if (makeBase) makeDefault = true;
                      });
                    },
                    title: const Text('Đơn vị gốc (factor = 1)'),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  CheckboxListTile(
                    value: makeDefault,
                    onChanged: (v) {
                      setStateDlg(() {
                        makeDefault = v ?? false;
                        if (makeBase) makeDefault = true;
                      });
                    },
                    title: const Text('Đơn vị mặc định khi bán'),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Hủy'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Thêm'),
              ),
            ],
          ),
        );
      },
    );

    if (ok != true) return;

    final factor = double.tryParse(factorCtrl.text.trim()) ?? 1.0;
    if (factor <= 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Hệ số phải > 0')));
      return;
    }

    setState(() {
      final updated = [..._drafts];
      if (makeBase) {
        for (final d in updated) {
          d.isBase = false;
        }
      }
      if (makeDefault) {
        for (final d in updated) {
          d.isDefault = false;
        }
      }

      updated.add(
        _Draft(
          unitId: selected.id,
          unitName: selected.name,
          unitKey: selected.key,
          factor: makeBase ? 1.0 : factor,
          isBase: makeBase,
          isDefault: makeDefault,
          priceOverride: double.tryParse(priceCtrl.text.trim()),
          sku: skuCtrl.text.trim().isEmpty ? null : skuCtrl.text.trim(),
          barcode: barcodeCtrl.text.trim().isEmpty
              ? null
              : barcodeCtrl.text.trim(),
        ),
      );
      _drafts = updated;
    });
  }

  Future<void> _editUnit(int index) async {
    final current = _drafts[index];
    final factorCtrl = TextEditingController(text: current.factor.toString());
    final priceCtrl = TextEditingController(
      text: current.priceOverride?.toString() ?? '',
    );
    final skuCtrl = TextEditingController(text: current.sku ?? '');
    final barcodeCtrl = TextEditingController(text: current.barcode ?? '');
    var makeBase = current.isBase;
    var makeDefault = current.isDefault;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setStateDlg) => AlertDialog(
            title: Text('Sửa: ${current.unitName}'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('key: ${current.unitKey}'),
                  const SizedBox(height: 12),
                  TextField(
                    controller: factorCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Hệ số (base/unit)',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !makeBase,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: priceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Giá bán override (tuỳ chọn)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: skuCtrl,
                    decoration: const InputDecoration(
                      labelText: 'SKU (tuỳ chọn)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: barcodeCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Barcode (tuỳ chọn)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    value: makeBase,
                    onChanged: (v) {
                      setStateDlg(() {
                        makeBase = v ?? false;
                        if (makeBase) {
                          factorCtrl.text = '1';
                          makeDefault = true;
                        }
                      });
                    },
                    title: const Text('Đơn vị gốc (factor = 1)'),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  CheckboxListTile(
                    value: makeDefault,
                    onChanged: (v) {
                      setStateDlg(() {
                        makeDefault = v ?? false;
                        if (makeBase) makeDefault = true;
                      });
                    },
                    title: const Text('Đơn vị mặc định khi bán'),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Hủy'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Lưu'),
              ),
            ],
          ),
        );
      },
    );

    if (ok != true) return;

    final factor = double.tryParse(factorCtrl.text.trim()) ?? current.factor;
    if (factor <= 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Hệ số phải > 0')));
      return;
    }

    setState(() {
      final updated = [..._drafts];
      if (makeBase) {
        for (final d in updated) {
          d.isBase = false;
        }
      }
      if (makeDefault) {
        for (final d in updated) {
          d.isDefault = false;
        }
      }

      updated[index] = _Draft(
        unitId: current.unitId,
        unitName: current.unitName,
        unitKey: current.unitKey,
        factor: makeBase ? 1.0 : factor,
        isBase: makeBase,
        isDefault: makeDefault,
        priceOverride: double.tryParse(priceCtrl.text.trim()),
        sku: skuCtrl.text.trim().isEmpty ? null : skuCtrl.text.trim(),
        barcode: barcodeCtrl.text.trim().isEmpty
            ? null
            : barcodeCtrl.text.trim(),
      );
      _drafts = updated;
    });
  }

  void _deleteUnit(int index) {
    setState(() {
      final updated = [..._drafts]..removeAt(index);
      _drafts = updated;
    });
  }

  Future<void> _save() async {
    if (_drafts.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cần ít nhất 1 đơn vị')));
      return;
    }

    // Ensure single base + single default.
    var baseIndex = _drafts.indexWhere((d) => d.isBase);
    if (baseIndex == -1) {
      baseIndex = 0;
      _drafts[0].isBase = true;
      _drafts[0].factor = 1.0;
    }

    var defaultIndex = _drafts.indexWhere((d) => d.isDefault);
    if (defaultIndex == -1) {
      _drafts[baseIndex].isDefault = true;
    }

    // Normalize flags (only 1 base/default).
    for (var i = 0; i < _drafts.length; i++) {
      if (i != baseIndex) _drafts[i].isBase = false;
    }
    final firstDefault = _drafts.indexWhere((d) => d.isDefault);
    for (var i = 0; i < _drafts.length; i++) {
      if (i != firstDefault) _drafts[i].isDefault = false;
    }
    _drafts[baseIndex].factor = 1.0;

    final models = _drafts
        .map(
          (d) => product_model.ProductUnit()
            ..productId = widget.product.id
            ..unitId = d.unitId
            ..factor = d.factor
            ..isBase = d.isBase
            ..isDefault = d.isDefault
            ..priceOverride = d.priceOverride
            ..sku = d.sku
            ..barcode = d.barcode
            ..createdAt = DateTime.now(),
        )
        .toList(growable: false);

    await _puRepo.replaceForProduct(
      productId: widget.product.id,
      units: models,
    );
    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã lưu đơn vị')));
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SizedBox(
        height: h * 0.85,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Đơn vị: ${widget.product.name}'),
            actions: [
              IconButton(
                onPressed: _addUnit,
                icon: const Icon(Icons.add),
                tooltip: 'Thêm đơn vị',
              ),
            ],
          ),
          body: _loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Row(
                        children: [
                          Expanded(child: Text('SKU: ${widget.product.sku}')),
                          Text('SL gốc: ${widget.product.stock}'),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: _drafts.isEmpty
                          ? const Center(
                              child: Text('Chưa có đơn vị cho sản phẩm'),
                            )
                          : ListView.separated(
                              itemCount: _drafts.length,
                              separatorBuilder: (_, __) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final d = _drafts[index];
                                final chips = <String>[
                                  if (d.isBase) 'Gốc',
                                  if (d.isDefault) 'Mặc định',
                                ];
                                final right = chips.isEmpty
                                    ? ''
                                    : ' • ${chips.join(', ')}';
                                return ListTile(
                                  title: Text('${d.unitName}$right'),
                                  subtitle: Text(
                                    [
                                      'factor=${d.factor.toStringAsFixed(d.factor == d.factor.roundToDouble() ? 0 : 2)}',
                                      if (d.priceOverride != null)
                                        'price=${d.priceOverride!.toStringAsFixed(0)}',
                                      if (d.sku != null) 'sku=${d.sku}',
                                      if (d.barcode != null)
                                        'barcode=${d.barcode}',
                                    ].join(' • '),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () => _editUnit(index),
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () => _deleteUnit(index),
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _save,
                          icon: const Icon(Icons.save),
                          label: const Text('Lưu'),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
