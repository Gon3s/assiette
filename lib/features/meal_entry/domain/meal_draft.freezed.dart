// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MealDraft {

 String get id; DateTime get timestamp; MealType get mealType; List<TagOption> get tags; String? get photoPath; String? get note;
/// Create a copy of MealDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealDraftCopyWith<MealDraft> get copyWith => _$MealDraftCopyWithImpl<MealDraft>(this as MealDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealDraft&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp,mealType,const DeepCollectionEquality().hash(tags),photoPath,note);

@override
String toString() {
  return 'MealDraft(id: $id, timestamp: $timestamp, mealType: $mealType, tags: $tags, photoPath: $photoPath, note: $note)';
}


}

/// @nodoc
abstract mixin class $MealDraftCopyWith<$Res>  {
  factory $MealDraftCopyWith(MealDraft value, $Res Function(MealDraft) _then) = _$MealDraftCopyWithImpl;
@useResult
$Res call({
 String id, DateTime timestamp, MealType mealType, List<TagOption> tags, String? photoPath, String? note
});




}
/// @nodoc
class _$MealDraftCopyWithImpl<$Res>
    implements $MealDraftCopyWith<$Res> {
  _$MealDraftCopyWithImpl(this._self, this._then);

  final MealDraft _self;
  final $Res Function(MealDraft) _then;

/// Create a copy of MealDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? timestamp = null,Object? mealType = null,Object? tags = null,Object? photoPath = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as MealType,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagOption>,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MealDraft].
extension MealDraftPatterns on MealDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealDraft value)  $default,){
final _that = this;
switch (_that) {
case _MealDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealDraft value)?  $default,){
final _that = this;
switch (_that) {
case _MealDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime timestamp,  MealType mealType,  List<TagOption> tags,  String? photoPath,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealDraft() when $default != null:
return $default(_that.id,_that.timestamp,_that.mealType,_that.tags,_that.photoPath,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime timestamp,  MealType mealType,  List<TagOption> tags,  String? photoPath,  String? note)  $default,) {final _that = this;
switch (_that) {
case _MealDraft():
return $default(_that.id,_that.timestamp,_that.mealType,_that.tags,_that.photoPath,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime timestamp,  MealType mealType,  List<TagOption> tags,  String? photoPath,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _MealDraft() when $default != null:
return $default(_that.id,_that.timestamp,_that.mealType,_that.tags,_that.photoPath,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _MealDraft implements MealDraft {
  const _MealDraft({required this.id, required this.timestamp, required this.mealType, required final  List<TagOption> tags, this.photoPath, this.note}): _tags = tags;
  

@override final  String id;
@override final  DateTime timestamp;
@override final  MealType mealType;
 final  List<TagOption> _tags;
@override List<TagOption> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? photoPath;
@override final  String? note;

/// Create a copy of MealDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealDraftCopyWith<_MealDraft> get copyWith => __$MealDraftCopyWithImpl<_MealDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealDraft&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp,mealType,const DeepCollectionEquality().hash(_tags),photoPath,note);

@override
String toString() {
  return 'MealDraft(id: $id, timestamp: $timestamp, mealType: $mealType, tags: $tags, photoPath: $photoPath, note: $note)';
}


}

/// @nodoc
abstract mixin class _$MealDraftCopyWith<$Res> implements $MealDraftCopyWith<$Res> {
  factory _$MealDraftCopyWith(_MealDraft value, $Res Function(_MealDraft) _then) = __$MealDraftCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime timestamp, MealType mealType, List<TagOption> tags, String? photoPath, String? note
});




}
/// @nodoc
class __$MealDraftCopyWithImpl<$Res>
    implements _$MealDraftCopyWith<$Res> {
  __$MealDraftCopyWithImpl(this._self, this._then);

  final _MealDraft _self;
  final $Res Function(_MealDraft) _then;

/// Create a copy of MealDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,Object? mealType = null,Object? tags = null,Object? photoPath = freezed,Object? note = freezed,}) {
  return _then(_MealDraft(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as MealType,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagOption>,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
