import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/product.dart';

part 'product_list_state.freezed.dart';

@freezed
abstract class ProductListState with _$ProductListState {
  const factory ProductListState({
    @Default(true) bool isLoading,
    @Default([]) List<Product> products,
    @Default([]) List<Product> filteredProducts,
    @Default([]) List<Product> favoriteProducts,
    @Default('') String searchQuery,
    @Default(0) int selectedTabIndex,
    @Default(null) String? selectedCategory,
    @Default([]) List<String> categories,
    String? errorMessage,
  }) = _ProductListState;

  factory ProductListState.initial() => const ProductListState();
}
