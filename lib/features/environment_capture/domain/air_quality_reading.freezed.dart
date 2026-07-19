// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'air_quality_reading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AirQualityReading {

 double? get pm25; double? get pm10; double? get alderPollen; double? get birchPollen; double? get grassPollen; double? get mugwortPollen; double? get olivePollen; double? get ragweedPollen;
/// Create a copy of AirQualityReading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirQualityReadingCopyWith<AirQualityReading> get copyWith => _$AirQualityReadingCopyWithImpl<AirQualityReading>(this as AirQualityReading, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirQualityReading&&(identical(other.pm25, pm25) || other.pm25 == pm25)&&(identical(other.pm10, pm10) || other.pm10 == pm10)&&(identical(other.alderPollen, alderPollen) || other.alderPollen == alderPollen)&&(identical(other.birchPollen, birchPollen) || other.birchPollen == birchPollen)&&(identical(other.grassPollen, grassPollen) || other.grassPollen == grassPollen)&&(identical(other.mugwortPollen, mugwortPollen) || other.mugwortPollen == mugwortPollen)&&(identical(other.olivePollen, olivePollen) || other.olivePollen == olivePollen)&&(identical(other.ragweedPollen, ragweedPollen) || other.ragweedPollen == ragweedPollen));
}


@override
int get hashCode => Object.hash(runtimeType,pm25,pm10,alderPollen,birchPollen,grassPollen,mugwortPollen,olivePollen,ragweedPollen);

@override
String toString() {
  return 'AirQualityReading(pm25: $pm25, pm10: $pm10, alderPollen: $alderPollen, birchPollen: $birchPollen, grassPollen: $grassPollen, mugwortPollen: $mugwortPollen, olivePollen: $olivePollen, ragweedPollen: $ragweedPollen)';
}


}

