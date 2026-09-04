// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symptom_entry_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SymptomEntryState {

 SymptomType get type; DateTime get timestamp; int get intensity; String? get detail; String get note; DateTime? get endTime; DateTime? get dailyDate; MigraineStartPrecision get startPrecision; bool get isDailyNote; int? get previousIntensity; List<MedicationIntakeDraft> get intakes; List<String> get removedIntakeIds; bool get isSaving; String? get id;
/// Create a copy of SymptomEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymptomEntryStateCopyWith<SymptomEntryState> get copyWith => _$SymptomEntryStateCopyWithImpl<SymptomEntryState>(this as SymptomEntryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymptomEntryState&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.note, note) || other.note == note)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.dailyDate, dailyDate) || other.dailyDate == dailyDate)&&(identical(other.startPrecision, startPrecision) || other.startPrecision == startPrecision)&&(identical(other.isDailyNote, isDailyNote) || other.isDailyNote == isDailyNote)&&(identical(other.previousIntensity, previousIntensity) || other.previousIntensity == previousIntensity)&&const DeepCollectionEquality().equals(other.intakes, intakes)&&const DeepCollectionEquality().equals(other.removedIntakeIds, removedIntakeIds)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,type,timestamp,intensity,detail,note,endTime,dailyDate,startPrecision,isDailyNote,previousIntensity,const DeepCollectionEquality().hash(intakes),const DeepCollectionEquality().hash(removedIntakeIds),isSaving,id);

@override
String toString() {
  return 'SymptomEntryState(type: $type, timestamp: $timestamp, intensity: $intensity, detail: $detail, note: $note, endTime: $endTime, dailyDate: $dailyDate, startPrecision: $startPrecision, isDailyNote: $isDailyNote, previousIntensity: $previousIntensity, intakes: $intakes, removedIntakeIds: $removedIntakeIds, isSaving: $isSaving, id: $id)';
}


}

