// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'managed_tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ManagedTag {

 String get id; String get label; bool get isSystem; int get dayCount; int get mealCount; int get favoriteCount; String? get category;
/// Create a copy of ManagedTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManagedTagCopyWith<ManagedTag> get copyWith => _$ManagedTagCopyWithImpl<ManagedTag>(this as ManagedTag, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ManagedTag;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManagedTag&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.isSystem, _this.isSystem) || other.isSystem == _this.isSystem)&&(identical(other.dayCount, _this.dayCount) || other.dayCount == _this.dayCount)&&(identical(other.mealCount, _this.mealCount) || other.mealCount == _this.mealCount)&&(identical(other.favoriteCount, _this.favoriteCount) || other.favoriteCount == _this.favoriteCount)&&(identical(other.category, _this.category) || other.category == _this.category));
}


@override
int get hashCode {
  final _this = this as ManagedTag;
  return Object.hash(runtimeType,_this.id,_this.label,_this.isSystem,_this.dayCount,_this.mealCount,_this.favoriteCount,_this.category);
}

@override
String toString() {
  final _this = this as ManagedTag;
  return 'ManagedTag(id: ${_this.id}, label: ${_this.label}, isSystem: ${_this.isSystem}, dayCount: ${_this.dayCount}, mealCount: ${_this.mealCount}, favoriteCount: ${_this.favoriteCount}, category: ${_this.category})';
}


}

/// @nodoc
abstract mixin class $ManagedTagCopyWith<$Res>  {
  factory $ManagedTagCopyWith(ManagedTag value, $Res Function(ManagedTag) _then) = _$ManagedTagCopyWithImpl;
@useResult
$Res call({
 String id, String label, bool isSystem, int dayCount, int mealCount, int favoriteCount, String? category
});




}
/// @nodoc
class _$ManagedTagCopyWithImpl<$Res>
    implements $ManagedTagCopyWith<$Res> {
  _$ManagedTagCopyWithImpl(this._self, this._then);

  final ManagedTag _self;
  final $Res Function(ManagedTag) _then;

/// Create a copy of ManagedTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? isSystem = null,Object? dayCount = null,Object? mealCount = null,Object? favoriteCount = null,Object? category = freezed,}) {
  return _then(ManagedTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,dayCount: null == dayCount ? _self.dayCount : dayCount // ignore: cast_nullable_to_non_nullable
as int,mealCount: null == mealCount ? _self.mealCount : mealCount // ignore: cast_nullable_to_non_nullable
as int,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ManagedTag].
extension ManagedTagPatterns on ManagedTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManagedTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManagedTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManagedTag value)  $default,){
final _that = this;
switch (_that) {
case _ManagedTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManagedTag value)?  $default,){
final _that = this;
switch (_that) {
case _ManagedTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  bool isSystem,  int dayCount,  int mealCount,  int favoriteCount,  String? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManagedTag() when $default != null:
return $default(_that.id,_that.label,_that.isSystem,_that.dayCount,_that.mealCount,_that.favoriteCount,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  bool isSystem,  int dayCount,  int mealCount,  int favoriteCount,  String? category)  $default,) {final _that = this;
switch (_that) {
case _ManagedTag():
return $default(_that.id,_that.label,_that.isSystem,_that.dayCount,_that.mealCount,_that.favoriteCount,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  bool isSystem,  int dayCount,  int mealCount,  int favoriteCount,  String? category)?  $default,) {final _that = this;
switch (_that) {
case _ManagedTag() when $default != null:
return $default(_that.id,_that.label,_that.isSystem,_that.dayCount,_that.mealCount,_that.favoriteCount,_that.category);case _:
  return null;

}
}

}

/// @nodoc


class _ManagedTag implements ManagedTag {
  const _ManagedTag({required this.id, required this.label, required this.isSystem, required this.dayCount, required this.mealCount, required this.favoriteCount, this.category});
  

@override final  String id;
@override final  String label;
@override final  bool isSystem;
@override final  int dayCount;
@override final  int mealCount;
@override final  int favoriteCount;
@override final  String? category;

/// Create a copy of ManagedTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManagedTagCopyWith<_ManagedTag> get copyWith => __$ManagedTagCopyWithImpl<_ManagedTag>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManagedTag&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&(identical(other.dayCount, dayCount) || other.dayCount == dayCount)&&(identical(other.mealCount, mealCount) || other.mealCount == mealCount)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,label,isSystem,dayCount,mealCount,favoriteCount,category);
}

@override
String toString() {
    return 'ManagedTag(id: $id, label: $label, isSystem: $isSystem, dayCount: $dayCount, mealCount: $mealCount, favoriteCount: $favoriteCount, category: $category)';
}


}

/// @nodoc
abstract mixin class _$ManagedTagCopyWith<$Res> implements $ManagedTagCopyWith<$Res> {
  factory _$ManagedTagCopyWith(_ManagedTag value, $Res Function(_ManagedTag) _then) = __$ManagedTagCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, bool isSystem, int dayCount, int mealCount, int favoriteCount, String? category
});




}
/// @nodoc
class __$ManagedTagCopyWithImpl<$Res>
    implements _$ManagedTagCopyWith<$Res> {
  __$ManagedTagCopyWithImpl(this._self, this._then);

  final _ManagedTag _self;
  final $Res Function(_ManagedTag) _then;

/// Create a copy of ManagedTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? isSystem = null,Object? dayCount = null,Object? mealCount = null,Object? favoriteCount = null,Object? category = freezed,}) {
  return _then(_ManagedTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,dayCount: null == dayCount ? _self.dayCount : dayCount // ignore: cast_nullable_to_non_nullable
as int,mealCount: null == mealCount ? _self.mealCount : mealCount // ignore: cast_nullable_to_non_nullable
as int,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
