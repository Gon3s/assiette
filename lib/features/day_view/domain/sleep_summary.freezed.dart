// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SleepSummary {

 int get quality; DateTime? get bedTime; DateTime? get wakeTime; String? get id;
/// Create a copy of SleepSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SleepSummaryCopyWith<SleepSummary> get copyWith => _$SleepSummaryCopyWithImpl<SleepSummary>(this as SleepSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SleepSummary&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.bedTime, bedTime) || other.bedTime == bedTime)&&(identical(other.wakeTime, wakeTime) || other.wakeTime == wakeTime)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,quality,bedTime,wakeTime,id);

@override
String toString() {
  return 'SleepSummary(quality: $quality, bedTime: $bedTime, wakeTime: $wakeTime, id: $id)';
}


}

/// @nodoc
abstract mixin class $SleepSummaryCopyWith<$Res>  {
  factory $SleepSummaryCopyWith(SleepSummary value, $Res Function(SleepSummary) _then) = _$SleepSummaryCopyWithImpl;
@useResult
$Res call({
 int quality, DateTime? bedTime, DateTime? wakeTime, String? id
});




}
/// @nodoc
class _$SleepSummaryCopyWithImpl<$Res>
    implements $SleepSummaryCopyWith<$Res> {
  _$SleepSummaryCopyWithImpl(this._self, this._then);

  final SleepSummary _self;
  final $Res Function(SleepSummary) _then;

/// Create a copy of SleepSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quality = null,Object? bedTime = freezed,Object? wakeTime = freezed,Object? id = freezed,}) {
  return _then(_self.copyWith(
quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,bedTime: freezed == bedTime ? _self.bedTime : bedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,wakeTime: freezed == wakeTime ? _self.wakeTime : wakeTime // ignore: cast_nullable_to_non_nullable
as DateTime?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SleepSummary].
extension SleepSummaryPatterns on SleepSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SleepSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SleepSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SleepSummary value)  $default,){
final _that = this;
switch (_that) {
case _SleepSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SleepSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SleepSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int quality,  DateTime? bedTime,  DateTime? wakeTime,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SleepSummary() when $default != null:
return $default(_that.quality,_that.bedTime,_that.wakeTime,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int quality,  DateTime? bedTime,  DateTime? wakeTime,  String? id)  $default,) {final _that = this;
switch (_that) {
case _SleepSummary():
return $default(_that.quality,_that.bedTime,_that.wakeTime,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int quality,  DateTime? bedTime,  DateTime? wakeTime,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _SleepSummary() when $default != null:
return $default(_that.quality,_that.bedTime,_that.wakeTime,_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _SleepSummary implements SleepSummary {
  const _SleepSummary({required this.quality, this.bedTime, this.wakeTime, this.id});
  

@override final  int quality;
@override final  DateTime? bedTime;
@override final  DateTime? wakeTime;
@override final  String? id;

/// Create a copy of SleepSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SleepSummaryCopyWith<_SleepSummary> get copyWith => __$SleepSummaryCopyWithImpl<_SleepSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SleepSummary&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.bedTime, bedTime) || other.bedTime == bedTime)&&(identical(other.wakeTime, wakeTime) || other.wakeTime == wakeTime)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,quality,bedTime,wakeTime,id);

@override
String toString() {
  return 'SleepSummary(quality: $quality, bedTime: $bedTime, wakeTime: $wakeTime, id: $id)';
}


}

/// @nodoc
abstract mixin class _$SleepSummaryCopyWith<$Res> implements $SleepSummaryCopyWith<$Res> {
  factory _$SleepSummaryCopyWith(_SleepSummary value, $Res Function(_SleepSummary) _then) = __$SleepSummaryCopyWithImpl;
@override @useResult
$Res call({
 int quality, DateTime? bedTime, DateTime? wakeTime, String? id
});




}
/// @nodoc
class __$SleepSummaryCopyWithImpl<$Res>
    implements _$SleepSummaryCopyWith<$Res> {
  __$SleepSummaryCopyWithImpl(this._self, this._then);

  final _SleepSummary _self;
  final $Res Function(_SleepSummary) _then;

/// Create a copy of SleepSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quality = null,Object? bedTime = freezed,Object? wakeTime = freezed,Object? id = freezed,}) {
  return _then(_SleepSummary(
quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,bedTime: freezed == bedTime ? _self.bedTime : bedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,wakeTime: freezed == wakeTime ? _self.wakeTime : wakeTime // ignore: cast_nullable_to_non_nullable
as DateTime?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
