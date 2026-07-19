// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hourly_measure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HourlyMeasure {

 DateTime get time; double get value;
/// Create a copy of HourlyMeasure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourlyMeasureCopyWith<HourlyMeasure> get copyWith => _$HourlyMeasureCopyWithImpl<HourlyMeasure>(this as HourlyMeasure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HourlyMeasure&&(identical(other.time, time) || other.time == time)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,time,value);

@override
String toString() {
  return 'HourlyMeasure(time: $time, value: $value)';
}


}

/// @nodoc
abstract mixin class $HourlyMeasureCopyWith<$Res>  {
  factory $HourlyMeasureCopyWith(HourlyMeasure value, $Res Function(HourlyMeasure) _then) = _$HourlyMeasureCopyWithImpl;
@useResult
$Res call({
 DateTime time, double value
});




}
/// @nodoc
class _$HourlyMeasureCopyWithImpl<$Res>
    implements $HourlyMeasureCopyWith<$Res> {
  _$HourlyMeasureCopyWithImpl(this._self, this._then);

  final HourlyMeasure _self;
  final $Res Function(HourlyMeasure) _then;

/// Create a copy of HourlyMeasure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? value = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [HourlyMeasure].
extension HourlyMeasurePatterns on HourlyMeasure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HourlyMeasure value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HourlyMeasure() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HourlyMeasure value)  $default,){
final _that = this;
switch (_that) {
case _HourlyMeasure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HourlyMeasure value)?  $default,){
final _that = this;
switch (_that) {
case _HourlyMeasure() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime time,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HourlyMeasure() when $default != null:
return $default(_that.time,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime time,  double value)  $default,) {final _that = this;
switch (_that) {
case _HourlyMeasure():
return $default(_that.time,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime time,  double value)?  $default,) {final _that = this;
switch (_that) {
case _HourlyMeasure() when $default != null:
return $default(_that.time,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _HourlyMeasure implements HourlyMeasure {
  const _HourlyMeasure({required this.time, required this.value});
  

@override final  DateTime time;
@override final  double value;

/// Create a copy of HourlyMeasure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourlyMeasureCopyWith<_HourlyMeasure> get copyWith => __$HourlyMeasureCopyWithImpl<_HourlyMeasure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HourlyMeasure&&(identical(other.time, time) || other.time == time)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,time,value);

@override
String toString() {
  return 'HourlyMeasure(time: $time, value: $value)';
}


}

/// @nodoc
abstract mixin class _$HourlyMeasureCopyWith<$Res> implements $HourlyMeasureCopyWith<$Res> {
  factory _$HourlyMeasureCopyWith(_HourlyMeasure value, $Res Function(_HourlyMeasure) _then) = __$HourlyMeasureCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, double value
});




}
/// @nodoc
class __$HourlyMeasureCopyWithImpl<$Res>
    implements _$HourlyMeasureCopyWith<$Res> {
  __$HourlyMeasureCopyWithImpl(this._self, this._then);

  final _HourlyMeasure _self;
  final $Res Function(_HourlyMeasure) _then;

/// Create a copy of HourlyMeasure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? value = null,}) {
  return _then(_HourlyMeasure(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
