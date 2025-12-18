// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductListState {

 bool get isLoading; List<Product> get products; List<Product> get filteredProducts; List<Product> get favoriteProducts; String get searchQuery; int get selectedTabIndex; String? get selectedCategory; List<String> get categories; String? get errorMessage;
/// Create a copy of ProductListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductListStateCopyWith<ProductListState> get copyWith => _$ProductListStateCopyWithImpl<ProductListState>(this as ProductListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.products, products)&&const DeepCollectionEquality().equals(other.filteredProducts, filteredProducts)&&const DeepCollectionEquality().equals(other.favoriteProducts, favoriteProducts)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedTabIndex, selectedTabIndex) || other.selectedTabIndex == selectedTabIndex)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(products),const DeepCollectionEquality().hash(filteredProducts),const DeepCollectionEquality().hash(favoriteProducts),searchQuery,selectedTabIndex,selectedCategory,const DeepCollectionEquality().hash(categories),errorMessage);

@override
String toString() {
  return 'ProductListState(isLoading: $isLoading, products: $products, filteredProducts: $filteredProducts, favoriteProducts: $favoriteProducts, searchQuery: $searchQuery, selectedTabIndex: $selectedTabIndex, selectedCategory: $selectedCategory, categories: $categories, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ProductListStateCopyWith<$Res>  {
  factory $ProductListStateCopyWith(ProductListState value, $Res Function(ProductListState) _then) = _$ProductListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<Product> products, List<Product> filteredProducts, List<Product> favoriteProducts, String searchQuery, int selectedTabIndex, String? selectedCategory, List<String> categories, String? errorMessage
});




}
/// @nodoc
class _$ProductListStateCopyWithImpl<$Res>
    implements $ProductListStateCopyWith<$Res> {
  _$ProductListStateCopyWithImpl(this._self, this._then);

  final ProductListState _self;
  final $Res Function(ProductListState) _then;

/// Create a copy of ProductListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? products = null,Object? filteredProducts = null,Object? favoriteProducts = null,Object? searchQuery = null,Object? selectedTabIndex = null,Object? selectedCategory = freezed,Object? categories = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,filteredProducts: null == filteredProducts ? _self.filteredProducts : filteredProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,favoriteProducts: null == favoriteProducts ? _self.favoriteProducts : favoriteProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedTabIndex: null == selectedTabIndex ? _self.selectedTabIndex : selectedTabIndex // ignore: cast_nullable_to_non_nullable
as int,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductListState].
extension ProductListStatePatterns on ProductListState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductListState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductListState value)  $default,){
final _that = this;
switch (_that) {
case _ProductListState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductListState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductListState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<Product> products,  List<Product> filteredProducts,  List<Product> favoriteProducts,  String searchQuery,  int selectedTabIndex,  String? selectedCategory,  List<String> categories,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductListState() when $default != null:
return $default(_that.isLoading,_that.products,_that.filteredProducts,_that.favoriteProducts,_that.searchQuery,_that.selectedTabIndex,_that.selectedCategory,_that.categories,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<Product> products,  List<Product> filteredProducts,  List<Product> favoriteProducts,  String searchQuery,  int selectedTabIndex,  String? selectedCategory,  List<String> categories,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ProductListState():
return $default(_that.isLoading,_that.products,_that.filteredProducts,_that.favoriteProducts,_that.searchQuery,_that.selectedTabIndex,_that.selectedCategory,_that.categories,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<Product> products,  List<Product> filteredProducts,  List<Product> favoriteProducts,  String searchQuery,  int selectedTabIndex,  String? selectedCategory,  List<String> categories,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ProductListState() when $default != null:
return $default(_that.isLoading,_that.products,_that.filteredProducts,_that.favoriteProducts,_that.searchQuery,_that.selectedTabIndex,_that.selectedCategory,_that.categories,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ProductListState implements ProductListState {
  const _ProductListState({this.isLoading = true, final  List<Product> products = const [], final  List<Product> filteredProducts = const [], final  List<Product> favoriteProducts = const [], this.searchQuery = '', this.selectedTabIndex = 0, this.selectedCategory = null, final  List<String> categories = const [], this.errorMessage}): _products = products,_filteredProducts = filteredProducts,_favoriteProducts = favoriteProducts,_categories = categories;
  

@override@JsonKey() final  bool isLoading;
 final  List<Product> _products;
@override@JsonKey() List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<Product> _filteredProducts;
@override@JsonKey() List<Product> get filteredProducts {
  if (_filteredProducts is EqualUnmodifiableListView) return _filteredProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredProducts);
}

 final  List<Product> _favoriteProducts;
@override@JsonKey() List<Product> get favoriteProducts {
  if (_favoriteProducts is EqualUnmodifiableListView) return _favoriteProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteProducts);
}

@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  int selectedTabIndex;
@override@JsonKey() final  String? selectedCategory;
 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  String? errorMessage;

/// Create a copy of ProductListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductListStateCopyWith<_ProductListState> get copyWith => __$ProductListStateCopyWithImpl<_ProductListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._filteredProducts, _filteredProducts)&&const DeepCollectionEquality().equals(other._favoriteProducts, _favoriteProducts)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedTabIndex, selectedTabIndex) || other.selectedTabIndex == selectedTabIndex)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_filteredProducts),const DeepCollectionEquality().hash(_favoriteProducts),searchQuery,selectedTabIndex,selectedCategory,const DeepCollectionEquality().hash(_categories),errorMessage);

@override
String toString() {
  return 'ProductListState(isLoading: $isLoading, products: $products, filteredProducts: $filteredProducts, favoriteProducts: $favoriteProducts, searchQuery: $searchQuery, selectedTabIndex: $selectedTabIndex, selectedCategory: $selectedCategory, categories: $categories, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ProductListStateCopyWith<$Res> implements $ProductListStateCopyWith<$Res> {
  factory _$ProductListStateCopyWith(_ProductListState value, $Res Function(_ProductListState) _then) = __$ProductListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<Product> products, List<Product> filteredProducts, List<Product> favoriteProducts, String searchQuery, int selectedTabIndex, String? selectedCategory, List<String> categories, String? errorMessage
});




}
/// @nodoc
class __$ProductListStateCopyWithImpl<$Res>
    implements _$ProductListStateCopyWith<$Res> {
  __$ProductListStateCopyWithImpl(this._self, this._then);

  final _ProductListState _self;
  final $Res Function(_ProductListState) _then;

/// Create a copy of ProductListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? products = null,Object? filteredProducts = null,Object? favoriteProducts = null,Object? searchQuery = null,Object? selectedTabIndex = null,Object? selectedCategory = freezed,Object? categories = null,Object? errorMessage = freezed,}) {
  return _then(_ProductListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,filteredProducts: null == filteredProducts ? _self._filteredProducts : filteredProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,favoriteProducts: null == favoriteProducts ? _self._favoriteProducts : favoriteProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedTabIndex: null == selectedTabIndex ? _self.selectedTabIndex : selectedTabIndex // ignore: cast_nullable_to_non_nullable
as int,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
