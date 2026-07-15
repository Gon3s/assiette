// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherSummary {

 DateTime get timestamp; double? get pressure; double? get pressureDelta; double? get temperature; double? get humidity;
/// Create a copy of WeatherSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherSummaryCopyWith<WeatherSummary> get copyWith => _$WeatherSummaryCopyWithImpl<WeatherSummary>(this as WeatherSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherSummary&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.pressureDelta, pressureDelta) || other.pressureDelta == pressureDelta)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,pressure,pressureDelta,temperature,humidity);

@override
String toString() {
  return 'WeatherSummary(timestamp: $timestamp, pressure: $pressure, pressureDelta: $pressureDelta, temperature: $temperature, humidity: $humidity)';
}


}

/// @nodoc
abstract mixin class $WeatherSummaryCopyWith<$Res>  {
  factory $WeatherSummaryCopyWith(WeatherSummary value, $Res Function(WeatherSummary) _then) = _$WeatherSummaryCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, double? pressure, double? pressureDelta, double? temperature, double? humidity
});




}
/// @nodoc
class _$WeatherSummaryCopyWithImpl<$Res>
    implements $WeatherSummaryCopyWith<$Res> {
  _$WeatherSummaryCopyWithImpl(this._self, this._then);

  final WeatherSummary _self;
  final $Res Function(WeatherSummary) _then;

/// Create a copy of WeatherSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? pressure = freezed,Object? pressureDelta = freezed,Object? temperature = freezed,Object? humidity = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,pressureDelta: freezed == pressureDelta ? _self.pressureDelta : pressureDelta // ignore: cast_nullable_to_non_nullable
as double?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherSummary].
extension WeatherSummaryPatterns on WeatherSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherSummary value)  $default,){
final _that = this;
switch (_that) {
case _WeatherSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherSummary value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  double? pressure,  double? pressureDelta,  double? temperature,  double? humidity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherSummary() when $default != null:
return $default(_that.timestamp,_that.pressure,_that.pressureDelta,_that.temperature,_that.humidity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  double? pressure,  double? pressureDelta,  double? temperature,  double? humidity)  $default,) {final _that = this;
switch (_that) {
case _WeatherSummary():
return $default(_that.timestamp,_that.pressure,_that.pressureDelta,_that.temperature,_that.humidity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  double? pressure,  double? pressureDelta,  double? temperature,  double? humidity)?  $default,) {final _that = this;
switch (_that) {
case _WeatherSummary() when $default != null:
return $default(_that.timestamp,_that.pressure,_that.pressureDelta,_that.temperature,_that.humidity);case _:
  return null;

}
}

}

/// @nodoc


class _WeatherSummary implements WeatherSummary {
  const _WeatherSummary({required this.timestamp, this.pressure, this.pressureDelta, this.temperature, this.humidity});
  

@override final  DateTime timestamp;
@override final  double? pressure;
@override final  double? pressureDelta;
@override final  double? temperature;
@override final  double? humidity;

/// Create a copy of WeatherSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherSummaryCopyWith<_WeatherSummary> get copyWith => __$WeatherSummaryCopyWithImpl<_WeatherSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherSummary&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.pressureDelta, pressureDelta) || other.pressureDelta == pressureDelta)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,pressure,pressureDelta,temperature,humidity);

@override
String toString() {
  return 'WeatherSummary(timestamp: $timestamp, pressure: $pressure, pressureDelta: $pressureDelta, temperature: $temperature, humidity: $humidity)';
}


}

/// @nodoc
abstract mixin class _$WeatherSummaryCopyWith<$Res> implements $WeatherSummaryCopyWith<$Res> {
  factory _$WeatherSummaryCopyWith(_WeatherSummary value, $Res Function(_WeatherSummary) _then) = __$WeatherSummaryCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, double? pressure, double? pressureDelta, double? temperature, double? humidity
});




}
/// @nodoc
class __$WeatherSummaryCopyWithImpl<$Res>
    implements _$WeatherSummaryCopyWith<$Res> {
  __$WeatherSummaryCopyWithImpl(this._self, this._then);

  final _WeatherSummary _self;
  final $Res Function(_WeatherSummary) _then;

/// Create a copy of WeatherSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? pressure = freezed,Object? pressureDelta = freezed,Object? temperature = freezed,Object? humidity = freezed,}) {
  return _then(_WeatherSummary(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,pressureDelta: freezed == pressureDelta ? _self.pressureDelta : pressureDelta // ignore: cast_nullable_to_non_nullable
as double?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
