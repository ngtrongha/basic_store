import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/database/app_database.dart';
import '../../data/dao/product_dao.dart';

/// Product DAO provider
final productDaoProvider = Provider<ProductDao>((ref) {
  return getIt<ProductDao>();
});

/// Products list notifier
class ProductsNotifier extends Notifier<AsyncValue<List<Product>>> {
  late ProductDao _dao;

  @override
  AsyncValue<List<Product>> build() {
    _dao = ref.watch(productDaoProvider);
    _loadProducts();
    return const AsyncValue.loading();
  }

  Future<void> _loadProducts() async {
    state = const AsyncValue.loading();
    try {
      final products = await _dao.getAllProducts();
      state = AsyncValue.data(products);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _loadProducts();

  Future<void> searchProducts(String query) async {
    state = const AsyncValue.loading();
    try {
      final products = await _dao.getProducts(searchQuery: query);
      state = AsyncValue.data(products);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> filterByCategory(int? categoryId) async {
    state = const AsyncValue.loading();
    try {
      final products = await _dao.getProducts(categoryId: categoryId);
      state = AsyncValue.data(products);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> deleteProduct(int id) async {
    try {
      await _dao.deleteProduct(id);
      await _loadProducts();
      return true;
    } catch (e) {
      return false;
    }
  }
}

/// Products list provider
final productsProvider =
    NotifierProvider<ProductsNotifier, AsyncValue<List<Product>>>(
      ProductsNotifier.new,
    );

/// Categories notifier
class CategoriesNotifier extends Notifier<AsyncValue<List<Category>>> {
  late ProductDao _dao;

  @override
  AsyncValue<List<Category>> build() {
    _dao = ref.watch(productDaoProvider);
    _loadCategories();
    return const AsyncValue.loading();
  }

  Future<void> _loadCategories() async {
    state = const AsyncValue.loading();
    try {
      final categories = await _dao.getAllCategories();
      state = AsyncValue.data(categories);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _loadCategories();

  Future<bool> addCategory(String name, {String? color}) async {
    try {
      await _dao.insertCategory(CategoriesCompanion.insert(name: name));
      await _loadCategories();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCategory(int id) async {
    try {
      await _dao.deleteCategory(id);
      await _loadCategories();
      return true;
    } catch (e) {
      return false;
    }
  }
}

/// Categories provider
final categoriesProvider =
    NotifierProvider<CategoriesNotifier, AsyncValue<List<Category>>>(
      CategoriesNotifier.new,
    );

// ============ Riverpod 3.0 Notifier pattern for filter state ============

/// Selected category filter notifier (Riverpod 3.0 pattern)
class SelectedCategoryNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void select(int? categoryId) => state = categoryId;
  void clear() => state = null;
}

/// Selected category provider (Riverpod 3.0 Notifier pattern)
final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, int?>(
      SelectedCategoryNotifier.new,
    );

/// Product search query notifier (Riverpod 3.0 pattern)
class ProductSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
  void clear() => state = '';
}

/// Product search query provider (Riverpod 3.0 Notifier pattern)
final productSearchQueryProvider =
    NotifierProvider<ProductSearchQueryNotifier, String>(
      ProductSearchQueryNotifier.new,
    );
