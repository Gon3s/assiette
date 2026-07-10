// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_entry_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SleepEntryState {

 int get quality; DateTime? get bedTime; DateTime? get wakeTime; bool get isSaving;
/// Create a copy of SleepEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SleepEntryStateCopyWith<SleepEntryState> get copyWith => _$SleepEntryStateCopyWithImpl<SleepEntryState>(this as SleepEntryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SleepEntryState&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.bedTime, bedTime) || other.bedTime == bedTime)&&(identical(other.wakeTime, wakeTime) || other.wakeTime == wakeTime)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving));
}


@override
int get hashCode => Object.hash(runtimeType,quality,bedTime,wakeTime,isSaving);

@override
String toString() {
  return 'SleepEntryState(quality: $quality, bedTime: $bedTime, wakeTime: $wakeTime, isSaving: $isSaving)';
}


}

/// @nodoc
abstract mixin class $SleepEntryStateCopyWith<$Res>  {
  factory $SleepEntryStateCopyWith(SleepEntryState value, $Res Function(SleepEntryState) _then) = _$SleepEntryStateCopyWithImpl;
@useResult
$Res call({
 int quality, DateTime? bedTime, DateTime? wakeTime, bool isSaving
});




}
/// @nodoc
class _$SleepEntryStateCopyWithImpl<$Res>
    implements $SleepEntryStateCopyWith<$Res> {
  _$SleepEntryStateCopyWithImpl(this._self, this._then);

  final SleepEntryState _self;
  final $Res Function(SleepEntryState) _then;

/// Create a copy of SleepEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quality = null,Object? bedTime = freezed,Object? wakeTime = freezed,Object? isSaving = null,}) {
  return _then(_self.copyWith(
quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,bedTime: freezed == bedTime ? _self.bedTime : bedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,wakeTime: freezed == wakeTime ? _self.wakeTime : wakeTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SleepEntryState].
extension SleepEntryStatePatterns on SleepEntryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SleepEntryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SleepEntryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SleepEntryState value)  $default,){
final _that = this;
switch (_that) {
case _SleepEntryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SleepEntryState value)?  $default,){
final _that = this;
switch (_that) {
case _SleepEntryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int quality,  DateTime? bedTime,  DateTime? wakeTime,  bool isSaving)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SleepEntryState() when $default != null:
return $default(_that.quality,_that.bedTime,_that.wakeTime,_that.isSaving);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int quality,  DateTime? bedTime,  DateTime? wakeTime,  bool isSaving)  $default,) {final _that = this;
switch (_that) {
case _SleepEntryState():
return $default(_that.quality,_that.bedTime,_that.wakeTime,_that.isSaving);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int quality,  DateTime? bedTime,  DateTime? wakeTime,  bool isSaving)?  $default,) {final _that = this;
switch (_that) {
case _SleepEntryState() when $default != null:
return $default(_that.quality,_that.bedTime,_that.wakeTime,_that.isSaving);case _:
  return null;

}
}

}

/// @nodoc


class _SleepEntryState implements SleepEntryState {
  const _SleepEntryState({required this.quality, this.bedTime, this.wakeTime, this.isSaving = false});
  

@override final  int quality;
@override final  DateTime? bedTime;
@override final  DateTime? wakeTime;
@override@JsonKey() final  bool isSaving;

/// Create a copy of SleepEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SleepEntryStateCopyWith<_SleepEntryState> get copyWith => __$SleepEntryStateCopyWithImpl<_SleepEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SleepEntryState&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.bedTime, bedTime) || other.bedTime == bedTime)&&(identical(other.wakeTime, wakeTime) || other.wakeTime == wakeTime)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving));
}


@override
int get hashCode => Object.hash(runtimeType,quality,bedTime,wakeTime,isSaving);

@override
String toString() {
  return 'SleepEntryState(quality: $quality, bedTime: $bedTime, wakeTime: $wakeTime, isSaving: $isSaving)';
}


}

/// @nodoc
abstract mixin class _$SleepEntryStateCopyWith<$Res> implements $SleepEntryStateCopyWith<$Res> {
  factory _$SleepEntryStateCopyWith(_SleepEntryState value, $Res Function(_SleepEntryState) _then) = __$SleepEntryStateCopyWithImpl;
@override @useResult
$Res call({
 int quality, DateTime? bedTime, DateTime? wakeTime, bool isSaving
});




}
/// @nodoc
class __$SleepEntryStateCopyWithImpl<$Res>
    implements _$SleepEntryStateCopyWith<$Res> {
  __$SleepEntryStateCopyWithImpl(this._self, this._then);

  final _SleepEntryState _self;
  final $Res Function(_SleepEntryState) _then;

/// Create a copy of SleepEntryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quality = null,Object? bedTime = freezed,Object? wakeTime = freezed,Object? isSaving = null,}) {
  return _then(_SleepEntryState(
quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,bedTime: freezed == bedTime ? _self.bedTime : bedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,wakeTime: freezed == wakeTime ? _self.wakeTime : wakeTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
