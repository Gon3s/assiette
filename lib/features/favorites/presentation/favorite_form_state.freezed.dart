// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoriteFormState {

 String? get id; String get name; MealType? get mealType; List<TagOption> get selectedTags; String? get photoPath; bool get isSaving;
/// Create a copy of FavoriteFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteFormStateCopyWith<FavoriteFormState> get copyWith => _$FavoriteFormStateCopyWithImpl<FavoriteFormState>(this as FavoriteFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteFormState&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&const DeepCollectionEquality().equals(other.selectedTags, selectedTags)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,mealType,const DeepCollectionEquality().hash(selectedTags),photoPath,isSaving);

@override
String toString() {
  return 'FavoriteFormState(id: $id, name: $name, mealType: $mealType, selectedTags: $selectedTags, photoPath: $photoPath, isSaving: $isSaving)';
}


}

/// @nodoc
abstract mixin class $FavoriteFormStateCopyWith<$Res>  {
  factory $FavoriteFormStateCopyWith(FavoriteFormState value, $Res Function(FavoriteFormState) _then) = _$FavoriteFormStateCopyWithImpl;
@useResult
$Res call({
 String? id, String name, MealType? mealType, List<TagOption> selectedTags, String? photoPath, bool isSaving
});




}
/// @nodoc
class _$FavoriteFormStateCopyWithImpl<$Res>
    implements $FavoriteFormStateCopyWith<$Res> {
  _$FavoriteFormStateCopyWithImpl(this._self, this._then);

  final FavoriteFormState _self;
  final $Res Function(FavoriteFormState) _then;

/// Create a copy of FavoriteFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? mealType = freezed,Object? selectedTags = null,Object? photoPath = freezed,Object? isSaving = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mealType: freezed == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as MealType?,selectedTags: null == selectedTags ? _self.selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<TagOption>,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteFormState].
extension FavoriteFormStatePatterns on FavoriteFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteFormState value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteFormState value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  MealType? mealType,  List<TagOption> selectedTags,  String? photoPath,  bool isSaving)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteFormState() when $default != null:
return $default(_that.id,_that.name,_that.mealType,_that.selectedTags,_that.photoPath,_that.isSaving);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  MealType? mealType,  List<TagOption> selectedTags,  String? photoPath,  bool isSaving)  $default,) {final _that = this;
switch (_that) {
case _FavoriteFormState():
return $default(_that.id,_that.name,_that.mealType,_that.selectedTags,_that.photoPath,_that.isSaving);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  MealType? mealType,  List<TagOption> selectedTags,  String? photoPath,  bool isSaving)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteFormState() when $default != null:
return $default(_that.id,_that.name,_that.mealType,_that.selectedTags,_that.photoPath,_that.isSaving);case _:
  return null;

}
}

}

/// @nodoc


class _FavoriteFormState implements FavoriteFormState {
  const _FavoriteFormState({this.id, this.name = '', this.mealType, final  List<TagOption> selectedTags = const [], this.photoPath, this.isSaving = false}): _selectedTags = selectedTags;
  

@override final  String? id;
@override@JsonKey() final  String name;
@override final  MealType? mealType;
 final  List<TagOption> _selectedTags;
@override@JsonKey() List<TagOption> get selectedTags {
  if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedTags);
}

@override final  String? photoPath;
@override@JsonKey() final  bool isSaving;

/// Create a copy of FavoriteFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteFormStateCopyWith<_FavoriteFormState> get copyWith => __$FavoriteFormStateCopyWithImpl<_FavoriteFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteFormState&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&const DeepCollectionEquality().equals(other._selectedTags, _selectedTags)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,mealType,const DeepCollectionEquality().hash(_selectedTags),photoPath,isSaving);

@override
String toString() {
  return 'FavoriteFormState(id: $id, name: $name, mealType: $mealType, selectedTags: $selectedTags, photoPath: $photoPath, isSaving: $isSaving)';
}


}

/// @nodoc
abstract mixin class _$FavoriteFormStateCopyWith<$Res> implements $FavoriteFormStateCopyWith<$Res> {
  factory _$FavoriteFormStateCopyWith(_FavoriteFormState value, $Res Function(_FavoriteFormState) _then) = __$FavoriteFormStateCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, MealType? mealType, List<TagOption> selectedTags, String? photoPath, bool isSaving
});




}
/// @nodoc
class __$FavoriteFormStateCopyWithImpl<$Res>
    implements _$FavoriteFormStateCopyWith<$Res> {
  __$FavoriteFormStateCopyWithImpl(this._self, this._then);

  final _FavoriteFormState _self;
  final $Res Function(_FavoriteFormState) _then;

/// Create a copy of FavoriteFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? mealType = freezed,Object? selectedTags = null,Object? photoPath = freezed,Object? isSaving = null,}) {
  return _then(_FavoriteFormState(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mealType: freezed == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as MealType?,selectedTags: null == selectedTags ? _self._selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<TagOption>,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
