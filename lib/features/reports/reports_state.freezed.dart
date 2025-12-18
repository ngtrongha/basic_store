// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsState {

 bool get isLoading; bool get isExporting; DateTime get startDate; DateTime get endDate; double get totalRevenue; int get totalOrders; double get averageOrderValue; List<TopProductInfo> get topProducts; String? get errorMessage;
/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsStateCopyWith<ReportsState> get copyWith => _$ReportsStateCopyWithImpl<ReportsState>(this as ReportsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isExporting, isExporting) || other.isExporting == isExporting)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.averageOrderValue, averageOrderValue) || other.averageOrderValue == averageOrderValue)&&const DeepCollectionEquality().equals(other.topProducts, topProducts)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isExporting,startDate,endDate,totalRevenue,totalOrders,averageOrderValue,const DeepCollectionEquality().hash(topProducts),errorMessage);

@override
String toString() {
  return 'ReportsState(isLoading: $isLoading, isExporting: $isExporting, startDate: $startDate, endDate: $endDate, totalRevenue: $totalRevenue, totalOrders: $totalOrders, averageOrderValue: $averageOrderValue, topProducts: $topProducts, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ReportsStateCopyWith<$Res>  {
  factory $ReportsStateCopyWith(ReportsState value, $Res Function(ReportsState) _then) = _$ReportsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isExporting, DateTime startDate, DateTime endDate, double totalRevenue, int totalOrders, double averageOrderValue, List<TopProductInfo> topProducts, String? errorMessage
});




}
/// @nodoc
class _$ReportsStateCopyWithImpl<$Res>
    implements $ReportsStateCopyWith<$Res> {
  _$ReportsStateCopyWithImpl(this._self, this._then);

  final ReportsState _self;
  final $Res Function(ReportsState) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isExporting = null,Object? startDate = null,Object? endDate = null,Object? totalRevenue = null,Object? totalOrders = null,Object? averageOrderValue = null,Object? topProducts = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isExporting: null == isExporting ? _self.isExporting : isExporting // ignore: cast_nullable_to_non_nullable
as bool,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,averageOrderValue: null == averageOrderValue ? _self.averageOrderValue : averageOrderValue // ignore: cast_nullable_to_non_nullable
as double,topProducts: null == topProducts ? _self.topProducts : topProducts // ignore: cast_nullable_to_non_nullable
as List<TopProductInfo>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportsState].
extension ReportsStatePatterns on ReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportsState value)  $default,){
final _that = this;
switch (_that) {
case _ReportsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportsState value)?  $default,){
final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isExporting,  DateTime startDate,  DateTime endDate,  double totalRevenue,  int totalOrders,  double averageOrderValue,  List<TopProductInfo> topProducts,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
return $default(_that.isLoading,_that.isExporting,_that.startDate,_that.endDate,_that.totalRevenue,_that.totalOrders,_that.averageOrderValue,_that.topProducts,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isExporting,  DateTime startDate,  DateTime endDate,  double totalRevenue,  int totalOrders,  double averageOrderValue,  List<TopProductInfo> topProducts,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ReportsState():
return $default(_that.isLoading,_that.isExporting,_that.startDate,_that.endDate,_that.totalRevenue,_that.totalOrders,_that.averageOrderValue,_that.topProducts,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isExporting,  DateTime startDate,  DateTime endDate,  double totalRevenue,  int totalOrders,  double averageOrderValue,  List<TopProductInfo> topProducts,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
return $default(_that.isLoading,_that.isExporting,_that.startDate,_that.endDate,_that.totalRevenue,_that.totalOrders,_that.averageOrderValue,_that.topProducts,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ReportsState implements ReportsState {
  const _ReportsState({this.isLoading = true, this.isExporting = false, required this.startDate, required this.endDate, this.totalRevenue = 0.0, this.totalOrders = 0, this.averageOrderValue = 0.0, final  List<TopProductInfo> topProducts = const [], this.errorMessage}): _topProducts = topProducts;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isExporting;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override@JsonKey() final  double totalRevenue;
@override@JsonKey() final  int totalOrders;
@override@JsonKey() final  double averageOrderValue;
 final  List<TopProductInfo> _topProducts;
@override@JsonKey() List<TopProductInfo> get topProducts {
  if (_topProducts is EqualUnmodifiableListView) return _topProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topProducts);
}

@override final  String? errorMessage;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsStateCopyWith<_ReportsState> get copyWith => __$ReportsStateCopyWithImpl<_ReportsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isExporting, isExporting) || other.isExporting == isExporting)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.averageOrderValue, averageOrderValue) || other.averageOrderValue == averageOrderValue)&&const DeepCollectionEquality().equals(other._topProducts, _topProducts)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isExporting,startDate,endDate,totalRevenue,totalOrders,averageOrderValue,const DeepCollectionEquality().hash(_topProducts),errorMessage);

@override
String toString() {
  return 'ReportsState(isLoading: $isLoading, isExporting: $isExporting, startDate: $startDate, endDate: $endDate, totalRevenue: $totalRevenue, totalOrders: $totalOrders, averageOrderValue: $averageOrderValue, topProducts: $topProducts, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ReportsStateCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory _$ReportsStateCopyWith(_ReportsState value, $Res Function(_ReportsState) _then) = __$ReportsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isExporting, DateTime startDate, DateTime endDate, double totalRevenue, int totalOrders, double averageOrderValue, List<TopProductInfo> topProducts, String? errorMessage
});




}
/// @nodoc
class __$ReportsStateCopyWithImpl<$Res>
    implements _$ReportsStateCopyWith<$Res> {
  __$ReportsStateCopyWithImpl(this._self, this._then);

  final _ReportsState _self;
  final $Res Function(_ReportsState) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isExporting = null,Object? startDate = null,Object? endDate = null,Object? totalRevenue = null,Object? totalOrders = null,Object? averageOrderValue = null,Object? topProducts = null,Object? errorMessage = freezed,}) {
  return _then(_ReportsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isExporting: null == isExporting ? _self.isExporting : isExporting // ignore: cast_nullable_to_non_nullable
as bool,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,averageOrderValue: null == averageOrderValue ? _self.averageOrderValue : averageOrderValue // ignore: cast_nullable_to_non_nullable
as double,topProducts: null == topProducts ? _self._topProducts : topProducts // ignore: cast_nullable_to_non_nullable
as List<TopProductInfo>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
