// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symptom_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SymptomDraft {

 String get id; DateTime get timestamp; SymptomType get type; int? get intensity; String? get detail; DateTime? get endTime; DateTime? get startedAt; MigraineStartPrecision? get startPrecision; DateTime? get endedAt; int? get initialIntensity; int? get maximumIntensity; String? get note; DateTime? get dailyDate; bool get isDailyNote;
/// Create a copy of SymptomDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymptomDraftCopyWith<SymptomDraft> get copyWith => _$SymptomDraftCopyWithImpl<SymptomDraft>(this as SymptomDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymptomDraft&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.startPrecision, startPrecision) || other.startPrecision == startPrecision)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.initialIntensity, initialIntensity) || other.initialIntensity == initialIntensity)&&(identical(other.maximumIntensity, maximumIntensity) || other.maximumIntensity == maximumIntensity)&&(identical(other.note, note) || other.note == note)&&(identical(other.dailyDate, dailyDate) || other.dailyDate == dailyDate)&&(identical(other.isDailyNote, isDailyNote) || other.isDailyNote == isDailyNote));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp,type,intensity,detail,endTime,startedAt,startPrecision,endedAt,initialIntensity,maximumIntensity,note,dailyDate,isDailyNote);

@override
String toString() {
  return 'SymptomDraft(id: $id, timestamp: $timestamp, type: $type, intensity: $intensity, detail: $detail, endTime: $endTime, startedAt: $startedAt, startPrecision: $startPrecision, endedAt: $endedAt, initialIntensity: $initialIntensity, maximumIntensity: $maximumIntensity, note: $note, dailyDate: $dailyDate, isDailyNote: $isDailyNote)';
}


}

