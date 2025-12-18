// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suppliers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SuppliersState {

 bool get isLoading; List<Supplier> get suppliers; String get searchQuery; String? get errorMessage;
/// Create a copy of SuppliersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuppliersStateCopyWith<SuppliersState> get copyWith => _$SuppliersStateCopyWithImpl<SuppliersState>(this as SuppliersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuppliersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.suppliers, suppliers)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(suppliers),searchQuery,errorMessage);

@override
String toString() {
  return 'SuppliersState(isLoading: $isLoading, suppliers: $suppliers, searchQuery: $searchQuery, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SuppliersStateCopyWith<$Res>  {
  factory $SuppliersStateCopyWith(SuppliersState value, $Res Function(SuppliersState) _then) = _$SuppliersStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<Supplier> suppliers, String searchQuery, String? errorMessage
});




}
/// @nodoc
class _$SuppliersStateCopyWithImpl<$Res>
    implements $SuppliersStateCopyWith<$Res> {
  _$SuppliersStateCopyWithImpl(this._self, this._then);

  final SuppliersState _self;
  final $Res Function(SuppliersState) _then;

/// Create a copy of SuppliersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? suppliers = null,Object? searchQuery = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,suppliers: null == suppliers ? _self.suppliers : suppliers // ignore: cast_nullable_to_non_nullable
as List<Supplier>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SuppliersState].
extension SuppliersStatePatterns on SuppliersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuppliersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuppliersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuppliersState value)  $default,){
final _that = this;
switch (_that) {
case _SuppliersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuppliersState value)?  $default,){
final _that = this;
switch (_that) {
case _SuppliersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<Supplier> suppliers,  String searchQuery,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuppliersState() when $default != null:
return $default(_that.isLoading,_that.suppliers,_that.searchQuery,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<Supplier> suppliers,  String searchQuery,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SuppliersState():
return $default(_that.isLoading,_that.suppliers,_that.searchQuery,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<Supplier> suppliers,  String searchQuery,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SuppliersState() when $default != null:
return $default(_that.isLoading,_that.suppliers,_that.searchQuery,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SuppliersState implements SuppliersState {
  const _SuppliersState({this.isLoading = true, final  List<Supplier> suppliers = const [], this.searchQuery = '', this.errorMessage}): _suppliers = suppliers;
  

@override@JsonKey() final  bool isLoading;
 final  List<Supplier> _suppliers;
@override@JsonKey() List<Supplier> get suppliers {
  if (_suppliers is EqualUnmodifiableListView) return _suppliers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suppliers);
}

@override@JsonKey() final  String searchQuery;
@override final  String? errorMessage;

/// Create a copy of SuppliersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuppliersStateCopyWith<_SuppliersState> get copyWith => __$SuppliersStateCopyWithImpl<_SuppliersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuppliersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._suppliers, _suppliers)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_suppliers),searchQuery,errorMessage);

@override
String toString() {
  return 'SuppliersState(isLoading: $isLoading, suppliers: $suppliers, searchQuery: $searchQuery, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SuppliersStateCopyWith<$Res> implements $SuppliersStateCopyWith<$Res> {
  factory _$SuppliersStateCopyWith(_SuppliersState value, $Res Function(_SuppliersState) _then) = __$SuppliersStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<Supplier> suppliers, String searchQuery, String? errorMessage
});




}
/// @nodoc
class __$SuppliersStateCopyWithImpl<$Res>
    implements _$SuppliersStateCopyWith<$Res> {
  __$SuppliersStateCopyWithImpl(this._self, this._then);

  final _SuppliersState _self;
  final $Res Function(_SuppliersState) _then;

/// Create a copy of SuppliersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? suppliers = null,Object? searchQuery = null,Object? errorMessage = freezed,}) {
  return _then(_SuppliersState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,suppliers: null == suppliers ? _self._suppliers : suppliers // ignore: cast_nullable_to_non_nullable
as List<Supplier>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