/// @nodoc
abstract mixin class $AirQualityReadingCopyWith<$Res>  {
  factory $AirQualityReadingCopyWith(AirQualityReading value, $Res Function(AirQualityReading) _then) = _$AirQualityReadingCopyWithImpl;
@useResult
$Res call({
 double? pm25, double? pm10, double? alderPollen, double? birchPollen, double? grassPollen, double? mugwortPollen, double? olivePollen, double? ragweedPollen
});




}
/// @nodoc
class _$AirQualityReadingCopyWithImpl<$Res>
    implements $AirQualityReadingCopyWith<$Res> {
  _$AirQualityReadingCopyWithImpl(this._self, this._then);

  final AirQualityReading _self;
  final $Res Function(AirQualityReading) _then;

/// Create a copy of AirQualityReading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pm25 = freezed,Object? pm10 = freezed,Object? alderPollen = freezed,Object? birchPollen = freezed,Object? grassPollen = freezed,Object? mugwortPollen = freezed,Object? olivePollen = freezed,Object? ragweedPollen = freezed,}) {
  return _then(_self.copyWith(
pm25: freezed == pm25 ? _self.pm25 : pm25 // ignore: cast_nullable_to_non_nullable
as double?,pm10: freezed == pm10 ? _self.pm10 : pm10 // ignore: cast_nullable_to_non_nullable
as double?,alderPollen: freezed == alderPollen ? _self.alderPollen : alderPollen // ignore: cast_nullable_to_non_nullable
as double?,birchPollen: freezed == birchPollen ? _self.birchPollen : birchPollen // ignore: cast_nullable_to_non_nullable
as double?,grassPollen: freezed == grassPollen ? _self.grassPollen : grassPollen // ignore: cast_nullable_to_non_nullable
as double?,mugwortPollen: freezed == mugwortPollen ? _self.mugwortPollen : mugwortPollen // ignore: cast_nullable_to_non_nullable
as double?,olivePollen: freezed == olivePollen ? _self.olivePollen : olivePollen // ignore: cast_nullable_to_non_nullable
as double?,ragweedPollen: freezed == ragweedPollen ? _self.ragweedPollen : ragweedPollen // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [AirQualityReading].
extension AirQualityReadingPatterns on AirQualityReading {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirQualityReading value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirQualityReading() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirQualityReading value)  $default,){
final _that = this;
switch (_that) {
case _AirQualityReading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirQualityReading value)?  $default,){
final _that = this;
switch (_that) {
case _AirQualityReading() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? pm25,  double? pm10,  double? alderPollen,  double? birchPollen,  double? grassPollen,  double? mugwortPollen,  double? olivePollen,  double? ragweedPollen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirQualityReading() when $default != null:
return $default(_that.pm25,_that.pm10,_that.alderPollen,_that.birchPollen,_that.grassPollen,_that.mugwortPollen,_that.olivePollen,_that.ragweedPollen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? pm25,  double? pm10,  double? alderPollen,  double? birchPollen,  double? grassPollen,  double? mugwortPollen,  double? olivePollen,  double? ragweedPollen)  $default,) {final _that = this;
switch (_that) {
case _AirQualityReading():
return $default(_that.pm25,_that.pm10,_that.alderPollen,_that.birchPollen,_that.grassPollen,_that.mugwortPollen,_that.olivePollen,_that.ragweedPollen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? pm25,  double? pm10,  double? alderPollen,  double? birchPollen,  double? grassPollen,  double? mugwortPollen,  double? olivePollen,  double? ragweedPollen)?  $default,) {final _that = this;
switch (_that) {
case _AirQualityReading() when $default != null:
return $default(_that.pm25,_that.pm10,_that.alderPollen,_that.birchPollen,_that.grassPollen,_that.mugwortPollen,_that.olivePollen,_that.ragweedPollen);case _:
  return null;

}
}

}

/// @nodoc


class _AirQualityReading implements AirQualityReading {
  const _AirQualityReading({this.pm25, this.pm10, this.alderPollen, this.birchPollen, this.grassPollen, this.mugwortPollen, this.olivePollen, this.ragweedPollen});
  

@override final  double? pm25;
@override final  double? pm10;
@override final  double? alderPollen;
@override final  double? birchPollen;
@override final  double? grassPollen;
@override final  double? mugwortPollen;
@override final  double? olivePollen;
@override final  double? ragweedPollen;

/// Create a copy of AirQualityReading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirQualityReadingCopyWith<_AirQualityReading> get copyWith => __$AirQualityReadingCopyWithImpl<_AirQualityReading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirQualityReading&&(identical(other.pm25, pm25) || other.pm25 == pm25)&&(identical(other.pm10, pm10) || other.pm10 == pm10)&&(identical(other.alderPollen, alderPollen) || other.alderPollen == alderPollen)&&(identical(other.birchPollen, birchPollen) || other.birchPollen == birchPollen)&&(identical(other.grassPollen, grassPollen) || other.grassPollen == grassPollen)&&(identical(other.mugwortPollen, mugwortPollen) || other.mugwortPollen == mugwortPollen)&&(identical(other.olivePollen, olivePollen) || other.olivePollen == olivePollen)&&(identical(other.ragweedPollen, ragweedPollen) || other.ragweedPollen == ragweedPollen));
}


@override
int get hashCode => Object.hash(runtimeType,pm25,pm10,alderPollen,birchPollen,grassPollen,mugwortPollen,olivePollen,ragweedPollen);

@override
String toString() {
  return 'AirQualityReading(pm25: $pm25, pm10: $pm10, alderPollen: $alderPollen, birchPollen: $birchPollen, grassPollen: $grassPollen, mugwortPollen: $mugwortPollen, olivePollen: $olivePollen, ragweedPollen: $ragweedPollen)';
}


}

/// @nodoc
abstract mixin class _$AirQualityReadingCopyWith<$Res> implements $AirQualityReadingCopyWith<$Res> {
  factory _$AirQualityReadingCopyWith(_AirQualityReading value, $Res Function(_AirQualityReading) _then) = __$AirQualityReadingCopyWithImpl;
@override @useResult
$Res call({
 double? pm25, double? pm10, double? alderPollen, double? birchPollen, double? grassPollen, double? mugwortPollen, double? olivePollen, double? ragweedPollen
});




}
/// @nodoc
class __$AirQualityReadingCopyWithImpl<$Res>
    implements _$AirQualityReadingCopyWith<$Res> {
  __$AirQualityReadingCopyWithImpl(this._self, this._then);

  final _AirQualityReading _self;
  final $Res Function(_AirQualityReading) _then;

/// Create a copy of AirQualityReading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pm25 = freezed,Object? pm10 = freezed,Object? alderPollen = freezed,Object? birchPollen = freezed,Object? grassPollen = freezed,Object? mugwortPollen = freezed,Object? olivePollen = freezed,Object? ragweedPollen = freezed,}) {
  return _then(_AirQualityReading(
pm25: freezed == pm25 ? _self.pm25 : pm25 // ignore: cast_nullable_to_non_nullable
as double?,pm10: freezed == pm10 ? _self.pm10 : pm10 // ignore: cast_nullable_to_non_nullable
as double?,alderPollen: freezed == alderPollen ? _self.alderPollen : alderPollen // ignore: cast_nullable_to_non_nullable
as double?,birchPollen: freezed == birchPollen ? _self.birchPollen : birchPollen // ignore: cast_nullable_to_non_nullable
as double?,grassPollen: freezed == grassPollen ? _self.grassPollen : grassPollen // ignore: cast_nullable_to_non_nullable
as double?,mugwortPollen: freezed == mugwortPollen ? _self.mugwortPollen : mugwortPollen // ignore: cast_nullable_to_non_nullable
as double?,olivePollen: freezed == olivePollen ? _self.olivePollen : olivePollen // ignore: cast_nullable_to_non_nullable
as double?,ragweedPollen: freezed == ragweedPollen ? _self.ragweedPollen : ragweedPollen // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