/// @nodoc
abstract mixin class $SymptomEntryStateCopyWith<$Res>  {
  factory $SymptomEntryStateCopyWith(SymptomEntryState value, $Res Function(SymptomEntryState) _then) = _$SymptomEntryStateCopyWithImpl;
@useResult
$Res call({
 SymptomType type, DateTime timestamp, int intensity, String? detail, String note, DateTime? endTime, DateTime? dailyDate, MigraineStartPrecision startPrecision, bool isDailyNote, int? previousIntensity, List<MedicationIntakeDraft> intakes, List<String> removedIntakeIds, bool isSaving, String? id
});




}
/// @nodoc
class _$SymptomEntryStateCopyWithImpl<$Res>
    implements $SymptomEntryStateCopyWith<$Res> {
  _$SymptomEntryStateCopyWithImpl(this._self, this._then);

  final SymptomEntryState _self;
  final $Res Function(SymptomEntryState) _then;

/// Create a copy of SymptomEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? timestamp = null,Object? intensity = null,Object? detail = freezed,Object? note = null,Object? endTime = freezed,Object? dailyDate = freezed,Object? startPrecision = null,Object? isDailyNote = null,Object? previousIntensity = freezed,Object? intakes = null,Object? removedIntakeIds = null,Object? isSaving = null,Object? id = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SymptomType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,dailyDate: freezed == dailyDate ? _self.dailyDate : dailyDate // ignore: cast_nullable_to_non_nullable
as DateTime?,startPrecision: null == startPrecision ? _self.startPrecision : startPrecision // ignore: cast_nullable_to_non_nullable
as MigraineStartPrecision,isDailyNote: null == isDailyNote ? _self.isDailyNote : isDailyNote // ignore: cast_nullable_to_non_nullable
as bool,previousIntensity: freezed == previousIntensity ? _self.previousIntensity : previousIntensity // ignore: cast_nullable_to_non_nullable
as int?,intakes: null == intakes ? _self.intakes : intakes // ignore: cast_nullable_to_non_nullable
as List<MedicationIntakeDraft>,removedIntakeIds: null == removedIntakeIds ? _self.removedIntakeIds : removedIntakeIds // ignore: cast_nullable_to_non_nullable
as List<String>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SymptomEntryState].
extension SymptomEntryStatePatterns on SymptomEntryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SymptomEntryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SymptomEntryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SymptomEntryState value)  $default,){
final _that = this;
switch (_that) {
case _SymptomEntryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SymptomEntryState value)?  $default,){
final _that = this;
switch (_that) {
case _SymptomEntryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SymptomType type,  DateTime timestamp,  int intensity,  String? detail,  String note,  DateTime? endTime,  DateTime? dailyDate,  MigraineStartPrecision startPrecision,  bool isDailyNote,  int? previousIntensity,  List<MedicationIntakeDraft> intakes,  List<String> removedIntakeIds,  bool isSaving,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SymptomEntryState() when $default != null:
return $default(_that.type,_that.timestamp,_that.intensity,_that.detail,_that.note,_that.endTime,_that.dailyDate,_that.startPrecision,_that.isDailyNote,_that.previousIntensity,_that.intakes,_that.removedIntakeIds,_that.isSaving,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SymptomType type,  DateTime timestamp,  int intensity,  String? detail,  String note,  DateTime? endTime,  DateTime? dailyDate,  MigraineStartPrecision startPrecision,  bool isDailyNote,  int? previousIntensity,  List<MedicationIntakeDraft> intakes,  List<String> removedIntakeIds,  bool isSaving,  String? id)  $default,) {final _that = this;
switch (_that) {
case _SymptomEntryState():
return $default(_that.type,_that.timestamp,_that.intensity,_that.detail,_that.note,_that.endTime,_that.dailyDate,_that.startPrecision,_that.isDailyNote,_that.previousIntensity,_that.intakes,_that.removedIntakeIds,_that.isSaving,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SymptomType type,  DateTime timestamp,  int intensity,  String? detail,  String note,  DateTime? endTime,  DateTime? dailyDate,  MigraineStartPrecision startPrecision,  bool isDailyNote,  int? previousIntensity,  List<MedicationIntakeDraft> intakes,  List<String> removedIntakeIds,  bool isSaving,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _SymptomEntryState() when $default != null:
return $default(_that.type,_that.timestamp,_that.intensity,_that.detail,_that.note,_that.endTime,_that.dailyDate,_that.startPrecision,_that.isDailyNote,_that.previousIntensity,_that.intakes,_that.removedIntakeIds,_that.isSaving,_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _SymptomEntryState implements SymptomEntryState {
  const _SymptomEntryState({required this.type, required this.timestamp, this.intensity = 5, this.detail, this.note = '', this.endTime, this.dailyDate, this.startPrecision = MigraineStartPrecision.exact, this.isDailyNote = false, this.previousIntensity, final  List<MedicationIntakeDraft> intakes = const <MedicationIntakeDraft>[], final  List<String> removedIntakeIds = const <String>[], this.isSaving = false, this.id}): _intakes = intakes,_removedIntakeIds = removedIntakeIds;
  

@override final  SymptomType type;
@override final  DateTime timestamp;
@override@JsonKey() final  int intensity;
@override final  String? detail;
@override@JsonKey() final  String note;
@override final  DateTime? endTime;
@override final  DateTime? dailyDate;
@override@JsonKey() final  MigraineStartPrecision startPrecision;
@override@JsonKey() final  bool isDailyNote;
@override final  int? previousIntensity;
 final  List<MedicationIntakeDraft> _intakes;
@override@JsonKey() List<MedicationIntakeDraft> get intakes {
  if (_intakes is EqualUnmodifiableListView) return _intakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_intakes);
}

 final  List<String> _removedIntakeIds;
@override@JsonKey() List<String> get removedIntakeIds {
  if (_removedIntakeIds is EqualUnmodifiableListView) return _removedIntakeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_removedIntakeIds);
}

@override@JsonKey() final  bool isSaving;
@override final  String? id;

/// Create a copy of SymptomEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SymptomEntryStateCopyWith<_SymptomEntryState> get copyWith => __$SymptomEntryStateCopyWithImpl<_SymptomEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SymptomEntryState&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.note, note) || other.note == note)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.dailyDate, dailyDate) || other.dailyDate == dailyDate)&&(identical(other.startPrecision, startPrecision) || other.startPrecision == startPrecision)&&(identical(other.isDailyNote, isDailyNote) || other.isDailyNote == isDailyNote)&&(identical(other.previousIntensity, previousIntensity) || other.previousIntensity == previousIntensity)&&const DeepCollectionEquality().equals(other._intakes, _intakes)&&const DeepCollectionEquality().equals(other._removedIntakeIds, _removedIntakeIds)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,type,timestamp,intensity,detail,note,endTime,dailyDate,startPrecision,isDailyNote,previousIntensity,const DeepCollectionEquality().hash(_intakes),const DeepCollectionEquality().hash(_removedIntakeIds),isSaving,id);

@override
String toString() {
  return 'SymptomEntryState(type: $type, timestamp: $timestamp, intensity: $intensity, detail: $detail, note: $note, endTime: $endTime, dailyDate: $dailyDate, startPrecision: $startPrecision, isDailyNote: $isDailyNote, previousIntensity: $previousIntensity, intakes: $intakes, removedIntakeIds: $removedIntakeIds, isSaving: $isSaving, id: $id)';
}


}

/// @nodoc
abstract mixin class _$SymptomEntryStateCopyWith<$Res> implements $SymptomEntryStateCopyWith<$Res> {
  factory _$SymptomEntryStateCopyWith(_SymptomEntryState value, $Res Function(_SymptomEntryState) _then) = __$SymptomEntryStateCopyWithImpl;
@override @useResult
$Res call({
 SymptomType type, DateTime timestamp, int intensity, String? detail, String note, DateTime? endTime, DateTime? dailyDate, MigraineStartPrecision startPrecision, bool isDailyNote, int? previousIntensity, List<MedicationIntakeDraft> intakes, List<String> removedIntakeIds, bool isSaving, String? id
});




}
/// @nodoc
class __$SymptomEntryStateCopyWithImpl<$Res>
    implements _$SymptomEntryStateCopyWith<$Res> {
  __$SymptomEntryStateCopyWithImpl(this._self, this._then);

  final _SymptomEntryState _self;
  final $Res Function(_SymptomEntryState) _then;

/// Create a copy of SymptomEntryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? timestamp = null,Object? intensity = null,Object? detail = freezed,Object? note = null,Object? endTime = freezed,Object? dailyDate = freezed,Object? startPrecision = null,Object? isDailyNote = null,Object? previousIntensity = freezed,Object? intakes = null,Object? removedIntakeIds = null,Object? isSaving = null,Object? id = freezed,}) {
  return _then(_SymptomEntryState(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SymptomType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,dailyDate: freezed == dailyDate ? _self.dailyDate : dailyDate // ignore: cast_nullable_to_non_nullable
as DateTime?,startPrecision: null == startPrecision ? _self.startPrecision : startPrecision // ignore: cast_nullable_to_non_nullable
as MigraineStartPrecision,isDailyNote: null == isDailyNote ? _self.isDailyNote : isDailyNote // ignore: cast_nullable_to_non_nullable
as bool,previousIntensity: freezed == previousIntensity ? _self.previousIntensity : previousIntensity // ignore: cast_nullable_to_non_nullable
as int?,intakes: null == intakes ? _self._intakes : intakes // ignore: cast_nullable_to_non_nullable
as List<MedicationIntakeDraft>,removedIntakeIds: null == removedIntakeIds ? _self._removedIntakeIds : removedIntakeIds // ignore: cast_nullable_to_non_nullable
as List<String>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
