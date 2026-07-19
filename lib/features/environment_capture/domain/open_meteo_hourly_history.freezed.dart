// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_meteo_hourly_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OpenMeteoHourlyHistory {

 List<DateTime> get times; List<double?> get pressure; List<double?> get temperature; List<double?> get humidity; List<int?> get weatherCode; List<double?> get uvIndex;
/// Create a copy of OpenMeteoHourlyHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenMeteoHourlyHistoryCopyWith<OpenMeteoHourlyHistory> get copyWith => _$OpenMeteoHourlyHistoryCopyWithImpl<OpenMeteoHourlyHistory>(this as OpenMeteoHourlyHistory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenMeteoHourlyHistory&&const DeepCollectionEquality().equals(other.times, times)&&const DeepCollectionEquality().equals(other.pressure, pressure)&&const DeepCollectionEquality().equals(other.temperature, temperature)&&const DeepCollectionEquality().equals(other.humidity, humidity)&&const DeepCollectionEquality().equals(other.weatherCode, weatherCode)&&const DeepCollectionEquality().equals(other.uvIndex, uvIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(times),const DeepCollectionEquality().hash(pressure),const DeepCollectionEquality().hash(temperature),const DeepCollectionEquality().hash(humidity),const DeepCollectionEquality().hash(weatherCode),const DeepCollectionEquality().hash(uvIndex));

@override
String toString() {
  return 'OpenMeteoHourlyHistory(times: $times, pressure: $pressure, temperature: $temperature, humidity: $humidity, weatherCode: $weatherCode, uvIndex: $uvIndex)';
}


}

/// @nodoc
abstract mixin class $OpenMeteoHourlyHistoryCopyWith<$Res>  {
  factory $OpenMeteoHourlyHistoryCopyWith(OpenMeteoHourlyHistory value, $Res Function(OpenMeteoHourlyHistory) _then) = _$OpenMeteoHourlyHistoryCopyWithImpl;
@useResult
$Res call({
 List<DateTime> times, List<double?> pressure, List<double?> temperature, List<double?> humidity, List<int?> weatherCode, List<double?> uvIndex
});




}
/// @nodoc
class _$OpenMeteoHourlyHistoryCopyWithImpl<$Res>
    implements $OpenMeteoHourlyHistoryCopyWith<$Res> {
  _$OpenMeteoHourlyHistoryCopyWithImpl(this._self, this._then);

  final OpenMeteoHourlyHistory _self;
  final $Res Function(OpenMeteoHourlyHistory) _then;

/// Create a copy of OpenMeteoHourlyHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? times = null,Object? pressure = null,Object? temperature = null,Object? humidity = null,Object? weatherCode = null,Object? uvIndex = null,}) {
  return _then(_self.copyWith(
times: null == times ? _self.times : times // ignore: cast_nullable_to_non_nullable
as List<DateTime>,pressure: null == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as List<double?>,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as List<double?>,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as List<double?>,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as List<int?>,uvIndex: null == uvIndex ? _self.uvIndex : uvIndex // ignore: cast_nullable_to_non_nullable
as List<double?>,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenMeteoHourlyHistory].
extension OpenMeteoHourlyHistoryPatterns on OpenMeteoHourlyHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenMeteoHourlyHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenMeteoHourlyHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenMeteoHourlyHistory value)  $default,){
final _that = this;
switch (_that) {
case _OpenMeteoHourlyHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenMeteoHourlyHistory value)?  $default,){
final _that = this;
switch (_that) {
case _OpenMeteoHourlyHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DateTime> times,  List<double?> pressure,  List<double?> temperature,  List<double?> humidity,  List<int?> weatherCode,  List<double?> uvIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenMeteoHourlyHistory() when $default != null:
return $default(_that.times,_that.pressure,_that.temperature,_that.humidity,_that.weatherCode,_that.uvIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DateTime> times,  List<double?> pressure,  List<double?> temperature,  List<double?> humidity,  List<int?> weatherCode,  List<double?> uvIndex)  $default,) {final _that = this;
switch (_that) {
case _OpenMeteoHourlyHistory():
return $default(_that.times,_that.pressure,_that.temperature,_that.humidity,_that.weatherCode,_that.uvIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DateTime> times,  List<double?> pressure,  List<double?> temperature,  List<double?> humidity,  List<int?> weatherCode,  List<double?> uvIndex)?  $default,) {final _that = this;
switch (_that) {
case _OpenMeteoHourlyHistory() when $default != null:
return $default(_that.times,_that.pressure,_that.temperature,_that.humidity,_that.weatherCode,_that.uvIndex);case _:
  return null;

}
}

}

/// @nodoc


class _OpenMeteoHourlyHistory implements OpenMeteoHourlyHistory {
  const _OpenMeteoHourlyHistory({required final  List<DateTime> times, required final  List<double?> pressure, required final  List<double?> temperature, required final  List<double?> humidity, required final  List<int?> weatherCode, required final  List<double?> uvIndex}): _times = times,_pressure = pressure,_temperature = temperature,_humidity = humidity,_weatherCode = weatherCode,_uvIndex = uvIndex;
  

 final  List<DateTime> _times;
@override List<DateTime> get times {
  if (_times is EqualUnmodifiableListView) return _times;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_times);
}

 final  List<double?> _pressure;
@override List<double?> get pressure {
  if (_pressure is EqualUnmodifiableListView) return _pressure;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pressure);
}

 final  List<double?> _temperature;
