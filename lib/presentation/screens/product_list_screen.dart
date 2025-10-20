import 'package:flutter/material.dart';
import '../../data/repositories/product_repository.dart';
import '../../presentation/dialogs/add_product_dialog.dart';
import '../../data/models/product.dart';
import 'scanner_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubits/pos_cubit/pos_cubit.dart';
import '../widgets/product_search_field.dart';
import '../../data/services/favorite_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen>
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
        title: const Text('Quản lý Sản phẩm'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () async {
              final sku = await Navigator.of(context).push<String>(
                MaterialPageRoute(builder: (_) => const ScannerScreen()),
              );
              if (sku == null || sku.isEmpty) return;
              final found = await _repo.getBySku(sku);
              if (found == null) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Không tìm thấy SKU: $sku')),
                );
                return;
              }
              if (!mounted) return;
              context.read<PosCubit>().addProduct(found);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Đã thêm: ${found.name}')));
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
              Navigator.of(context).pushNamed('/pos');
            },
          ),
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              Navigator.of(context).pushNamed('/orders');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
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
            tabs: const [
              Tab(text: 'Tất cả'),
              Tab(text: 'Yêu thích'),
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
                        subtitle: Text('SKU: ${p.sku} • Tồn: ${p.stock}'),
                        trailing: Text('${p.salePrice.toStringAsFixed(0)} đ'),
                        onTap: () {
                          context.read<PosCubit>().addProduct(p);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Đã thêm: ${p.name}')),
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
                      ? const Center(child: Text('Chưa có sản phẩm yêu thích'))
                      : ListView.builder(
                          itemCount: _favoriteProducts.length,
                          itemBuilder: (context, index) {
                            final p = _favoriteProducts[index];
                            return ListTile(
                              title: Text(p.name),
                              subtitle: Text('SKU: ${p.sku} • Tồn: ${p.stock}'),
                              trailing: Text(
                                '${p.salePrice.toStringAsFixed(0)} đ',
                              ),
                              onTap: () {
                                context.read<PosCubit>().addProduct(p);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Đã thêm: ${p.name}')),
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
