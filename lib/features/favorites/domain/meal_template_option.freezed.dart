// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_template_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MealTemplateOption {

 String get id; String get name; List<TagOption> get tags; MealType? get defaultMealType; String? get defaultPhotoPath;
/// Create a copy of MealTemplateOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealTemplateOptionCopyWith<MealTemplateOption> get copyWith => _$MealTemplateOptionCopyWithImpl<MealTemplateOption>(this as MealTemplateOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealTemplateOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.defaultMealType, defaultMealType) || other.defaultMealType == defaultMealType)&&(identical(other.defaultPhotoPath, defaultPhotoPath) || other.defaultPhotoPath == defaultPhotoPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(tags),defaultMealType,defaultPhotoPath);

@override
String toString() {
  return 'MealTemplateOption(id: $id, name: $name, tags: $tags, defaultMealType: $defaultMealType, defaultPhotoPath: $defaultPhotoPath)';
}


}

/// @nodoc
abstract mixin class $MealTemplateOptionCopyWith<$Res>  {
  factory $MealTemplateOptionCopyWith(MealTemplateOption value, $Res Function(MealTemplateOption) _then) = _$MealTemplateOptionCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<TagOption> tags, MealType? defaultMealType, String? defaultPhotoPath
});




}
/// @nodoc
class _$MealTemplateOptionCopyWithImpl<$Res>
    implements $MealTemplateOptionCopyWith<$Res> {
  _$MealTemplateOptionCopyWithImpl(this._self, this._then);

  final MealTemplateOption _self;
  final $Res Function(MealTemplateOption) _then;

/// Create a copy of MealTemplateOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? tags = null,Object? defaultMealType = freezed,Object? defaultPhotoPath = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagOption>,defaultMealType: freezed == defaultMealType ? _self.defaultMealType : defaultMealType // ignore: cast_nullable_to_non_nullable
as MealType?,defaultPhotoPath: freezed == defaultPhotoPath ? _self.defaultPhotoPath : defaultPhotoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MealTemplateOption].
extension MealTemplateOptionPatterns on MealTemplateOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealTemplateOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealTemplateOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealTemplateOption value)  $default,){
final _that = this;
switch (_that) {
case _MealTemplateOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealTemplateOption value)?  $default,){
final _that = this;
switch (_that) {
case _MealTemplateOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<TagOption> tags,  MealType? defaultMealType,  String? defaultPhotoPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealTemplateOption() when $default != null:
return $default(_that.id,_that.name,_that.tags,_that.defaultMealType,_that.defaultPhotoPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<TagOption> tags,  MealType? defaultMealType,  String? defaultPhotoPath)  $default,) {final _that = this;
switch (_that) {
case _MealTemplateOption():
return $default(_that.id,_that.name,_that.tags,_that.defaultMealType,_that.defaultPhotoPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<TagOption> tags,  MealType? defaultMealType,  String? defaultPhotoPath)?  $default,) {final _that = this;
switch (_that) {
case _MealTemplateOption() when $default != null:
return $default(_that.id,_that.name,_that.tags,_that.defaultMealType,_that.defaultPhotoPath);case _:
  return null;

}
}

}

/// @nodoc


class _MealTemplateOption implements MealTemplateOption {
  const _MealTemplateOption({required this.id, required this.name, required final  List<TagOption> tags, this.defaultMealType, this.defaultPhotoPath}): _tags = tags;
  

@override final  String id;
@override final  String name;
 final  List<TagOption> _tags;
@override List<TagOption> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  MealType? defaultMealType;
@override final  String? defaultPhotoPath;

/// Create a copy of MealTemplateOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealTemplateOptionCopyWith<_MealTemplateOption> get copyWith => __$MealTemplateOptionCopyWithImpl<_MealTemplateOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealTemplateOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.defaultMealType, defaultMealType) || other.defaultMealType == defaultMealType)&&(identical(other.defaultPhotoPath, defaultPhotoPath) || other.defaultPhotoPath == defaultPhotoPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_tags),defaultMealType,defaultPhotoPath);

@override
String toString() {
  return 'MealTemplateOption(id: $id, name: $name, tags: $tags, defaultMealType: $defaultMealType, defaultPhotoPath: $defaultPhotoPath)';
}


}

/// @nodoc
abstract mixin class _$MealTemplateOptionCopyWith<$Res> implements $MealTemplateOptionCopyWith<$Res> {
  factory _$MealTemplateOptionCopyWith(_MealTemplateOption value, $Res Function(_MealTemplateOption) _then) = __$MealTemplateOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<TagOption> tags, MealType? defaultMealType, String? defaultPhotoPath
});




}
/// @nodoc
class __$MealTemplateOptionCopyWithImpl<$Res>
    implements _$MealTemplateOptionCopyWith<$Res> {
  __$MealTemplateOptionCopyWithImpl(this._self, this._then);

  final _MealTemplateOption _self;
  final $Res Function(_MealTemplateOption) _then;

/// Create a copy of MealTemplateOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? tags = null,Object? defaultMealType = freezed,Object? defaultPhotoPath = freezed,}) {
  return _then(_MealTemplateOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagOption>,defaultMealType: freezed == defaultMealType ? _self.defaultMealType : defaultMealType // ignore: cast_nullable_to_non_nullable
as MealType?,defaultPhotoPath: freezed == defaultPhotoPath ? _self.defaultPhotoPath : defaultPhotoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
