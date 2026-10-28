// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menstrual_observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MenstrualObservation {

 String get localDate; BleedingStatus get status; MenstrualFlow? get flow; bool get isPeriodStart; String? get note;
/// Create a copy of MenstrualObservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenstrualObservationCopyWith<MenstrualObservation> get copyWith => _$MenstrualObservationCopyWithImpl<MenstrualObservation>(this as MenstrualObservation, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MenstrualObservation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenstrualObservation&&(identical(other.localDate, _this.localDate) || other.localDate == _this.localDate)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.flow, _this.flow) || other.flow == _this.flow)&&(identical(other.isPeriodStart, _this.isPeriodStart) || other.isPeriodStart == _this.isPeriodStart)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as MenstrualObservation;
  return Object.hash(runtimeType,_this.localDate,_this.status,_this.flow,_this.isPeriodStart,_this.note);
}

@override
String toString() {
  final _this = this as MenstrualObservation;
  return 'MenstrualObservation(localDate: ${_this.localDate}, status: ${_this.status}, flow: ${_this.flow}, isPeriodStart: ${_this.isPeriodStart}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $MenstrualObservationCopyWith<$Res>  {
  factory $MenstrualObservationCopyWith(MenstrualObservation value, $Res Function(MenstrualObservation) _then) = _$MenstrualObservationCopyWithImpl;
@useResult
$Res call({
 String localDate, BleedingStatus status, MenstrualFlow? flow, bool isPeriodStart, String? note
});




}
/// @nodoc
class _$MenstrualObservationCopyWithImpl<$Res>
    implements $MenstrualObservationCopyWith<$Res> {
  _$MenstrualObservationCopyWithImpl(this._self, this._then);

  final MenstrualObservation _self;
  final $Res Function(MenstrualObservation) _then;

/// Create a copy of MenstrualObservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localDate = null,Object? status = null,Object? flow = freezed,Object? isPeriodStart = null,Object? note = freezed,}) {
  return _then(MenstrualObservation(
localDate: null == localDate ? _self.localDate : localDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BleedingStatus,flow: freezed == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as MenstrualFlow?,isPeriodStart: null == isPeriodStart ? _self.isPeriodStart : isPeriodStart // ignore: cast_nullable_to_non_nullable
as bool,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MenstrualObservation].
extension MenstrualObservationPatterns on MenstrualObservation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenstrualObservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenstrualObservation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenstrualObservation value)  $default,){
final _that = this;
switch (_that) {
case _MenstrualObservation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenstrualObservation value)?  $default,){
final _that = this;
switch (_that) {
case _MenstrualObservation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String localDate,  BleedingStatus status,  MenstrualFlow? flow,  bool isPeriodStart,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenstrualObservation() when $default != null:
return $default(_that.localDate,_that.status,_that.flow,_that.isPeriodStart,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String localDate,  BleedingStatus status,  MenstrualFlow? flow,  bool isPeriodStart,  String? note)  $default,) {final _that = this;
switch (_that) {
case _MenstrualObservation():
return $default(_that.localDate,_that.status,_that.flow,_that.isPeriodStart,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String localDate,  BleedingStatus status,  MenstrualFlow? flow,  bool isPeriodStart,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _MenstrualObservation() when $default != null:
return $default(_that.localDate,_that.status,_that.flow,_that.isPeriodStart,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _MenstrualObservation implements MenstrualObservation {
  const _MenstrualObservation({required this.localDate, required this.status, this.flow, this.isPeriodStart = false, this.note});
  

@override final  String localDate;
@override final  BleedingStatus status;
@override final  MenstrualFlow? flow;
@override@JsonKey() final  bool isPeriodStart;
@override final  String? note;

/// Create a copy of MenstrualObservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenstrualObservationCopyWith<_MenstrualObservation> get copyWith => __$MenstrualObservationCopyWithImpl<_MenstrualObservation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenstrualObservation&&(identical(other.localDate, localDate) || other.localDate == localDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.flow, flow) || other.flow == flow)&&(identical(other.isPeriodStart, isPeriodStart) || other.isPeriodStart == isPeriodStart)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,localDate,status,flow,isPeriodStart,note);
}

@override
String toString() {
    return 'MenstrualObservation(localDate: $localDate, status: $status, flow: $flow, isPeriodStart: $isPeriodStart, note: $note)';
}


}

/// @nodoc
abstract mixin class _$MenstrualObservationCopyWith<$Res> implements $MenstrualObservationCopyWith<$Res> {
  factory _$MenstrualObservationCopyWith(_MenstrualObservation value, $Res Function(_MenstrualObservation) _then) = __$MenstrualObservationCopyWithImpl;
@override @useResult
$Res call({
 String localDate, BleedingStatus status, MenstrualFlow? flow, bool isPeriodStart, String? note
});




}
/// @nodoc
class __$MenstrualObservationCopyWithImpl<$Res>
    implements _$MenstrualObservationCopyWith<$Res> {
  __$MenstrualObservationCopyWithImpl(this._self, this._then);

  final _MenstrualObservation _self;
  final $Res Function(_MenstrualObservation) _then;

/// Create a copy of MenstrualObservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localDate = null,Object? status = null,Object? flow = freezed,Object? isPeriodStart = null,Object? note = freezed,}) {
  return _then(_MenstrualObservation(
localDate: null == localDate ? _self.localDate : localDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BleedingStatus,flow: freezed == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as MenstrualFlow?,isPeriodStart: null == isPeriodStart ? _self.isPeriodStart : isPeriodStart // ignore: cast_nullable_to_non_nullable
as bool,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$MenstrualPreferences {

 bool get enabled; bool get includeInBackup; bool get includeInPdf;
/// Create a copy of MenstrualPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenstrualPreferencesCopyWith<MenstrualPreferences> get copyWith => _$MenstrualPreferencesCopyWithImpl<MenstrualPreferences>(this as MenstrualPreferences, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MenstrualPreferences;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenstrualPreferences&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.includeInBackup, _this.includeInBackup) || other.includeInBackup == _this.includeInBackup)&&(identical(other.includeInPdf, _this.includeInPdf) || other.includeInPdf == _this.includeInPdf));
}


@override
int get hashCode {
  final _this = this as MenstrualPreferences;
  return Object.hash(runtimeType,_this.enabled,_this.includeInBackup,_this.includeInPdf);
}

@override
String toString() {
  final _this = this as MenstrualPreferences;
  return 'MenstrualPreferences(enabled: ${_this.enabled}, includeInBackup: ${_this.includeInBackup}, includeInPdf: ${_this.includeInPdf})';
}


}

/// @nodoc
abstract mixin class $MenstrualPreferencesCopyWith<$Res>  {
  factory $MenstrualPreferencesCopyWith(MenstrualPreferences value, $Res Function(MenstrualPreferences) _then) = _$MenstrualPreferencesCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool includeInBackup, bool includeInPdf
});




}
/// @nodoc
class _$MenstrualPreferencesCopyWithImpl<$Res>
    implements $MenstrualPreferencesCopyWith<$Res> {
  _$MenstrualPreferencesCopyWithImpl(this._self, this._then);

  final MenstrualPreferences _self;
  final $Res Function(MenstrualPreferences) _then;

/// Create a copy of MenstrualPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? includeInBackup = null,Object? includeInPdf = null,}) {
  return _then(MenstrualPreferences(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,includeInBackup: null == includeInBackup ? _self.includeInBackup : includeInBackup // ignore: cast_nullable_to_non_nullable
as bool,includeInPdf: null == includeInPdf ? _self.includeInPdf : includeInPdf // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MenstrualPreferences].
extension MenstrualPreferencesPatterns on MenstrualPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenstrualPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenstrualPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenstrualPreferences value)  $default,){
final _that = this;
switch (_that) {
case _MenstrualPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenstrualPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _MenstrualPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  bool includeInBackup,  bool includeInPdf)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenstrualPreferences() when $default != null:
return $default(_that.enabled,_that.includeInBackup,_that.includeInPdf);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  bool includeInBackup,  bool includeInPdf)  $default,) {final _that = this;
switch (_that) {
case _MenstrualPreferences():
return $default(_that.enabled,_that.includeInBackup,_that.includeInPdf);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  bool includeInBackup,  bool includeInPdf)?  $default,) {final _that = this;
switch (_that) {
case _MenstrualPreferences() when $default != null:
return $default(_that.enabled,_that.includeInBackup,_that.includeInPdf);case _:
  return null;

}
}

}

/// @nodoc


class _MenstrualPreferences implements MenstrualPreferences {
  const _MenstrualPreferences({this.enabled = false, this.includeInBackup = false, this.includeInPdf = false});
  

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool includeInBackup;
@override@JsonKey() final  bool includeInPdf;

/// Create a copy of MenstrualPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenstrualPreferencesCopyWith<_MenstrualPreferences> get copyWith => __$MenstrualPreferencesCopyWithImpl<_MenstrualPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenstrualPreferences&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.includeInBackup, includeInBackup) || other.includeInBackup == includeInBackup)&&(identical(other.includeInPdf, includeInPdf) || other.includeInPdf == includeInPdf));
}


@override
int get hashCode {
    return Object.hash(runtimeType,enabled,includeInBackup,includeInPdf);
}

@override
String toString() {
    return 'MenstrualPreferences(enabled: $enabled, includeInBackup: $includeInBackup, includeInPdf: $includeInPdf)';
}


}

/// @nodoc
abstract mixin class _$MenstrualPreferencesCopyWith<$Res> implements $MenstrualPreferencesCopyWith<$Res> {
  factory _$MenstrualPreferencesCopyWith(_MenstrualPreferences value, $Res Function(_MenstrualPreferences) _then) = __$MenstrualPreferencesCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool includeInBackup, bool includeInPdf
});




}
/// @nodoc
class __$MenstrualPreferencesCopyWithImpl<$Res>
    implements _$MenstrualPreferencesCopyWith<$Res> {
  __$MenstrualPreferencesCopyWithImpl(this._self, this._then);

  final _MenstrualPreferences _self;
  final $Res Function(_MenstrualPreferences) _then;

/// Create a copy of MenstrualPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? includeInBackup = null,Object? includeInPdf = null,}) {
  return _then(_MenstrualPreferences(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,includeInBackup: null == includeInBackup ? _self.includeInBackup : includeInBackup // ignore: cast_nullable_to_non_nullable
as bool,includeInPdf: null == includeInPdf ? _self.includeInPdf : includeInPdf // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
