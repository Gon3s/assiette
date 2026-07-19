// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medication_intake_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MedicationIntakeDraft {

 DateTime get timestamp; String get name; String? get dose; String? get id; String? get symptomId;
/// Create a copy of MedicationIntakeDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicationIntakeDraftCopyWith<MedicationIntakeDraft> get copyWith => _$MedicationIntakeDraftCopyWithImpl<MedicationIntakeDraft>(this as MedicationIntakeDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationIntakeDraft&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.name, name) || other.name == name)&&(identical(other.dose, dose) || other.dose == dose)&&(identical(other.id, id) || other.id == id)&&(identical(other.symptomId, symptomId) || other.symptomId == symptomId));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,name,dose,id,symptomId);

@override
String toString() {
  return 'MedicationIntakeDraft(timestamp: $timestamp, name: $name, dose: $dose, id: $id, symptomId: $symptomId)';
}


}

/// @nodoc
abstract mixin class $MedicationIntakeDraftCopyWith<$Res>  {
  factory $MedicationIntakeDraftCopyWith(MedicationIntakeDraft value, $Res Function(MedicationIntakeDraft) _then) = _$MedicationIntakeDraftCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, String name, String? dose, String? id, String? symptomId
});




}
/// @nodoc
class _$MedicationIntakeDraftCopyWithImpl<$Res>
    implements $MedicationIntakeDraftCopyWith<$Res> {
  _$MedicationIntakeDraftCopyWithImpl(this._self, this._then);

  final MedicationIntakeDraft _self;
  final $Res Function(MedicationIntakeDraft) _then;

/// Create a copy of MedicationIntakeDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? name = null,Object? dose = freezed,Object? id = freezed,Object? symptomId = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dose: freezed == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,symptomId: freezed == symptomId ? _self.symptomId : symptomId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MedicationIntakeDraft].
extension MedicationIntakeDraftPatterns on MedicationIntakeDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedicationIntakeDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedicationIntakeDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedicationIntakeDraft value)  $default,){
final _that = this;
switch (_that) {
case _MedicationIntakeDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedicationIntakeDraft value)?  $default,){
final _that = this;
switch (_that) {
case _MedicationIntakeDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  String name,  String? dose,  String? id,  String? symptomId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedicationIntakeDraft() when $default != null:
return $default(_that.timestamp,_that.name,_that.dose,_that.id,_that.symptomId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  String name,  String? dose,  String? id,  String? symptomId)  $default,) {final _that = this;
switch (_that) {
case _MedicationIntakeDraft():
return $default(_that.timestamp,_that.name,_that.dose,_that.id,_that.symptomId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  String name,  String? dose,  String? id,  String? symptomId)?  $default,) {final _that = this;
switch (_that) {
case _MedicationIntakeDraft() when $default != null:
return $default(_that.timestamp,_that.name,_that.dose,_that.id,_that.symptomId);case _:
  return null;

}
}

}

/// @nodoc


class _MedicationIntakeDraft implements MedicationIntakeDraft {
  const _MedicationIntakeDraft({required this.timestamp, required this.name, this.dose, this.id, this.symptomId});
  

@override final  DateTime timestamp;
@override final  String name;
@override final  String? dose;
@override final  String? id;
@override final  String? symptomId;

/// Create a copy of MedicationIntakeDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicationIntakeDraftCopyWith<_MedicationIntakeDraft> get copyWith => __$MedicationIntakeDraftCopyWithImpl<_MedicationIntakeDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicationIntakeDraft&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.name, name) || other.name == name)&&(identical(other.dose, dose) || other.dose == dose)&&(identical(other.id, id) || other.id == id)&&(identical(other.symptomId, symptomId) || other.symptomId == symptomId));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,name,dose,id,symptomId);

@override
String toString() {
  return 'MedicationIntakeDraft(timestamp: $timestamp, name: $name, dose: $dose, id: $id, symptomId: $symptomId)';
}


}

/// @nodoc
abstract mixin class _$MedicationIntakeDraftCopyWith<$Res> implements $MedicationIntakeDraftCopyWith<$Res> {
  factory _$MedicationIntakeDraftCopyWith(_MedicationIntakeDraft value, $Res Function(_MedicationIntakeDraft) _then) = __$MedicationIntakeDraftCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, String name, String? dose, String? id, String? symptomId
});




}
/// @nodoc
class __$MedicationIntakeDraftCopyWithImpl<$Res>
    implements _$MedicationIntakeDraftCopyWith<$Res> {
  __$MedicationIntakeDraftCopyWithImpl(this._self, this._then);

  final _MedicationIntakeDraft _self;
  final $Res Function(_MedicationIntakeDraft) _then;

/// Create a copy of MedicationIntakeDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? name = null,Object? dose = freezed,Object? id = freezed,Object? symptomId = freezed,}) {
  return _then(_MedicationIntakeDraft(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dose: freezed == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,symptomId: freezed == symptomId ? _self.symptomId : symptomId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
