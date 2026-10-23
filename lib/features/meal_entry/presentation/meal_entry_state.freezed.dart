// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_entry_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MealEntryState {

 MealType get mealType; DateTime get timestamp; List<TagOption> get selectedTags; String get note; String? get photoPath; bool get isSaving; String? get id;
/// Create a copy of MealEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealEntryStateCopyWith<MealEntryState> get copyWith => _$MealEntryStateCopyWithImpl<MealEntryState>(this as MealEntryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealEntryState&&(identical(other.mealType, mealType) || other.mealType == mealType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.selectedTags, selectedTags)&&(identical(other.note, note) || other.note == note)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,mealType,timestamp,const DeepCollectionEquality().hash(selectedTags),note,photoPath,isSaving,id);

@override
String toString() {
  return 'MealEntryState(mealType: $mealType, timestamp: $timestamp, selectedTags: $selectedTags, note: $note, photoPath: $photoPath, isSaving: $isSaving, id: $id)';
}


}

/// @nodoc
abstract mixin class $MealEntryStateCopyWith<$Res>  {
  factory $MealEntryStateCopyWith(MealEntryState value, $Res Function(MealEntryState) _then) = _$MealEntryStateCopyWithImpl;
@useResult
$Res call({
 MealType mealType, DateTime timestamp, List<TagOption> selectedTags, String note, String? photoPath, bool isSaving, String? id
});




}
/// @nodoc
class _$MealEntryStateCopyWithImpl<$Res>
    implements $MealEntryStateCopyWith<$Res> {
  _$MealEntryStateCopyWithImpl(this._self, this._then);

  final MealEntryState _self;
  final $Res Function(MealEntryState) _then;

/// Create a copy of MealEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mealType = null,Object? timestamp = null,Object? selectedTags = null,Object? note = null,Object? photoPath = freezed,Object? isSaving = null,Object? id = freezed,}) {
  return _then(_self.copyWith(
mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as MealType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,selectedTags: null == selectedTags ? _self.selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<TagOption>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MealEntryState].
extension MealEntryStatePatterns on MealEntryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealEntryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealEntryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealEntryState value)  $default,){
final _that = this;
switch (_that) {
case _MealEntryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealEntryState value)?  $default,){
final _that = this;
switch (_that) {
case _MealEntryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MealType mealType,  DateTime timestamp,  List<TagOption> selectedTags,  String note,  String? photoPath,  bool isSaving,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealEntryState() when $default != null:
return $default(_that.mealType,_that.timestamp,_that.selectedTags,_that.note,_that.photoPath,_that.isSaving,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MealType mealType,  DateTime timestamp,  List<TagOption> selectedTags,  String note,  String? photoPath,  bool isSaving,  String? id)  $default,) {final _that = this;
switch (_that) {
case _MealEntryState():
return $default(_that.mealType,_that.timestamp,_that.selectedTags,_that.note,_that.photoPath,_that.isSaving,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MealType mealType,  DateTime timestamp,  List<TagOption> selectedTags,  String note,  String? photoPath,  bool isSaving,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _MealEntryState() when $default != null:
return $default(_that.mealType,_that.timestamp,_that.selectedTags,_that.note,_that.photoPath,_that.isSaving,_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _MealEntryState implements MealEntryState {
  const _MealEntryState({required this.mealType, required this.timestamp, required final  List<TagOption> selectedTags, this.note = '', this.photoPath, this.isSaving = false, this.id}): _selectedTags = selectedTags;
  

@override final  MealType mealType;
@override final  DateTime timestamp;
 final  List<TagOption> _selectedTags;
@override List<TagOption> get selectedTags {
  if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedTags);
}

@override@JsonKey() final  String note;
@override final  String? photoPath;
@override@JsonKey() final  bool isSaving;
@override final  String? id;

/// Create a copy of MealEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealEntryStateCopyWith<_MealEntryState> get copyWith => __$MealEntryStateCopyWithImpl<_MealEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealEntryState&&(identical(other.mealType, mealType) || other.mealType == mealType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._selectedTags, _selectedTags)&&(identical(other.note, note) || other.note == note)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,mealType,timestamp,const DeepCollectionEquality().hash(_selectedTags),note,photoPath,isSaving,id);

@override
String toString() {
  return 'MealEntryState(mealType: $mealType, timestamp: $timestamp, selectedTags: $selectedTags, note: $note, photoPath: $photoPath, isSaving: $isSaving, id: $id)';
}


}

/// @nodoc
abstract mixin class _$MealEntryStateCopyWith<$Res> implements $MealEntryStateCopyWith<$Res> {
  factory _$MealEntryStateCopyWith(_MealEntryState value, $Res Function(_MealEntryState) _then) = __$MealEntryStateCopyWithImpl;
@override @useResult
$Res call({
 MealType mealType, DateTime timestamp, List<TagOption> selectedTags, String note, String? photoPath, bool isSaving, String? id
});




}
/// @nodoc
class __$MealEntryStateCopyWithImpl<$Res>
    implements _$MealEntryStateCopyWith<$Res> {
  __$MealEntryStateCopyWithImpl(this._self, this._then);

  final _MealEntryState _self;
  final $Res Function(_MealEntryState) _then;

/// Create a copy of MealEntryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mealType = null,Object? timestamp = null,Object? selectedTags = null,Object? note = null,Object? photoPath = freezed,Object? isSaving = null,Object? id = freezed,}) {
  return _then(_MealEntryState(
mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as MealType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,selectedTags: null == selectedTags ? _self._selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<TagOption>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