/// @nodoc
abstract mixin class $SymptomDraftCopyWith<$Res>  {
  factory $SymptomDraftCopyWith(SymptomDraft value, $Res Function(SymptomDraft) _then) = _$SymptomDraftCopyWithImpl;
@useResult
$Res call({
 String id, DateTime timestamp, SymptomType type, int? intensity, String? detail, DateTime? endTime, DateTime? startedAt, MigraineStartPrecision? startPrecision, DateTime? endedAt, int? initialIntensity, int? maximumIntensity, String? note, DateTime? dailyDate, bool isDailyNote
});




}
/// @nodoc
class _$SymptomDraftCopyWithImpl<$Res>
    implements $SymptomDraftCopyWith<$Res> {
  _$SymptomDraftCopyWithImpl(this._self, this._then);

  final SymptomDraft _self;
  final $Res Function(SymptomDraft) _then;

/// Create a copy of SymptomDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? timestamp = null,Object? type = null,Object? intensity = freezed,Object? detail = freezed,Object? endTime = freezed,Object? startedAt = freezed,Object? startPrecision = freezed,Object? endedAt = freezed,Object? initialIntensity = freezed,Object? maximumIntensity = freezed,Object? note = freezed,Object? dailyDate = freezed,Object? isDailyNote = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SymptomType,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startPrecision: freezed == startPrecision ? _self.startPrecision : startPrecision // ignore: cast_nullable_to_non_nullable
as MigraineStartPrecision?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,initialIntensity: freezed == initialIntensity ? _self.initialIntensity : initialIntensity // ignore: cast_nullable_to_non_nullable
as int?,maximumIntensity: freezed == maximumIntensity ? _self.maximumIntensity : maximumIntensity // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,dailyDate: freezed == dailyDate ? _self.dailyDate : dailyDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isDailyNote: null == isDailyNote ? _self.isDailyNote : isDailyNote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SymptomDraft].
extension SymptomDraftPatterns on SymptomDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SymptomDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SymptomDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SymptomDraft value)  $default,){
final _that = this;
switch (_that) {
case _SymptomDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SymptomDraft value)?  $default,){
final _that = this;
switch (_that) {
case _SymptomDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime timestamp,  SymptomType type,  int? intensity,  String? detail,  DateTime? endTime,  DateTime? startedAt,  MigraineStartPrecision? startPrecision,  DateTime? endedAt,  int? initialIntensity,  int? maximumIntensity,  String? note,  DateTime? dailyDate,  bool isDailyNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SymptomDraft() when $default != null:
return $default(_that.id,_that.timestamp,_that.type,_that.intensity,_that.detail,_that.endTime,_that.startedAt,_that.startPrecision,_that.endedAt,_that.initialIntensity,_that.maximumIntensity,_that.note,_that.dailyDate,_that.isDailyNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime timestamp,  SymptomType type,  int? intensity,  String? detail,  DateTime? endTime,  DateTime? startedAt,  MigraineStartPrecision? startPrecision,  DateTime? endedAt,  int? initialIntensity,  int? maximumIntensity,  String? note,  DateTime? dailyDate,  bool isDailyNote)  $default,) {final _that = this;
switch (_that) {
case _SymptomDraft():
return $default(_that.id,_that.timestamp,_that.type,_that.intensity,_that.detail,_that.endTime,_that.startedAt,_that.startPrecision,_that.endedAt,_that.initialIntensity,_that.maximumIntensity,_that.note,_that.dailyDate,_that.isDailyNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime timestamp,  SymptomType type,  int? intensity,  String? detail,  DateTime? endTime,  DateTime? startedAt,  MigraineStartPrecision? startPrecision,  DateTime? endedAt,  int? initialIntensity,  int? maximumIntensity,  String? note,  DateTime? dailyDate,  bool isDailyNote)?  $default,) {final _that = this;
switch (_that) {
case _SymptomDraft() when $default != null:
return $default(_that.id,_that.timestamp,_that.type,_that.intensity,_that.detail,_that.endTime,_that.startedAt,_that.startPrecision,_that.endedAt,_that.initialIntensity,_that.maximumIntensity,_that.note,_that.dailyDate,_that.isDailyNote);case _:
  return null;

}
}

}

/// @nodoc


class _SymptomDraft implements SymptomDraft {
  const _SymptomDraft({required this.id, required this.timestamp, required this.type, this.intensity, this.detail, this.endTime, this.startedAt, this.startPrecision, this.endedAt, this.initialIntensity, this.maximumIntensity, this.note, this.dailyDate, this.isDailyNote = false});
  

@override final  String id;
@override final  DateTime timestamp;
@override final  SymptomType type;
@override final  int? intensity;
@override final  String? detail;
@override final  DateTime? endTime;
@override final  DateTime? startedAt;
@override final  MigraineStartPrecision? startPrecision;
@override final  DateTime? endedAt;
@override final  int? initialIntensity;
@override final  int? maximumIntensity;
@override final  String? note;
@override final  DateTime? dailyDate;
@override@JsonKey() final  bool isDailyNote;

/// Create a copy of SymptomDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SymptomDraftCopyWith<_SymptomDraft> get copyWith => __$SymptomDraftCopyWithImpl<_SymptomDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SymptomDraft&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.startPrecision, startPrecision) || other.startPrecision == startPrecision)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.initialIntensity, initialIntensity) || other.initialIntensity == initialIntensity)&&(identical(other.maximumIntensity, maximumIntensity) || other.maximumIntensity == maximumIntensity)&&(identical(other.note, note) || other.note == note)&&(identical(other.dailyDate, dailyDate) || other.dailyDate == dailyDate)&&(identical(other.isDailyNote, isDailyNote) || other.isDailyNote == isDailyNote));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp,type,intensity,detail,endTime,startedAt,startPrecision,endedAt,initialIntensity,maximumIntensity,note,dailyDate,isDailyNote);

@override
String toString() {
  return 'SymptomDraft(id: $id, timestamp: $timestamp, type: $type, intensity: $intensity, detail: $detail, endTime: $endTime, startedAt: $startedAt, startPrecision: $startPrecision, endedAt: $endedAt, initialIntensity: $initialIntensity, maximumIntensity: $maximumIntensity, note: $note, dailyDate: $dailyDate, isDailyNote: $isDailyNote)';
}


}

/// @nodoc
abstract mixin class _$SymptomDraftCopyWith<$Res> implements $SymptomDraftCopyWith<$Res> {
  factory _$SymptomDraftCopyWith(_SymptomDraft value, $Res Function(_SymptomDraft) _then) = __$SymptomDraftCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime timestamp, SymptomType type, int? intensity, String? detail, DateTime? endTime, DateTime? startedAt, MigraineStartPrecision? startPrecision, DateTime? endedAt, int? initialIntensity, int? maximumIntensity, String? note, DateTime? dailyDate, bool isDailyNote
});




}
/// @nodoc
class __$SymptomDraftCopyWithImpl<$Res>
    implements _$SymptomDraftCopyWith<$Res> {
  __$SymptomDraftCopyWithImpl(this._self, this._then);

  final _SymptomDraft _self;
  final $Res Function(_SymptomDraft) _then;

/// Create a copy of SymptomDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,Object? type = null,Object? intensity = freezed,Object? detail = freezed,Object? endTime = freezed,Object? startedAt = freezed,Object? startPrecision = freezed,Object? endedAt = freezed,Object? initialIntensity = freezed,Object? maximumIntensity = freezed,Object? note = freezed,Object? dailyDate = freezed,Object? isDailyNote = null,}) {
  return _then(_SymptomDraft(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SymptomType,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startPrecision: freezed == startPrecision ? _self.startPrecision : startPrecision // ignore: cast_nullable_to_non_nullable
as MigraineStartPrecision?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,initialIntensity: freezed == initialIntensity ? _self.initialIntensity : initialIntensity // ignore: cast_nullable_to_non_nullable
as int?,maximumIntensity: freezed == maximumIntensity ? _self.maximumIntensity : maximumIntensity // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,dailyDate: freezed == dailyDate ? _self.dailyDate : dailyDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isDailyNote: null == isDailyNote ? _self.isDailyNote : isDailyNote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
