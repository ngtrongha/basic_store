// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {

 bool get isLoading; int get totalProducts; int get totalOrders; double get totalRevenue; int get lowStockCount; int get totalCustomers; double get todayRevenue; int get todayOrders; AppUser? get currentUser; String? get errorMessage;// Product lists
 List<Product> get recentProducts; List<Product> get lowStockProducts; List<ProductSalesInfo> get bestSellingProducts;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.totalProducts, totalProducts) || other.totalProducts == totalProducts)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.lowStockCount, lowStockCount) || other.lowStockCount == lowStockCount)&&(identical(other.totalCustomers, totalCustomers) || other.totalCustomers == totalCustomers)&&(identical(other.todayRevenue, todayRevenue) || other.todayRevenue == todayRevenue)&&(identical(other.todayOrders, todayOrders) || other.todayOrders == todayOrders)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.recentProducts, recentProducts)&&const DeepCollectionEquality().equals(other.lowStockProducts, lowStockProducts)&&const DeepCollectionEquality().equals(other.bestSellingProducts, bestSellingProducts));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,totalProducts,totalOrders,totalRevenue,lowStockCount,totalCustomers,todayRevenue,todayOrders,currentUser,errorMessage,const DeepCollectionEquality().hash(recentProducts),const DeepCollectionEquality().hash(lowStockProducts),const DeepCollectionEquality().hash(bestSellingProducts));

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, totalProducts: $totalProducts, totalOrders: $totalOrders, totalRevenue: $totalRevenue, lowStockCount: $lowStockCount, totalCustomers: $totalCustomers, todayRevenue: $todayRevenue, todayOrders: $todayOrders, currentUser: $currentUser, errorMessage: $errorMessage, recentProducts: $recentProducts, lowStockProducts: $lowStockProducts, bestSellingProducts: $bestSellingProducts)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, int totalProducts, int totalOrders, double totalRevenue, int lowStockCount, int totalCustomers, double todayRevenue, int todayOrders, AppUser? currentUser, String? errorMessage, List<Product> recentProducts, List<Product> lowStockProducts, List<ProductSalesInfo> bestSellingProducts
});




}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? totalProducts = null,Object? totalOrders = null,Object? totalRevenue = null,Object? lowStockCount = null,Object? totalCustomers = null,Object? todayRevenue = null,Object? todayOrders = null,Object? currentUser = freezed,Object? errorMessage = freezed,Object? recentProducts = null,Object? lowStockProducts = null,Object? bestSellingProducts = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,totalProducts: null == totalProducts ? _self.totalProducts : totalProducts // ignore: cast_nullable_to_non_nullable
as int,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,lowStockCount: null == lowStockCount ? _self.lowStockCount : lowStockCount // ignore: cast_nullable_to_non_nullable
as int,totalCustomers: null == totalCustomers ? _self.totalCustomers : totalCustomers // ignore: cast_nullable_to_non_nullable
as int,todayRevenue: null == todayRevenue ? _self.todayRevenue : todayRevenue // ignore: cast_nullable_to_non_nullable
as double,todayOrders: null == todayOrders ? _self.todayOrders : todayOrders // ignore: cast_nullable_to_non_nullable
as int,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as AppUser?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,recentProducts: null == recentProducts ? _self.recentProducts : recentProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,lowStockProducts: null == lowStockProducts ? _self.lowStockProducts : lowStockProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,bestSellingProducts: null == bestSellingProducts ? _self.bestSellingProducts : bestSellingProducts // ignore: cast_nullable_to_non_nullable
as List<ProductSalesInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardState value)  $default,){
final _that = this;
switch (_that) {
case _DashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  int totalProducts,  int totalOrders,  double totalRevenue,  int lowStockCount,  int totalCustomers,  double todayRevenue,  int todayOrders,  AppUser? currentUser,  String? errorMessage,  List<Product> recentProducts,  List<Product> lowStockProducts,  List<ProductSalesInfo> bestSellingProducts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.isLoading,_that.totalProducts,_that.totalOrders,_that.totalRevenue,_that.lowStockCount,_that.totalCustomers,_that.todayRevenue,_that.todayOrders,_that.currentUser,_that.errorMessage,_that.recentProducts,_that.lowStockProducts,_that.bestSellingProducts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  int totalProducts,  int totalOrders,  double totalRevenue,  int lowStockCount,  int totalCustomers,  double todayRevenue,  int todayOrders,  AppUser? currentUser,  String? errorMessage,  List<Product> recentProducts,  List<Product> lowStockProducts,  List<ProductSalesInfo> bestSellingProducts)  $default,) {final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that.isLoading,_that.totalProducts,_that.totalOrders,_that.totalRevenue,_that.lowStockCount,_that.totalCustomers,_that.todayRevenue,_that.todayOrders,_that.currentUser,_that.errorMessage,_that.recentProducts,_that.lowStockProducts,_that.bestSellingProducts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  int totalProducts,  int totalOrders,  double totalRevenue,  int lowStockCount,  int totalCustomers,  double todayRevenue,  int todayOrders,  AppUser? currentUser,  String? errorMessage,  List<Product> recentProducts,  List<Product> lowStockProducts,  List<ProductSalesInfo> bestSellingProducts)?  $default,) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.isLoading,_that.totalProducts,_that.totalOrders,_that.totalRevenue,_that.lowStockCount,_that.totalCustomers,_that.todayRevenue,_that.todayOrders,_that.currentUser,_that.errorMessage,_that.recentProducts,_that.lowStockProducts,_that.bestSellingProducts);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardState implements DashboardState {
  const _DashboardState({this.isLoading = true, this.totalProducts = 0, this.totalOrders = 0, this.totalRevenue = 0.0, this.lowStockCount = 0, this.totalCustomers = 0, this.todayRevenue = 0.0, this.todayOrders = 0, this.currentUser, this.errorMessage, final  List<Product> recentProducts = const [], final  List<Product> lowStockProducts = const [], final  List<ProductSalesInfo> bestSellingProducts = const []}): _recentProducts = recentProducts,_lowStockProducts = lowStockProducts,_bestSellingProducts = bestSellingProducts;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  int totalProducts;
@override@JsonKey() final  int totalOrders;
@override@JsonKey() final  double totalRevenue;
@override@JsonKey() final  int lowStockCount;
@override@JsonKey() final  int totalCustomers;
@override@JsonKey() final  double todayRevenue;
@override@JsonKey() final  int todayOrders;
@override final  AppUser? currentUser;
@override final  String? errorMessage;
// Product lists
 final  List<Product> _recentProducts;
// Product lists
@override@JsonKey() List<Product> get recentProducts {
  if (_recentProducts is EqualUnmodifiableListView) return _recentProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentProducts);
}

 final  List<Product> _lowStockProducts;
