// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherPoint {

 DateTime get timestamp; double? get temperature; double? get pressure;
/// Create a copy of WeatherPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherPointCopyWith<WeatherPoint> get copyWith => _$WeatherPointCopyWithImpl<WeatherPoint>(this as WeatherPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherPoint&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.pressure, pressure) || other.pressure == pressure));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,temperature,pressure);

@override
String toString() {
  return 'WeatherPoint(timestamp: $timestamp, temperature: $temperature, pressure: $pressure)';
}


}

/// @nodoc
abstract mixin class $WeatherPointCopyWith<$Res>  {
  factory $WeatherPointCopyWith(WeatherPoint value, $Res Function(WeatherPoint) _then) = _$WeatherPointCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, double? temperature, double? pressure
});




}
/// @nodoc
class _$WeatherPointCopyWithImpl<$Res>
    implements $WeatherPointCopyWith<$Res> {
  _$WeatherPointCopyWithImpl(this._self, this._then);

  final WeatherPoint _self;
  final $Res Function(WeatherPoint) _then;

/// Create a copy of WeatherPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? temperature = freezed,Object? pressure = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherPoint].
extension WeatherPointPatterns on WeatherPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherPoint value)  $default,){
final _that = this;
switch (_that) {
case _WeatherPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherPoint value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  double? temperature,  double? pressure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherPoint() when $default != null:
return $default(_that.timestamp,_that.temperature,_that.pressure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  double? temperature,  double? pressure)  $default,) {final _that = this;
switch (_that) {
case _WeatherPoint():
return $default(_that.timestamp,_that.temperature,_that.pressure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  double? temperature,  double? pressure)?  $default,) {final _that = this;
switch (_that) {
case _WeatherPoint() when $default != null:
return $default(_that.timestamp,_that.temperature,_that.pressure);case _:
  return null;

}
}

}

/// @nodoc


class _WeatherPoint implements WeatherPoint {
  const _WeatherPoint({required this.timestamp, this.temperature, this.pressure});
  

@override final  DateTime timestamp;
@override final  double? temperature;
@override final  double? pressure;

/// Create a copy of WeatherPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherPointCopyWith<_WeatherPoint> get copyWith => __$WeatherPointCopyWithImpl<_WeatherPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherPoint&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.pressure, pressure) || other.pressure == pressure));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,temperature,pressure);

@override
String toString() {
  return 'WeatherPoint(timestamp: $timestamp, temperature: $temperature, pressure: $pressure)';
}


}

/// @nodoc
abstract mixin class _$WeatherPointCopyWith<$Res> implements $WeatherPointCopyWith<$Res> {
  factory _$WeatherPointCopyWith(_WeatherPoint value, $Res Function(_WeatherPoint) _then) = __$WeatherPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, double? temperature, double? pressure
});




}
/// @nodoc
class __$WeatherPointCopyWithImpl<$Res>
    implements _$WeatherPointCopyWith<$Res> {
  __$WeatherPointCopyWithImpl(this._self, this._then);

  final _WeatherPoint _self;
  final $Res Function(_WeatherPoint) _then;

/// Create a copy of WeatherPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? temperature = freezed,Object? pressure = freezed,}) {
  return _then(_WeatherPoint(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
