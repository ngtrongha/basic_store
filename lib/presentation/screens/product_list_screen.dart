import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/product_repository.dart';
import '../../presentation/dialogs/add_product_dialog.dart';
import '../../data/models/product.dart';
import '../../features/pos/pos_controller.dart';
import '../../router/app_router.dart';
import '../widgets/product_search_field.dart';
import '../widgets/product_units_editor.dart';
import '../../data/services/favorite_service.dart';
import '../../l10n/app_localizations.dart';

@RoutePage()
class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen>
    with TickerProviderStateMixin {
  final _repo = ProductRepository();
  List<Product> _products = const [];
  List<Product> _filteredProducts = const [];
  List<Product> _favoriteProducts = const [];
  final _searchCtrl = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final items = await _repo.getAll(limit: 200);
    final favoriteIds = await FavoriteService.getFavoriteProductIds();
    final favorites = items.where((p) => favoriteIds.contains(p.id)).toList();

    setState(() {
      _products = items;
      _filteredProducts = items;
      _favoriteProducts = favorites;
    });
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products
            .where(
              (p) =>
                  p.name.toLowerCase().contains(query.toLowerCase()) ||
                  p.sku.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.products),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () async {
              final result = await context.router.push(const ScannerRoute());
              final sku = result is String
                  ? result
                  : (result is List<String> && result.isNotEmpty
                        ? result.first
                        : null);
              if (sku == null || sku.isEmpty) return;
              final found = await _repo.getBySku(sku);
              if (found == null) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${AppLocalizations.of(context)!.error}: $sku',
                    ),
                  ),
                );
                return;
              }
              if (!mounted) return;
              await ref.read(posControllerProvider.notifier).addProduct(found);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${AppLocalizations.of(context)!.success}: ${found.name}',
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final created = await showDialog<Product?>(
                context: context,
                builder: (_) => const AddProductDialog(),
              );
              if (created != null) {
                await _repo.create(created);
                await _load();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.point_of_sale),
            onPressed: () {
              context.router.push(const PosRoute());
            },
          ),
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              context.router.push(const OrderHistoryRoute());
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.router.push(const SettingsRoute());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ProductSearchField(
              controller: _searchCtrl,
              onChanged: _filterProducts,
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.products),
              Tab(text: AppLocalizations.of(context)!.favorites),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // All products tab
                RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final p = _filteredProducts[index];
                      return ListTile(
                        title: Text(p.name),
                        subtitle: Text(
                          '${AppLocalizations.of(context)!.sku}: ${p.sku} • ${AppLocalizations.of(context)!.stock}: ${p.stock}',
                        ),
                        trailing: Text('${p.salePrice.toStringAsFixed(0)} đ'),
                        onLongPress: () async {
                          await showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => ProductUnitsEditorSheet(product: p),
                          );
                        },
                        onTap: () async {
                          await ref
                              .read(posControllerProvider.notifier)
                              .addProduct(p);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${AppLocalizations.of(context)!.success}: ${p.name}',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // Favorites tab
                RefreshIndicator(
                  onRefresh: _load,
                  child: _favoriteProducts.isEmpty
                      ? Center(
                          child: Text(AppLocalizations.of(context)!.noData),
                        )
                      : ListView.builder(
                          itemCount: _favoriteProducts.length,
                          itemBuilder: (context, index) {
                            final p = _favoriteProducts[index];
                            return ListTile(
                              title: Text(p.name),
                              subtitle: Text(
                                '${AppLocalizations.of(context)!.sku}: ${p.sku} • ${AppLocalizations.of(context)!.stock}: ${p.stock}',
                              ),
                              trailing: Text(
                                '${p.salePrice.toStringAsFixed(0)} đ',
                              ),
                              onLongPress: () async {
                                await showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (_) =>
                                      ProductUnitsEditorSheet(product: p),
                                );
                              },
                              onTap: () async {
                                await ref
                                    .read(posControllerProvider.notifier)
                                    .addProduct(p);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${AppLocalizations.of(context)!.success}: ${p.name}',
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
