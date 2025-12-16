// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pos_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PosState {

 List<OrderItem> get cartItems; double get totalAmount; String? get couponCode; Promotion? get appliedCoupon; double get subtotal; double get cartDiscount; double get vatAmount; double get serviceFee;
/// Create a copy of PosState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosStateCopyWith<PosState> get copyWith => _$PosStateCopyWithImpl<PosState>(this as PosState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosState&&const DeepCollectionEquality().equals(other.cartItems, cartItems)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.appliedCoupon, appliedCoupon) || other.appliedCoupon == appliedCoupon)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.cartDiscount, cartDiscount) || other.cartDiscount == cartDiscount)&&(identical(other.vatAmount, vatAmount) || other.vatAmount == vatAmount)&&(identical(other.serviceFee, serviceFee) || other.serviceFee == serviceFee));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cartItems),totalAmount,couponCode,appliedCoupon,subtotal,cartDiscount,vatAmount,serviceFee);

@override
String toString() {
  return 'PosState(cartItems: $cartItems, totalAmount: $totalAmount, couponCode: $couponCode, appliedCoupon: $appliedCoupon, subtotal: $subtotal, cartDiscount: $cartDiscount, vatAmount: $vatAmount, serviceFee: $serviceFee)';
}


}

/// @nodoc
abstract mixin class $PosStateCopyWith<$Res>  {
  factory $PosStateCopyWith(PosState value, $Res Function(PosState) _then) = _$PosStateCopyWithImpl;
@useResult
$Res call({
 List<OrderItem> cartItems, double totalAmount, String? couponCode, Promotion? appliedCoupon, double subtotal, double cartDiscount, double vatAmount, double serviceFee
});




}
/// @nodoc
class _$PosStateCopyWithImpl<$Res>
    implements $PosStateCopyWith<$Res> {
  _$PosStateCopyWithImpl(this._self, this._then);

  final PosState _self;
  final $Res Function(PosState) _then;

/// Create a copy of PosState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cartItems = null,Object? totalAmount = null,Object? couponCode = freezed,Object? appliedCoupon = freezed,Object? subtotal = null,Object? cartDiscount = null,Object? vatAmount = null,Object? serviceFee = null,}) {
  return _then(_self.copyWith(
cartItems: null == cartItems ? _self.cartItems : cartItems // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,appliedCoupon: freezed == appliedCoupon ? _self.appliedCoupon : appliedCoupon // ignore: cast_nullable_to_non_nullable
as Promotion?,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,cartDiscount: null == cartDiscount ? _self.cartDiscount : cartDiscount // ignore: cast_nullable_to_non_nullable
as double,vatAmount: null == vatAmount ? _self.vatAmount : vatAmount // ignore: cast_nullable_to_non_nullable
as double,serviceFee: null == serviceFee ? _self.serviceFee : serviceFee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PosState].
extension PosStatePatterns on PosState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosState value)  $default,){
final _that = this;
switch (_that) {
case _PosState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosState value)?  $default,){
final _that = this;
switch (_that) {
case _PosState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OrderItem> cartItems,  double totalAmount,  String? couponCode,  Promotion? appliedCoupon,  double subtotal,  double cartDiscount,  double vatAmount,  double serviceFee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PosState() when $default != null:
return $default(_that.cartItems,_that.totalAmount,_that.couponCode,_that.appliedCoupon,_that.subtotal,_that.cartDiscount,_that.vatAmount,_that.serviceFee);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OrderItem> cartItems,  double totalAmount,  String? couponCode,  Promotion? appliedCoupon,  double subtotal,  double cartDiscount,  double vatAmount,  double serviceFee)  $default,) {final _that = this;
switch (_that) {
case _PosState():
return $default(_that.cartItems,_that.totalAmount,_that.couponCode,_that.appliedCoupon,_that.subtotal,_that.cartDiscount,_that.vatAmount,_that.serviceFee);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OrderItem> cartItems,  double totalAmount,  String? couponCode,  Promotion? appliedCoupon,  double subtotal,  double cartDiscount,  double vatAmount,  double serviceFee)?  $default,) {final _that = this;
switch (_that) {
case _PosState() when $default != null:
return $default(_that.cartItems,_that.totalAmount,_that.couponCode,_that.appliedCoupon,_that.subtotal,_that.cartDiscount,_that.vatAmount,_that.serviceFee);case _:
  return null;

}
}

}

