// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coffee_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CoffeeEntry {

 String get id; DateTime get timestamp;
/// Create a copy of CoffeeEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoffeeEntryCopyWith<CoffeeEntry> get copyWith => _$CoffeeEntryCopyWithImpl<CoffeeEntry>(this as CoffeeEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CoffeeEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoffeeEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}


@override
int get hashCode {
  final _this = this as CoffeeEntry;
  return Object.hash(runtimeType,_this.id,_this.timestamp);
}

@override
String toString() {
  final _this = this as CoffeeEntry;
  return 'CoffeeEntry(id: ${_this.id}, timestamp: ${_this.timestamp})';
}


}

/// @nodoc
abstract mixin class $CoffeeEntryCopyWith<$Res>  {
  factory $CoffeeEntryCopyWith(CoffeeEntry value, $Res Function(CoffeeEntry) _then) = _$CoffeeEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime timestamp
});




}
/// @nodoc
class _$CoffeeEntryCopyWithImpl<$Res>
    implements $CoffeeEntryCopyWith<$Res> {
  _$CoffeeEntryCopyWithImpl(this._self, this._then);

  final CoffeeEntry _self;
  final $Res Function(CoffeeEntry) _then;

/// Create a copy of CoffeeEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? timestamp = null,}) {
  return _then(CoffeeEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CoffeeEntry].
extension CoffeeEntryPatterns on CoffeeEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoffeeEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoffeeEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoffeeEntry value)  $default,){
final _that = this;
switch (_that) {
case _CoffeeEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoffeeEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CoffeeEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoffeeEntry() when $default != null:
return $default(_that.id,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _CoffeeEntry():
return $default(_that.id,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _CoffeeEntry() when $default != null:
return $default(_that.id,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _CoffeeEntry implements CoffeeEntry {
  const _CoffeeEntry({required this.id, required this.timestamp});
  

@override final  String id;
@override final  DateTime timestamp;

/// Create a copy of CoffeeEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoffeeEntryCopyWith<_CoffeeEntry> get copyWith => __$CoffeeEntryCopyWithImpl<_CoffeeEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoffeeEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,timestamp);
}

@override
String toString() {
    return 'CoffeeEntry(id: $id, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$CoffeeEntryCopyWith<$Res> implements $CoffeeEntryCopyWith<$Res> {
  factory _$CoffeeEntryCopyWith(_CoffeeEntry value, $Res Function(_CoffeeEntry) _then) = __$CoffeeEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime timestamp
});




}
/// @nodoc
class __$CoffeeEntryCopyWithImpl<$Res>
    implements _$CoffeeEntryCopyWith<$Res> {
  __$CoffeeEntryCopyWithImpl(this._self, this._then);

  final _CoffeeEntry _self;
  final $Res Function(_CoffeeEntry) _then;

/// Create a copy of CoffeeEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,}) {
  return _then(_CoffeeEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
