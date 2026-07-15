// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimelineItem {

 String get id; DateTime get timestamp;
/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineItemCopyWith<TimelineItem> get copyWith => _$TimelineItemCopyWithImpl<TimelineItem>(this as TimelineItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineItem&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp);

@override
String toString() {
  return 'TimelineItem(id: $id, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $TimelineItemCopyWith<$Res>  {
  factory $TimelineItemCopyWith(TimelineItem value, $Res Function(TimelineItem) _then) = _$TimelineItemCopyWithImpl;
@useResult
$Res call({
 String id, DateTime timestamp
});




}
/// @nodoc
class _$TimelineItemCopyWithImpl<$Res>
    implements $TimelineItemCopyWith<$Res> {
  _$TimelineItemCopyWithImpl(this._self, this._then);

  final TimelineItem _self;
  final $Res Function(TimelineItem) _then;

/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineItem].
extension TimelineItemPatterns on TimelineItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MealTimelineItem value)?  meal,TResult Function( SymptomTimelineItem value)?  symptom,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MealTimelineItem() when meal != null:
return meal(_that);case SymptomTimelineItem() when symptom != null:
return symptom(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MealTimelineItem value)  meal,required TResult Function( SymptomTimelineItem value)  symptom,}){
final _that = this;
switch (_that) {
case MealTimelineItem():
return meal(_that);case SymptomTimelineItem():
return symptom(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MealTimelineItem value)?  meal,TResult? Function( SymptomTimelineItem value)?  symptom,}){
final _that = this;
switch (_that) {
case MealTimelineItem() when meal != null:
return meal(_that);case SymptomTimelineItem() when symptom != null:
return symptom(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  DateTime timestamp,  MealType mealType,  List<String> tagLabels,  String? photoPath)?  meal,TResult Function( String id,  DateTime timestamp,  SymptomType symptomType,  int intensity,  String? detail)?  symptom,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MealTimelineItem() when meal != null:
return meal(_that.id,_that.timestamp,_that.mealType,_that.tagLabels,_that.photoPath);case SymptomTimelineItem() when symptom != null:
return symptom(_that.id,_that.timestamp,_that.symptomType,_that.intensity,_that.detail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  DateTime timestamp,  MealType mealType,  List<String> tagLabels,  String? photoPath)  meal,required TResult Function( String id,  DateTime timestamp,  SymptomType symptomType,  int intensity,  String? detail)  symptom,}) {final _that = this;
switch (_that) {
case MealTimelineItem():
return meal(_that.id,_that.timestamp,_that.mealType,_that.tagLabels,_that.photoPath);case SymptomTimelineItem():
return symptom(_that.id,_that.timestamp,_that.symptomType,_that.intensity,_that.detail);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  DateTime timestamp,  MealType mealType,  List<String> tagLabels,  String? photoPath)?  meal,TResult? Function( String id,  DateTime timestamp,  SymptomType symptomType,  int intensity,  String? detail)?  symptom,}) {final _that = this;
switch (_that) {
case MealTimelineItem() when meal != null:
return meal(_that.id,_that.timestamp,_that.mealType,_that.tagLabels,_that.photoPath);case SymptomTimelineItem() when symptom != null:
return symptom(_that.id,_that.timestamp,_that.symptomType,_that.intensity,_that.detail);case _:
  return null;

}
}

}

/// @nodoc


class MealTimelineItem implements TimelineItem {
  const MealTimelineItem({required this.id, required this.timestamp, required this.mealType, required final  List<String> tagLabels, this.photoPath}): _tagLabels = tagLabels;
  

@override final  String id;
@override final  DateTime timestamp;
 final  MealType mealType;
 final  List<String> _tagLabels;
 List<String> get tagLabels {
  if (_tagLabels is EqualUnmodifiableListView) return _tagLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagLabels);
}

 final  String? photoPath;

/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealTimelineItemCopyWith<MealTimelineItem> get copyWith => _$MealTimelineItemCopyWithImpl<MealTimelineItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealTimelineItem&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&const DeepCollectionEquality().equals(other._tagLabels, _tagLabels)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp,mealType,const DeepCollectionEquality().hash(_tagLabels),photoPath);

@override
String toString() {
  return 'TimelineItem.meal(id: $id, timestamp: $timestamp, mealType: $mealType, tagLabels: $tagLabels, photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class $MealTimelineItemCopyWith<$Res> implements $TimelineItemCopyWith<$Res> {
  factory $MealTimelineItemCopyWith(MealTimelineItem value, $Res Function(MealTimelineItem) _then) = _$MealTimelineItemCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime timestamp, MealType mealType, List<String> tagLabels, String? photoPath
});




}
/// @nodoc
class _$MealTimelineItemCopyWithImpl<$Res>
    implements $MealTimelineItemCopyWith<$Res> {
  _$MealTimelineItemCopyWithImpl(this._self, this._then);

  final MealTimelineItem _self;
  final $Res Function(MealTimelineItem) _then;

/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,Object? mealType = null,Object? tagLabels = null,Object? photoPath = freezed,}) {
  return _then(MealTimelineItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as MealType,tagLabels: null == tagLabels ? _self._tagLabels : tagLabels // ignore: cast_nullable_to_non_nullable
as List<String>,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SymptomTimelineItem implements TimelineItem {
  const SymptomTimelineItem({required this.id, required this.timestamp, required this.symptomType, required this.intensity, this.detail});
  

@override final  String id;
@override final  DateTime timestamp;
 final  SymptomType symptomType;
 final  int intensity;
 final  String? detail;

/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymptomTimelineItemCopyWith<SymptomTimelineItem> get copyWith => _$SymptomTimelineItemCopyWithImpl<SymptomTimelineItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymptomTimelineItem&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.symptomType, symptomType) || other.symptomType == symptomType)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp,symptomType,intensity,detail);

@override
String toString() {
  return 'TimelineItem.symptom(id: $id, timestamp: $timestamp, symptomType: $symptomType, intensity: $intensity, detail: $detail)';
}


}

/// @nodoc
abstract mixin class $SymptomTimelineItemCopyWith<$Res> implements $TimelineItemCopyWith<$Res> {
  factory $SymptomTimelineItemCopyWith(SymptomTimelineItem value, $Res Function(SymptomTimelineItem) _then) = _$SymptomTimelineItemCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime timestamp, SymptomType symptomType, int intensity, String? detail
});




}
/// @nodoc
class _$SymptomTimelineItemCopyWithImpl<$Res>
    implements $SymptomTimelineItemCopyWith<$Res> {
  _$SymptomTimelineItemCopyWithImpl(this._self, this._then);

  final SymptomTimelineItem _self;
  final $Res Function(SymptomTimelineItem) _then;

/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,Object? symptomType = null,Object? intensity = null,Object? detail = freezed,}) {
  return _then(SymptomTimelineItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,symptomType: null == symptomType ? _self.symptomType : symptomType // ignore: cast_nullable_to_non_nullable
as SymptomType,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