/// @nodoc


class _PosState implements PosState {
  const _PosState({final  List<OrderItem> cartItems = const <OrderItem>[], this.totalAmount = 0.0, this.couponCode, this.appliedCoupon, this.subtotal = 0.0, this.cartDiscount = 0.0, this.vatAmount = 0.0, this.serviceFee = 0.0}): _cartItems = cartItems;
  

 final  List<OrderItem> _cartItems;
@override@JsonKey() List<OrderItem> get cartItems {
  if (_cartItems is EqualUnmodifiableListView) return _cartItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cartItems);
}

@override@JsonKey() final  double totalAmount;
@override final  String? couponCode;
@override final  Promotion? appliedCoupon;
@override@JsonKey() final  double subtotal;
@override@JsonKey() final  double cartDiscount;
@override@JsonKey() final  double vatAmount;
@override@JsonKey() final  double serviceFee;

/// Create a copy of PosState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosStateCopyWith<_PosState> get copyWith => __$PosStateCopyWithImpl<_PosState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosState&&const DeepCollectionEquality().equals(other._cartItems, _cartItems)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.appliedCoupon, appliedCoupon) || other.appliedCoupon == appliedCoupon)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.cartDiscount, cartDiscount) || other.cartDiscount == cartDiscount)&&(identical(other.vatAmount, vatAmount) || other.vatAmount == vatAmount)&&(identical(other.serviceFee, serviceFee) || other.serviceFee == serviceFee));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cartItems),totalAmount,couponCode,appliedCoupon,subtotal,cartDiscount,vatAmount,serviceFee);

@override
String toString() {
  return 'PosState(cartItems: $cartItems, totalAmount: $totalAmount, couponCode: $couponCode, appliedCoupon: $appliedCoupon, subtotal: $subtotal, cartDiscount: $cartDiscount, vatAmount: $vatAmount, serviceFee: $serviceFee)';
}


}

/// @nodoc
abstract mixin class _$PosStateCopyWith<$Res> implements $PosStateCopyWith<$Res> {
  factory _$PosStateCopyWith(_PosState value, $Res Function(_PosState) _then) = __$PosStateCopyWithImpl;
@override @useResult
$Res call({
 List<OrderItem> cartItems, double totalAmount, String? couponCode, Promotion? appliedCoupon, double subtotal, double cartDiscount, double vatAmount, double serviceFee
});




}
/// @nodoc
class __$PosStateCopyWithImpl<$Res>
    implements _$PosStateCopyWith<$Res> {
  __$PosStateCopyWithImpl(this._self, this._then);

  final _PosState _self;
  final $Res Function(_PosState) _then;

/// Create a copy of PosState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cartItems = null,Object? totalAmount = null,Object? couponCode = freezed,Object? appliedCoupon = freezed,Object? subtotal = null,Object? cartDiscount = null,Object? vatAmount = null,Object? serviceFee = null,}) {
  return _then(_PosState(
cartItems: null == cartItems ? _self._cartItems : cartItems // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,appliedCoupon: freezed == appliedCoupon ? _self.appliedCoupon : appliedCoupon // ignore: cast_nullable_to_non_nullable
as Promotion?,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,cartDiscount: null == cartDiscount ? _self.cartDiscount : cartDiscount // ignore: cast_nullable_to_non_nullable
as double,vatAmount: null == vatAmount ? _self.vatAmount : vatAmount // ignore: cast_nullable_to_non_nullable
as double,serviceFee: null == serviceFee ? _self.serviceFee : serviceFee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
