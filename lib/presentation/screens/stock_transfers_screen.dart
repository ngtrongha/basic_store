import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

import '../../data/models/stock_transfer.dart';
import '../../data/models/store.dart';
import '../../data/models/product.dart';
import '../../data/services/multi_store_service.dart';
import '../../data/repositories/store_repository.dart';
import '../../data/repositories/product_repository.dart';

class StockTransfersScreen extends StatefulWidget {
  final int? storeId;

  const StockTransfersScreen({super.key, this.storeId});

  @override
  State<StockTransfersScreen> createState() => _StockTransfersScreenState();
}

class _StockTransfersScreenState extends State<StockTransfersScreen> {
  final _service = MultiStoreService();
  final _storeRepo = StoreRepository();
  final _productRepo = ProductRepository();

  List<StockTransfer> _transfers = [];
  List<Store> _stores = [];
  List<Product> _products = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    try {
      final stores = await _storeRepo.getActiveStores();
      final products = await _productRepo.getAll(limit: 1000);

      final transfers = await _service.getStockTransfers(
        storeId: widget.storeId,
      );

      if (mounted) {
        setState(() {
          _stores = stores;
          _products = products;
          _transfers = transfers;
        });
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _addTransfer() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => _TransferDialog(stores: _stores, products: _products),
    );

    if (result == null) return;

    try {
      await _service.createStockTransfer(
        fromStoreId: result['fromStoreId'],
        toStoreId: result['toStoreId'],
        productId: result['productId'],
        quantity: result['quantity'],
        notes: result['notes'],
      );
      _loadData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã tạo yêu cầu chuyển kho')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    }
  }

  Future<void> _completeTransfer(StockTransfer transfer) async {
    try {
      await _service.completeStockTransfer(transfer.id);
      _loadData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã hoàn thành chuyển kho')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    }
  }

  String _getStoreName(int storeId) {
    return _stores
        .firstWhere(
          (s) => s.id == storeId,
          orElse: () => Store()..name = 'Unknown',
        )
        .name;
  }

  String _getProductName(int productId) {
    return _products
        .firstWhere(
          (p) => p.id == productId,
          orElse: () => Product()..name = 'Unknown',
        )
        .name;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'in_transit':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.stockTransfers),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _transfers.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.noData))
          : ListView.builder(
              itemCount: _transfers.length,
              itemBuilder: (context, index) {
                final transfer = _transfers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(transfer.status),
                      child: Text(transfer.quantity.toString()),
                    ),
                    title: Text(_getProductName(transfer.productId)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.stores}: ${_getStoreName(transfer.fromStoreId)} → ${_getStoreName(transfer.toStoreId)}',
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.status}: ${transfer.status}',
                        ),
                        if (transfer.notes?.isNotEmpty == true)
                          Text(
                            '${AppLocalizations.of(context)!.notes}: ${transfer.notes}',
                          ),
                      ],
                    ),
                    trailing: transfer.status == 'pending'
                        ? IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () => _completeTransfer(transfer),
                          )
                        : null,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTransfer,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TransferDialog extends StatefulWidget {
  final List<Store> stores;
  final List<Product> products;

  const _TransferDialog({required this.stores, required this.products});

  @override
  State<_TransferDialog> createState() => _TransferDialogState();
}

class _TransferDialogState extends State<_TransferDialog> {
  int? _fromStoreId;
  int? _toStoreId;
  int? _productId;
  final _quantityCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _quantityCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.stockTransfers),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              value: _fromStoreId,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.stores,
                border: const OutlineInputBorder(),
              ),
              items: widget.stores.map((store) {
                return DropdownMenuItem(
                  value: store.id,
                  child: Text(store.name),
                );
              }).toList(),
              onChanged: (value) => setState(() => _fromStoreId = value),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: _toStoreId,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.stores,
                border: const OutlineInputBorder(),
              ),
              items: widget.stores.map((store) {
                return DropdownMenuItem(
                  value: store.id,
                  child: Text(store.name),
                );
              }).toList(),
              onChanged: (value) => setState(() => _toStoreId = value),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: _productId,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.products,
                border: const OutlineInputBorder(),
              ),
              items: widget.products.map((product) {
                return DropdownMenuItem(
                  value: product.id,
                  child: Text(product.name),
                );
              }).toList(),
              onChanged: (value) => setState(() => _productId = value),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _quantityCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.quantity,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesCtrl,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.notes ?? 'Notes',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        FilledButton(
          onPressed: () {
            if (_fromStoreId == null ||
                _toStoreId == null ||
                _productId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.warning)),
              );
              return;
            }
            final quantity = int.tryParse(_quantityCtrl.text.trim());
            if (quantity == null || quantity <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.error)),
              );
              return;
            }
            Navigator.of(context).pop({
              'fromStoreId': _fromStoreId,
              'toStoreId': _toStoreId,
              'productId': _productId,
              'quantity': quantity,
              'notes': _notesCtrl.text.trim().isEmpty
                  ? null
                  : _notesCtrl.text.trim(),
            });
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
