// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_merge_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TagMergePreview {

 ManagedTag get source; ManagedTag get target; List<String> get favoriteNames;
/// Create a copy of TagMergePreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagMergePreviewCopyWith<TagMergePreview> get copyWith => _$TagMergePreviewCopyWithImpl<TagMergePreview>(this as TagMergePreview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TagMergePreview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagMergePreview&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.target, _this.target) || other.target == _this.target)&&const DeepCollectionEquality().equals(other.favoriteNames, _this.favoriteNames));
}


@override
int get hashCode {
  final _this = this as TagMergePreview;
  return Object.hash(runtimeType,_this.source,_this.target,const DeepCollectionEquality().hash(_this.favoriteNames));
}

@override
String toString() {
  final _this = this as TagMergePreview;
  return 'TagMergePreview(source: ${_this.source}, target: ${_this.target}, favoriteNames: ${_this.favoriteNames})';
}


}

/// @nodoc
abstract mixin class $TagMergePreviewCopyWith<$Res>  {
  factory $TagMergePreviewCopyWith(TagMergePreview value, $Res Function(TagMergePreview) _then) = _$TagMergePreviewCopyWithImpl;
@useResult
$Res call({
 ManagedTag source, ManagedTag target, List<String> favoriteNames
});


$ManagedTagCopyWith<$Res> get source;$ManagedTagCopyWith<$Res> get target;

}
/// @nodoc
class _$TagMergePreviewCopyWithImpl<$Res>
    implements $TagMergePreviewCopyWith<$Res> {
  _$TagMergePreviewCopyWithImpl(this._self, this._then);

  final TagMergePreview _self;
  final $Res Function(TagMergePreview) _then;

/// Create a copy of TagMergePreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? target = null,Object? favoriteNames = null,}) {
  return _then(TagMergePreview(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ManagedTag,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as ManagedTag,favoriteNames: null == favoriteNames ? _self.favoriteNames : favoriteNames // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of TagMergePreview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManagedTagCopyWith<$Res> get source {
  
  return $ManagedTagCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of TagMergePreview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManagedTagCopyWith<$Res> get target {
  
  return $ManagedTagCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}


/// Adds pattern-matching-related methods to [TagMergePreview].
extension TagMergePreviewPatterns on TagMergePreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagMergePreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagMergePreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagMergePreview value)  $default,){
final _that = this;
switch (_that) {
case _TagMergePreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagMergePreview value)?  $default,){
final _that = this;
switch (_that) {
case _TagMergePreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ManagedTag source,  ManagedTag target,  List<String> favoriteNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagMergePreview() when $default != null:
return $default(_that.source,_that.target,_that.favoriteNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ManagedTag source,  ManagedTag target,  List<String> favoriteNames)  $default,) {final _that = this;
switch (_that) {
case _TagMergePreview():
return $default(_that.source,_that.target,_that.favoriteNames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ManagedTag source,  ManagedTag target,  List<String> favoriteNames)?  $default,) {final _that = this;
switch (_that) {
case _TagMergePreview() when $default != null:
return $default(_that.source,_that.target,_that.favoriteNames);case _:
  return null;

}
}

}

/// @nodoc


class _TagMergePreview implements TagMergePreview {
  const _TagMergePreview({required this.source, required this.target, required  List<String> favoriteNames}): _favoriteNames = favoriteNames;
  

@override final  ManagedTag source;
@override final  ManagedTag target;
 final  List<String> _favoriteNames;
@override List<String> get favoriteNames {
  if (_favoriteNames is EqualUnmodifiableListView) return _favoriteNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteNames);
}


/// Create a copy of TagMergePreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagMergePreviewCopyWith<_TagMergePreview> get copyWith => __$TagMergePreviewCopyWithImpl<_TagMergePreview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagMergePreview&&(identical(other.source, source) || other.source == source)&&(identical(other.target, target) || other.target == target)&&const DeepCollectionEquality().equals(other.favoriteNames, _favoriteNames));
}


@override
int get hashCode {
    return Object.hash(runtimeType,source,target,const DeepCollectionEquality().hash(_favoriteNames));
}

@override
String toString() {
    return 'TagMergePreview(source: $source, target: $target, favoriteNames: $favoriteNames)';
}


}

/// @nodoc
abstract mixin class _$TagMergePreviewCopyWith<$Res> implements $TagMergePreviewCopyWith<$Res> {
  factory _$TagMergePreviewCopyWith(_TagMergePreview value, $Res Function(_TagMergePreview) _then) = __$TagMergePreviewCopyWithImpl;
@override @useResult
$Res call({
 ManagedTag source, ManagedTag target, List<String> favoriteNames
});


@override $ManagedTagCopyWith<$Res> get source;@override $ManagedTagCopyWith<$Res> get target;

}
/// @nodoc
class __$TagMergePreviewCopyWithImpl<$Res>
    implements _$TagMergePreviewCopyWith<$Res> {
  __$TagMergePreviewCopyWithImpl(this._self, this._then);

  final _TagMergePreview _self;
  final $Res Function(_TagMergePreview) _then;

/// Create a copy of TagMergePreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? target = null,Object? favoriteNames = null,}) {
  return _then(_TagMergePreview(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ManagedTag,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as ManagedTag,favoriteNames: null == favoriteNames ? _self._favoriteNames : favoriteNames // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of TagMergePreview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManagedTagCopyWith<$Res> get source {
  
  return $ManagedTagCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of TagMergePreview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManagedTagCopyWith<$Res> get target {
  
  return $ManagedTagCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}

// dart format on
