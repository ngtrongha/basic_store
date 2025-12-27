import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_models.freezed.dart';
part 'product_models.g.dart';

/// Product model
@freezed
abstract class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    String? description,
    required double price,
    required double costPrice,
    @Default(0) int stock,
    String? barcode,
    String? imageUrl,
    int? categoryId,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

/// Category model
@freezed
abstract class Category with _$Category {
  const factory Category({
    required int id,
    required String name,
    String? description,
    String? color,
    @Default(0) int productCount,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

/// Product with category
@freezed
abstract class ProductWithCategory with _$ProductWithCategory {
  const factory ProductWithCategory({
    required Product product,
    Category? category,
  }) = _ProductWithCategory;
}

/// Product filter
@freezed
abstract class ProductFilter with _$ProductFilter {
  const factory ProductFilter({
    String? searchQuery,
    int? categoryId,
    @Default(false) bool lowStockOnly,
    @Default(true) bool activeOnly,
    @Default(ProductSortBy.name) ProductSortBy sortBy,
    @Default(true) bool ascending,
  }) = _ProductFilter;
}

enum ProductSortBy { name, price, stock, updatedAt }
