import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product.dart';
import '../../features/pos/pos_controller.dart';
import '../../features/products/product_list_controller.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../dialogs/add_product_dialog.dart';
import '../widgets/product_units_editor.dart';

@RoutePage()
class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref
            .read(productListControllerProvider.notifier)
            .setTabIndex(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleScan() async {
    final result = await context.router.push(const ScannerRoute());
    final sku = result is String
        ? result
        : (result is List<String> && result.isNotEmpty ? result.first : null);

    if (sku == null || sku.isEmpty) return;

    final products = ref.read(productListControllerProvider).products;
    final found = products.firstWhere(
      (p) => p.sku == sku || p.barcode == sku,
      orElse: () => Product(),
    );

    if (found.id == 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Không tìm thấy sản phẩm: $sku'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!mounted) return;
    await ref.read(posControllerProvider.notifier).addProduct(found);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã thêm: ${found.name}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _addProduct() async {
    final created = await showDialog<Product?>(
      context: context,
      builder: (_) => const AddProductDialog(),
    );
    if (created != null) {
      await ref
          .read(productListControllerProvider.notifier)
          .createProduct(created);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productListControllerProvider);
    final controller = ref.read(productListControllerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildAppBar(context, state, controller, l10n, colorScheme),
        ],
        body: Column(
          children: [
            // Tab Bar
            Container(
              color: theme.cardColor,
              child: TabBar(
                controller: _tabController,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                indicatorColor: colorScheme.primary,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.inventory_2_outlined, size: 20),
                        const SizedBox(width: 8),
                        Text(l10n.products),
                        if (state.filteredProducts.isNotEmpty) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              state.filteredProducts.length.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.favorite_outline, size: 20),
                        const SizedBox(width: 8),
                        Text(l10n.favorites),
                        if (state.favoriteProducts.isNotEmpty) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              state.favoriteProducts.length.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: state.isLoading
                  ? _buildLoadingState(colorScheme)
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildProductGrid(
                          context,
                          state.filteredProducts,
                          controller,
                          colorScheme,
                          l10n,
                        ),
                        _buildProductGrid(
                          context,
                          state.favoriteProducts,
                          controller,
                          colorScheme,
                          l10n,
                          isFavoritesTab: true,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addProduct,
        icon: const Icon(Icons.add),
        label: const Text('Thêm SP'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    dynamic state,
    dynamic controller,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 140,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      title: Text(l10n.products),
      actions: [
        IconButton(
          icon: const Icon(Icons.qr_code_scanner_rounded),
          onPressed: _handleScan,
          tooltip: 'Quét mã',
        ),
        IconButton(
          icon: const Icon(Icons.point_of_sale_rounded),
          onPressed: () => context.router.push(const PosRoute()),
          tooltip: 'Bán hàng',
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorScheme.primary, colorScheme.primaryContainer],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      onChanged: controller.search,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm sản phẩm...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: colorScheme.primary,
                        ),
                        suffixIcon: state.searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close_rounded),
                                onPressed: () {
                                  _searchController.clear();
                                  controller.search('');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Đang tải sản phẩm...',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(
    BuildContext context,
    List<Product> products,
    ProductListController controller,
    ColorScheme colorScheme,
    AppLocalizations l10n, {
    bool isFavoritesTab = false,
  }) {
    if (products.isEmpty) {
      return _buildEmptyState(colorScheme, l10n, isFavoritesTab);
    }

    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductCard(context, product, controller, colorScheme);
        },
      ),
    );
  }

  Widget _buildEmptyState(
    ColorScheme colorScheme,
    AppLocalizations l10n,
    bool isFavoritesTab,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavoritesTab
                  ? Icons.favorite_border
                  : Icons.inventory_2_outlined,
              size: 48,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isFavoritesTab ? 'Chưa có sản phẩm yêu thích' : l10n.noData,
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
          ),
          if (!isFavoritesTab) ...[
            const SizedBox(height: 8),
            Text(
              'Nhấn + để thêm sản phẩm mới',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    Product product,
    ProductListController controller,
    ColorScheme colorScheme,
  ) {
    final isFavorite = controller.isFavorite(product);
    final isLowStock = product.stock <= product.lowStockThreshold;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await ref.read(posControllerProvider.notifier).addProduct(product);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(child: Text('Đã thêm: ${product.name}')),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        onLongPress: () async {
          await showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => _buildProductOptionsSheet(
              context,
              product,
              controller,
              colorScheme,
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isLowStock
                  ? Colors.red.withOpacity(0.3)
                  : colorScheme.outlineVariant.withOpacity(0.5),
              width: isLowStock ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image/Icon area
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.inventory_2_rounded,
                          size: 48,
                          color: colorScheme.primary.withOpacity(0.5),
                        ),
                      ),
                      // Favorite button
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => controller.toggleFavorite(product),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 18,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      // Low stock badge
                      if (isLowStock)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Sắp hết',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Product info
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Text(
                            _formatPrice(product.salePrice),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          // Stock
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isLowStock
                                  ? Colors.red.withOpacity(0.1)
                                  : colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${product.stock}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isLowStock
                                    ? Colors.red
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductOptionsSheet(
    BuildContext context,
    Product product,
    ProductListController controller,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Product info header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.inventory_2_rounded,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'SKU: ${product.sku} • Tồn: ${product.stock}',
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Divider(height: 1),

          // Options
          _buildOptionTile(
            icon: Icons.add_shopping_cart,
            title: 'Thêm vào giỏ hàng',
            color: Colors.green,
            onTap: () async {
              Navigator.pop(context);
              await ref
                  .read(posControllerProvider.notifier)
                  .addProduct(product);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã thêm: ${product.name}')),
              );
            },
          ),
          _buildOptionTile(
            icon: controller.isFavorite(product)
                ? Icons.favorite
                : Icons.favorite_border,
            title: controller.isFavorite(product)
                ? 'Bỏ yêu thích'
                : 'Thêm yêu thích',
            color: Colors.red,
            onTap: () {
              controller.toggleFavorite(product);
              Navigator.pop(context);
            },
          ),
          _buildOptionTile(
            icon: Icons.straighten,
            title: 'Quản lý đơn vị',
            color: Colors.purple,
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => ProductUnitsEditorSheet(product: product),
              );
            },
          ),
          _buildOptionTile(
            icon: Icons.delete_outline,
            title: 'Xóa sản phẩm',
            color: Colors.red,
            onTap: () async {
              Navigator.pop(context);
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Xác nhận xóa'),
                  content: Text('Bạn có chắc muốn xóa "${product.name}"?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'Xóa',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await controller.deleteProduct(product.id);
              }
            },
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  String _formatPrice(double price) {
    final formatted = price
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return '$formatted đ';
  }
}
