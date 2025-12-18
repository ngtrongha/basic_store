import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/services/favorite_service.dart';
import '../../di/injection.dart';
import 'product_list_state.dart';

final productListControllerProvider =
    NotifierProvider<ProductListController, ProductListState>(
      ProductListController.new,
    );

class ProductListController extends Notifier<ProductListState> {
  ProductRepository get _repo => getIt<ProductRepository>();

  @override
  ProductListState build() {
    Future.microtask(_loadData);
    return ProductListState.initial();
  }

  Future<void> _loadData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final products = await _repo.getAll(limit: 500);
      final favoriteIds = await FavoriteService.getFavoriteProductIds();
      final favorites = products
          .where((p) => favoriteIds.contains(p.id))
          .toList();

      // Extract unique categories
      final categories =
          products
              .map((p) => p.category)
              .where((c) => c != null && c.isNotEmpty)
              .cast<String>()
              .toSet()
              .toList()
            ..sort();

      state = state.copyWith(
        isLoading: false,
        products: products,
        filteredProducts: products,
        favoriteProducts: favorites,
        categories: categories,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Không thể tải danh sách sản phẩm',
      );
    }
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void setCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
    _applyFilters();
  }

  void setTabIndex(int index) {
    state = state.copyWith(selectedTabIndex: index);
  }

  void _applyFilters() {
    var filtered = state.products.toList();

    // Apply search
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtered = filtered.where((p) {
        return p.name.toLowerCase().contains(query) ||
            p.sku.toLowerCase().contains(query) ||
            (p.barcode?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Apply category filter
    if (state.selectedCategory != null) {
      filtered = filtered
          .where((p) => p.category == state.selectedCategory)
          .toList();
    }

    state = state.copyWith(filteredProducts: filtered);
  }

  Future<void> toggleFavorite(Product product) async {
    final isFavorite = state.favoriteProducts.any((p) => p.id == product.id);

    await FavoriteService.toggleFavorite(product.id);

    if (isFavorite) {
      state = state.copyWith(
        favoriteProducts: state.favoriteProducts
            .where((p) => p.id != product.id)
            .toList(),
      );
    } else {
      state = state.copyWith(
        favoriteProducts: [...state.favoriteProducts, product],
      );
    }
  }

  bool isFavorite(Product product) {
    return state.favoriteProducts.any((p) => p.id == product.id);
  }

  Future<void> deleteProduct(int productId) async {
    await _repo.deleteById(productId);
    await refresh();
  }

  Future<void> createProduct(Product product) async {
    await _repo.create(product);
    await refresh();
  }

  Future<void> refresh() async {
    await _loadData();
    _applyFilters();
  }
}
