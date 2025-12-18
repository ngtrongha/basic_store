// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'units_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UnitsState {

 bool get isLoading; List<Unit> get units; String get searchQuery; String? get errorMessage;
/// Create a copy of UnitsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnitsStateCopyWith<UnitsState> get copyWith => _$UnitsStateCopyWithImpl<UnitsState>(this as UnitsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnitsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.units, units)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(units),searchQuery,errorMessage);

@override
String toString() {
  return 'UnitsState(isLoading: $isLoading, units: $units, searchQuery: $searchQuery, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $UnitsStateCopyWith<$Res>  {
  factory $UnitsStateCopyWith(UnitsState value, $Res Function(UnitsState) _then) = _$UnitsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<Unit> units, String searchQuery, String? errorMessage
});




}
/// @nodoc
class _$UnitsStateCopyWithImpl<$Res>
    implements $UnitsStateCopyWith<$Res> {
  _$UnitsStateCopyWithImpl(this._self, this._then);

  final UnitsState _self;
  final $Res Function(UnitsState) _then;

/// Create a copy of UnitsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? units = null,Object? searchQuery = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as List<Unit>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UnitsState].
extension UnitsStatePatterns on UnitsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnitsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnitsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnitsState value)  $default,){
final _that = this;
switch (_that) {
case _UnitsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnitsState value)?  $default,){
final _that = this;
switch (_that) {
case _UnitsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<Unit> units,  String searchQuery,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnitsState() when $default != null:
return $default(_that.isLoading,_that.units,_that.searchQuery,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<Unit> units,  String searchQuery,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _UnitsState():
return $default(_that.isLoading,_that.units,_that.searchQuery,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<Unit> units,  String searchQuery,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _UnitsState() when $default != null:
return $default(_that.isLoading,_that.units,_that.searchQuery,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _UnitsState implements UnitsState {
  const _UnitsState({this.isLoading = true, final  List<Unit> units = const [], this.searchQuery = '', this.errorMessage}): _units = units;
  

@override@JsonKey() final  bool isLoading;
 final  List<Unit> _units;
@override@JsonKey() List<Unit> get units {
  if (_units is EqualUnmodifiableListView) return _units;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_units);
}

@override@JsonKey() final  String searchQuery;
@override final  String? errorMessage;

/// Create a copy of UnitsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnitsStateCopyWith<_UnitsState> get copyWith => __$UnitsStateCopyWithImpl<_UnitsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnitsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._units, _units)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_units),searchQuery,errorMessage);

@override
String toString() {
  return 'UnitsState(isLoading: $isLoading, units: $units, searchQuery: $searchQuery, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$UnitsStateCopyWith<$Res> implements $UnitsStateCopyWith<$Res> {
  factory _$UnitsStateCopyWith(_UnitsState value, $Res Function(_UnitsState) _then) = __$UnitsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<Unit> units, String searchQuery, String? errorMessage
});




}
/// @nodoc
class __$UnitsStateCopyWithImpl<$Res>
    implements _$UnitsStateCopyWith<$Res> {
  __$UnitsStateCopyWithImpl(this._self, this._then);

  final _UnitsState _self;
  final $Res Function(_UnitsState) _then;

/// Create a copy of UnitsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? units = null,Object? searchQuery = null,Object? errorMessage = freezed,}) {
  return _then(_UnitsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,units: null == units ? _self._units : units // ignore: cast_nullable_to_non_nullable
as List<Unit>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