@override@JsonKey() List<Product> get lowStockProducts {
  if (_lowStockProducts is EqualUnmodifiableListView) return _lowStockProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lowStockProducts);
}

 final  List<ProductSalesInfo> _bestSellingProducts;
@override@JsonKey() List<ProductSalesInfo> get bestSellingProducts {
  if (_bestSellingProducts is EqualUnmodifiableListView) return _bestSellingProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bestSellingProducts);
}


/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.totalProducts, totalProducts) || other.totalProducts == totalProducts)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.lowStockCount, lowStockCount) || other.lowStockCount == lowStockCount)&&(identical(other.totalCustomers, totalCustomers) || other.totalCustomers == totalCustomers)&&(identical(other.todayRevenue, todayRevenue) || other.todayRevenue == todayRevenue)&&(identical(other.todayOrders, todayOrders) || other.todayOrders == todayOrders)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._recentProducts, _recentProducts)&&const DeepCollectionEquality().equals(other._lowStockProducts, _lowStockProducts)&&const DeepCollectionEquality().equals(other._bestSellingProducts, _bestSellingProducts));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,totalProducts,totalOrders,totalRevenue,lowStockCount,totalCustomers,todayRevenue,todayOrders,currentUser,errorMessage,const DeepCollectionEquality().hash(_recentProducts),const DeepCollectionEquality().hash(_lowStockProducts),const DeepCollectionEquality().hash(_bestSellingProducts));

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, totalProducts: $totalProducts, totalOrders: $totalOrders, totalRevenue: $totalRevenue, lowStockCount: $lowStockCount, totalCustomers: $totalCustomers, todayRevenue: $todayRevenue, todayOrders: $todayOrders, currentUser: $currentUser, errorMessage: $errorMessage, recentProducts: $recentProducts, lowStockProducts: $lowStockProducts, bestSellingProducts: $bestSellingProducts)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, int totalProducts, int totalOrders, double totalRevenue, int lowStockCount, int totalCustomers, double todayRevenue, int todayOrders, AppUser? currentUser, String? errorMessage, List<Product> recentProducts, List<Product> lowStockProducts, List<ProductSalesInfo> bestSellingProducts
});




}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? totalProducts = null,Object? totalOrders = null,Object? totalRevenue = null,Object? lowStockCount = null,Object? totalCustomers = null,Object? todayRevenue = null,Object? todayOrders = null,Object? currentUser = freezed,Object? errorMessage = freezed,Object? recentProducts = null,Object? lowStockProducts = null,Object? bestSellingProducts = null,}) {
  return _then(_DashboardState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,totalProducts: null == totalProducts ? _self.totalProducts : totalProducts // ignore: cast_nullable_to_non_nullable
as int,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,lowStockCount: null == lowStockCount ? _self.lowStockCount : lowStockCount // ignore: cast_nullable_to_non_nullable
as int,totalCustomers: null == totalCustomers ? _self.totalCustomers : totalCustomers // ignore: cast_nullable_to_non_nullable
as int,todayRevenue: null == todayRevenue ? _self.todayRevenue : todayRevenue // ignore: cast_nullable_to_non_nullable
as double,todayOrders: null == todayOrders ? _self.todayOrders : todayOrders // ignore: cast_nullable_to_non_nullable
as int,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as AppUser?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,recentProducts: null == recentProducts ? _self._recentProducts : recentProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,lowStockProducts: null == lowStockProducts ? _self._lowStockProducts : lowStockProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,bestSellingProducts: null == bestSellingProducts ? _self._bestSellingProducts : bestSellingProducts // ignore: cast_nullable_to_non_nullable
as List<ProductSalesInfo>,
  ));
}


}

// dart format on
