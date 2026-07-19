// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_meteo_reading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OpenMeteoReading {

 double? get pressure; double? get surfacePressure; double? get temperature; double? get humidity; int? get weatherCode; double? get uvIndex;
/// Create a copy of OpenMeteoReading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenMeteoReadingCopyWith<OpenMeteoReading> get copyWith => _$OpenMeteoReadingCopyWithImpl<OpenMeteoReading>(this as OpenMeteoReading, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenMeteoReading&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.surfacePressure, surfacePressure) || other.surfacePressure == surfacePressure)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex));
}


@override
int get hashCode => Object.hash(runtimeType,pressure,surfacePressure,temperature,humidity,weatherCode,uvIndex);

@override
String toString() {
  return 'OpenMeteoReading(pressure: $pressure, surfacePressure: $surfacePressure, temperature: $temperature, humidity: $humidity, weatherCode: $weatherCode, uvIndex: $uvIndex)';
}


}

/// @nodoc
abstract mixin class $OpenMeteoReadingCopyWith<$Res>  {
  factory $OpenMeteoReadingCopyWith(OpenMeteoReading value, $Res Function(OpenMeteoReading) _then) = _$OpenMeteoReadingCopyWithImpl;
@useResult
$Res call({
 double? pressure, double? surfacePressure, double? temperature, double? humidity, int? weatherCode, double? uvIndex
});




}
/// @nodoc
class _$OpenMeteoReadingCopyWithImpl<$Res>
    implements $OpenMeteoReadingCopyWith<$Res> {
  _$OpenMeteoReadingCopyWithImpl(this._self, this._then);

  final OpenMeteoReading _self;
  final $Res Function(OpenMeteoReading) _then;

/// Create a copy of OpenMeteoReading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pressure = freezed,Object? surfacePressure = freezed,Object? temperature = freezed,Object? humidity = freezed,Object? weatherCode = freezed,Object? uvIndex = freezed,}) {
  return _then(_self.copyWith(
pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,surfacePressure: freezed == surfacePressure ? _self.surfacePressure : surfacePressure // ignore: cast_nullable_to_non_nullable
as double?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double?,weatherCode: freezed == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int?,uvIndex: freezed == uvIndex ? _self.uvIndex : uvIndex // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenMeteoReading].
extension OpenMeteoReadingPatterns on OpenMeteoReading {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenMeteoReading value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenMeteoReading() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenMeteoReading value)  $default,){
final _that = this;
switch (_that) {
case _OpenMeteoReading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenMeteoReading value)?  $default,){
final _that = this;
switch (_that) {
case _OpenMeteoReading() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? pressure,  double? surfacePressure,  double? temperature,  double? humidity,  int? weatherCode,  double? uvIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenMeteoReading() when $default != null:
return $default(_that.pressure,_that.surfacePressure,_that.temperature,_that.humidity,_that.weatherCode,_that.uvIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? pressure,  double? surfacePressure,  double? temperature,  double? humidity,  int? weatherCode,  double? uvIndex)  $default,) {final _that = this;
switch (_that) {
case _OpenMeteoReading():
return $default(_that.pressure,_that.surfacePressure,_that.temperature,_that.humidity,_that.weatherCode,_that.uvIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? pressure,  double? surfacePressure,  double? temperature,  double? humidity,  int? weatherCode,  double? uvIndex)?  $default,) {final _that = this;
switch (_that) {
case _OpenMeteoReading() when $default != null:
return $default(_that.pressure,_that.surfacePressure,_that.temperature,_that.humidity,_that.weatherCode,_that.uvIndex);case _:
  return null;

}
}

}

/// @nodoc


class _OpenMeteoReading implements OpenMeteoReading {
  const _OpenMeteoReading({this.pressure, this.surfacePressure, this.temperature, this.humidity, this.weatherCode, this.uvIndex});
  

@override final  double? pressure;
@override final  double? surfacePressure;
@override final  double? temperature;
@override final  double? humidity;
@override final  int? weatherCode;
@override final  double? uvIndex;

/// Create a copy of OpenMeteoReading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenMeteoReadingCopyWith<_OpenMeteoReading> get copyWith => __$OpenMeteoReadingCopyWithImpl<_OpenMeteoReading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenMeteoReading&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.surfacePressure, surfacePressure) || other.surfacePressure == surfacePressure)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex));
}


@override
int get hashCode => Object.hash(runtimeType,pressure,surfacePressure,temperature,humidity,weatherCode,uvIndex);

@override
String toString() {
  return 'OpenMeteoReading(pressure: $pressure, surfacePressure: $surfacePressure, temperature: $temperature, humidity: $humidity, weatherCode: $weatherCode, uvIndex: $uvIndex)';
}


}

/// @nodoc
abstract mixin class _$OpenMeteoReadingCopyWith<$Res> implements $OpenMeteoReadingCopyWith<$Res> {
  factory _$OpenMeteoReadingCopyWith(_OpenMeteoReading value, $Res Function(_OpenMeteoReading) _then) = __$OpenMeteoReadingCopyWithImpl;
@override @useResult
$Res call({
 double? pressure, double? surfacePressure, double? temperature, double? humidity, int? weatherCode, double? uvIndex
});




}
/// @nodoc
class __$OpenMeteoReadingCopyWithImpl<$Res>
    implements _$OpenMeteoReadingCopyWith<$Res> {
  __$OpenMeteoReadingCopyWithImpl(this._self, this._then);

  final _OpenMeteoReading _self;
  final $Res Function(_OpenMeteoReading) _then;

/// Create a copy of OpenMeteoReading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pressure = freezed,Object? surfacePressure = freezed,Object? temperature = freezed,Object? humidity = freezed,Object? weatherCode = freezed,Object? uvIndex = freezed,}) {
  return _then(_OpenMeteoReading(
pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,surfacePressure: freezed == surfacePressure ? _self.surfacePressure : surfacePressure // ignore: cast_nullable_to_non_nullable
as double?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double?,weatherCode: freezed == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int?,uvIndex: freezed == uvIndex ? _self.uvIndex : uvIndex // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