@override List<double?> get temperature {
  if (_temperature is EqualUnmodifiableListView) return _temperature;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_temperature);
}

 final  List<double?> _humidity;
@override List<double?> get humidity {
  if (_humidity is EqualUnmodifiableListView) return _humidity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_humidity);
}

 final  List<int?> _weatherCode;
@override List<int?> get weatherCode {
  if (_weatherCode is EqualUnmodifiableListView) return _weatherCode;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weatherCode);
}

 final  List<double?> _uvIndex;
@override List<double?> get uvIndex {
  if (_uvIndex is EqualUnmodifiableListView) return _uvIndex;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uvIndex);
}


/// Create a copy of OpenMeteoHourlyHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenMeteoHourlyHistoryCopyWith<_OpenMeteoHourlyHistory> get copyWith => __$OpenMeteoHourlyHistoryCopyWithImpl<_OpenMeteoHourlyHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenMeteoHourlyHistory&&const DeepCollectionEquality().equals(other._times, _times)&&const DeepCollectionEquality().equals(other._pressure, _pressure)&&const DeepCollectionEquality().equals(other._temperature, _temperature)&&const DeepCollectionEquality().equals(other._humidity, _humidity)&&const DeepCollectionEquality().equals(other._weatherCode, _weatherCode)&&const DeepCollectionEquality().equals(other._uvIndex, _uvIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_times),const DeepCollectionEquality().hash(_pressure),const DeepCollectionEquality().hash(_temperature),const DeepCollectionEquality().hash(_humidity),const DeepCollectionEquality().hash(_weatherCode),const DeepCollectionEquality().hash(_uvIndex));

@override
String toString() {
  return 'OpenMeteoHourlyHistory(times: $times, pressure: $pressure, temperature: $temperature, humidity: $humidity, weatherCode: $weatherCode, uvIndex: $uvIndex)';
}


}

/// @nodoc
abstract mixin class _$OpenMeteoHourlyHistoryCopyWith<$Res> implements $OpenMeteoHourlyHistoryCopyWith<$Res> {
  factory _$OpenMeteoHourlyHistoryCopyWith(_OpenMeteoHourlyHistory value, $Res Function(_OpenMeteoHourlyHistory) _then) = __$OpenMeteoHourlyHistoryCopyWithImpl;
@override @useResult
$Res call({
 List<DateTime> times, List<double?> pressure, List<double?> temperature, List<double?> humidity, List<int?> weatherCode, List<double?> uvIndex
});




}
/// @nodoc
class __$OpenMeteoHourlyHistoryCopyWithImpl<$Res>
    implements _$OpenMeteoHourlyHistoryCopyWith<$Res> {
  __$OpenMeteoHourlyHistoryCopyWithImpl(this._self, this._then);

  final _OpenMeteoHourlyHistory _self;
  final $Res Function(_OpenMeteoHourlyHistory) _then;

/// Create a copy of OpenMeteoHourlyHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? times = null,Object? pressure = null,Object? temperature = null,Object? humidity = null,Object? weatherCode = null,Object? uvIndex = null,}) {
  return _then(_OpenMeteoHourlyHistory(
times: null == times ? _self._times : times // ignore: cast_nullable_to_non_nullable
as List<DateTime>,pressure: null == pressure ? _self._pressure : pressure // ignore: cast_nullable_to_non_nullable
as List<double?>,temperature: null == temperature ? _self._temperature : temperature // ignore: cast_nullable_to_non_nullable
as List<double?>,humidity: null == humidity ? _self._humidity : humidity // ignore: cast_nullable_to_non_nullable
as List<double?>,weatherCode: null == weatherCode ? _self._weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as List<int?>,uvIndex: null == uvIndex ? _self._uvIndex : uvIndex // ignore: cast_nullable_to_non_nullable
as List<double?>,
  ));
}


}

// dart format on
