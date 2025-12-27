import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';

part 'product_dao.g.dart';

/// Data Access Object for Products
@lazySingleton
@DriftAccessor(tables: [Products, Categories])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  /// Get all products
  Future<List<Product>> getAllProducts() => select(products).get();

  /// Get products with optional filter
  Future<List<Product>> getProducts({
    String? searchQuery,
    int? categoryId,
    bool? activeOnly,
  }) {
    final query = select(products);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query.where(
        (p) => p.name.like('%$searchQuery%') | p.barcode.like('%$searchQuery%'),
      );
    }
    if (categoryId != null) {
      query.where((p) => p.categoryId.equals(categoryId));
    }
    if (activeOnly == true) {
      query.where((p) => p.isActive.equals(true));
    }

    return query.get();
  }

  /// Get product by ID
  Future<Product?> getProductById(int id) {
    return (select(products)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  /// Get product by barcode
  Future<Product?> getProductByBarcode(String barcode) {
    return (select(
      products,
    )..where((p) => p.barcode.equals(barcode))).getSingleOrNull();
  }

  /// Insert product
  Future<int> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  /// Update product
  Future<bool> updateProduct(Product product) {
    return update(products).replace(product);
  }

  /// Delete product
  Future<int> deleteProduct(int id) {
    return (delete(products)..where((p) => p.id.equals(id))).go();
  }

  /// Watch all products (stream)
  Stream<List<Product>> watchAllProducts() => select(products).watch();

  /// Get low stock products
  Future<List<Product>> getLowStockProducts(int threshold) {
    return (select(products)
          ..where((p) => p.quantity.isSmallerOrEqualValue(threshold))
          ..where((p) => p.isActive.equals(true)))
        .get();
  }

  // Category methods

  /// Get all categories
  Future<List<Category>> getAllCategories() => select(categories).get();

  /// Watch all categories
  Stream<List<Category>> watchAllCategories() => select(categories).watch();

  /// Insert category
  Future<int> insertCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  /// Update category
  Future<bool> updateCategory(Category category) {
    return update(categories).replace(category);
  }

  /// Delete category
  Future<int> deleteCategory(int id) {
    return (delete(categories)..where((c) => c.id.equals(id))).go();
  }

  /// Get products count by category
  Future<int> getProductCountByCategory(int categoryId) async {
    final count = products.id.count();
    final query = selectOnly(products)
      ..addColumns([count])
      ..where(products.categoryId.equals(categoryId));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }
}
