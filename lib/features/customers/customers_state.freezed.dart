// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomersState {

 bool get isLoading; List<Customer> get customers; String get searchQuery; String? get errorMessage;
/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomersStateCopyWith<CustomersState> get copyWith => _$CustomersStateCopyWithImpl<CustomersState>(this as CustomersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.customers, customers)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(customers),searchQuery,errorMessage);

@override
String toString() {
  return 'CustomersState(isLoading: $isLoading, customers: $customers, searchQuery: $searchQuery, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CustomersStateCopyWith<$Res>  {
  factory $CustomersStateCopyWith(CustomersState value, $Res Function(CustomersState) _then) = _$CustomersStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<Customer> customers, String searchQuery, String? errorMessage
});




}
/// @nodoc
class _$CustomersStateCopyWithImpl<$Res>
    implements $CustomersStateCopyWith<$Res> {
  _$CustomersStateCopyWithImpl(this._self, this._then);

  final CustomersState _self;
  final $Res Function(CustomersState) _then;

/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? customers = null,Object? searchQuery = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,customers: null == customers ? _self.customers : customers // ignore: cast_nullable_to_non_nullable
as List<Customer>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomersState].
extension CustomersStatePatterns on CustomersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomersState value)  $default,){
final _that = this;
switch (_that) {
case _CustomersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomersState value)?  $default,){
final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<Customer> customers,  String searchQuery,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
return $default(_that.isLoading,_that.customers,_that.searchQuery,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<Customer> customers,  String searchQuery,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CustomersState():
return $default(_that.isLoading,_that.customers,_that.searchQuery,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<Customer> customers,  String searchQuery,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
return $default(_that.isLoading,_that.customers,_that.searchQuery,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CustomersState implements CustomersState {
  const _CustomersState({this.isLoading = true, final  List<Customer> customers = const [], this.searchQuery = '', this.errorMessage}): _customers = customers;
  

@override@JsonKey() final  bool isLoading;
 final  List<Customer> _customers;
@override@JsonKey() List<Customer> get customers {
  if (_customers is EqualUnmodifiableListView) return _customers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customers);
}

@override@JsonKey() final  String searchQuery;
@override final  String? errorMessage;

/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomersStateCopyWith<_CustomersState> get copyWith => __$CustomersStateCopyWithImpl<_CustomersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._customers, _customers)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_customers),searchQuery,errorMessage);

@override
String toString() {
  return 'CustomersState(isLoading: $isLoading, customers: $customers, searchQuery: $searchQuery, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CustomersStateCopyWith<$Res> implements $CustomersStateCopyWith<$Res> {
  factory _$CustomersStateCopyWith(_CustomersState value, $Res Function(_CustomersState) _then) = __$CustomersStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<Customer> customers, String searchQuery, String? errorMessage
});




}
/// @nodoc
class __$CustomersStateCopyWithImpl<$Res>
    implements _$CustomersStateCopyWith<$Res> {
  __$CustomersStateCopyWithImpl(this._self, this._then);

  final _CustomersState _self;
  final $Res Function(_CustomersState) _then;

/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? customers = null,Object? searchQuery = null,Object? errorMessage = freezed,}) {
  return _then(_CustomersState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,customers: null == customers ? _self._customers : customers // ignore: cast_nullable_to_non_nullable
as List<Customer>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
