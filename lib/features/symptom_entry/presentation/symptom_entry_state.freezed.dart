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

 SymptomType get type; DateTime get timestamp; int get intensity; String? get detail; String get note; DateTime? get endTime; bool get isSaving; String? get id; List<MedicationIntakeDraft> get intakes; List<String> get removedIntakeIds;
/// Create a copy of SymptomEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymptomEntryStateCopyWith<SymptomEntryState> get copyWith => _$SymptomEntryStateCopyWithImpl<SymptomEntryState>(this as SymptomEntryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymptomEntryState&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.note, note) || other.note == note)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.intakes, intakes)&&const DeepCollectionEquality().equals(other.removedIntakeIds, removedIntakeIds));
}


@override
int get hashCode => Object.hash(runtimeType,type,timestamp,intensity,detail,note,endTime,isSaving,id,const DeepCollectionEquality().hash(intakes),const DeepCollectionEquality().hash(removedIntakeIds));

@override
String toString() {
  return 'SymptomEntryState(type: $type, timestamp: $timestamp, intensity: $intensity, detail: $detail, note: $note, endTime: $endTime, isSaving: $isSaving, id: $id, intakes: $intakes, removedIntakeIds: $removedIntakeIds)';
}


}

/// @nodoc
abstract mixin class $SymptomEntryStateCopyWith<$Res>  {
  factory $SymptomEntryStateCopyWith(SymptomEntryState value, $Res Function(SymptomEntryState) _then) = _$SymptomEntryStateCopyWithImpl;
@useResult
$Res call({
 SymptomType type, DateTime timestamp, int intensity, String? detail, String note, DateTime? endTime, bool isSaving, String? id, List<MedicationIntakeDraft> intakes, List<String> removedIntakeIds
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
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? timestamp = null,Object? intensity = null,Object? detail = freezed,Object? note = null,Object? endTime = freezed,Object? isSaving = null,Object? id = freezed,Object? intakes = null,Object? removedIntakeIds = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SymptomType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,intakes: null == intakes ? _self.intakes : intakes // ignore: cast_nullable_to_non_nullable
as List<MedicationIntakeDraft>,removedIntakeIds: null == removedIntakeIds ? _self.removedIntakeIds : removedIntakeIds // ignore: cast_nullable_to_non_nullable
as List<String>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SymptomType type,  DateTime timestamp,  int intensity,  String? detail,  String note,  DateTime? endTime,  bool isSaving,  String? id,  List<MedicationIntakeDraft> intakes,  List<String> removedIntakeIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SymptomEntryState() when $default != null:
return $default(_that.type,_that.timestamp,_that.intensity,_that.detail,_that.note,_that.endTime,_that.isSaving,_that.id,_that.intakes,_that.removedIntakeIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SymptomType type,  DateTime timestamp,  int intensity,  String? detail,  String note,  DateTime? endTime,  bool isSaving,  String? id,  List<MedicationIntakeDraft> intakes,  List<String> removedIntakeIds)  $default,) {final _that = this;
switch (_that) {
case _SymptomEntryState():
return $default(_that.type,_that.timestamp,_that.intensity,_that.detail,_that.note,_that.endTime,_that.isSaving,_that.id,_that.intakes,_that.removedIntakeIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SymptomType type,  DateTime timestamp,  int intensity,  String? detail,  String note,  DateTime? endTime,  bool isSaving,  String? id,  List<MedicationIntakeDraft> intakes,  List<String> removedIntakeIds)?  $default,) {final _that = this;
switch (_that) {
case _SymptomEntryState() when $default != null:
return $default(_that.type,_that.timestamp,_that.intensity,_that.detail,_that.note,_that.endTime,_that.isSaving,_that.id,_that.intakes,_that.removedIntakeIds);case _:
  return null;

}
}

}

/// @nodoc


class _SymptomEntryState implements SymptomEntryState {
  const _SymptomEntryState({required this.type, required this.timestamp, this.intensity = 5, this.detail, this.note = '', this.endTime, this.isSaving = false, this.id, final  List<MedicationIntakeDraft> intakes = const <MedicationIntakeDraft>[], final  List<String> removedIntakeIds = const <String>[]}): _intakes = intakes,_removedIntakeIds = removedIntakeIds;
  

@override final  SymptomType type;
@override final  DateTime timestamp;
@override@JsonKey() final  int intensity;
@override final  String? detail;
@override@JsonKey() final  String note;
@override final  DateTime? endTime;
@override@JsonKey() final  bool isSaving;
@override final  String? id;
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


/// Create a copy of SymptomEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SymptomEntryStateCopyWith<_SymptomEntryState> get copyWith => __$SymptomEntryStateCopyWithImpl<_SymptomEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SymptomEntryState&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.note, note) || other.note == note)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._intakes, _intakes)&&const DeepCollectionEquality().equals(other._removedIntakeIds, _removedIntakeIds));
}


@override
int get hashCode => Object.hash(runtimeType,type,timestamp,intensity,detail,note,endTime,isSaving,id,const DeepCollectionEquality().hash(_intakes),const DeepCollectionEquality().hash(_removedIntakeIds));

@override
String toString() {
  return 'SymptomEntryState(type: $type, timestamp: $timestamp, intensity: $intensity, detail: $detail, note: $note, endTime: $endTime, isSaving: $isSaving, id: $id, intakes: $intakes, removedIntakeIds: $removedIntakeIds)';
}


}

/// @nodoc
abstract mixin class _$SymptomEntryStateCopyWith<$Res> implements $SymptomEntryStateCopyWith<$Res> {
  factory _$SymptomEntryStateCopyWith(_SymptomEntryState value, $Res Function(_SymptomEntryState) _then) = __$SymptomEntryStateCopyWithImpl;
@override @useResult
$Res call({
 SymptomType type, DateTime timestamp, int intensity, String? detail, String note, DateTime? endTime, bool isSaving, String? id, List<MedicationIntakeDraft> intakes, List<String> removedIntakeIds
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
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? timestamp = null,Object? intensity = null,Object? detail = freezed,Object? note = null,Object? endTime = freezed,Object? isSaving = null,Object? id = freezed,Object? intakes = null,Object? removedIntakeIds = null,}) {
  return _then(_SymptomEntryState(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SymptomType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,intakes: null == intakes ? _self._intakes : intakes // ignore: cast_nullable_to_non_nullable
as List<MedicationIntakeDraft>,removedIntakeIds: null == removedIntakeIds ? _self._removedIntakeIds : removedIntakeIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
