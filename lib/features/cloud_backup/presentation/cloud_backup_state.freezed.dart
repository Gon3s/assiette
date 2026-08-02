// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cloud_backup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CloudBackupState {

/// Email of the signed-in Google account, or `null` if signed out.
 String? get signedInEmail;/// Whether a sign-in/out, backup, or restore is currently running.
 bool get isBusy;
/// Create a copy of CloudBackupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CloudBackupStateCopyWith<CloudBackupState> get copyWith => _$CloudBackupStateCopyWithImpl<CloudBackupState>(this as CloudBackupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CloudBackupState&&(identical(other.signedInEmail, signedInEmail) || other.signedInEmail == signedInEmail)&&(identical(other.isBusy, isBusy) || other.isBusy == isBusy));
}


@override
int get hashCode => Object.hash(runtimeType,signedInEmail,isBusy);

@override
String toString() {
  return 'CloudBackupState(signedInEmail: $signedInEmail, isBusy: $isBusy)';
}


}

/// @nodoc
abstract mixin class $CloudBackupStateCopyWith<$Res>  {
  factory $CloudBackupStateCopyWith(CloudBackupState value, $Res Function(CloudBackupState) _then) = _$CloudBackupStateCopyWithImpl;
@useResult
$Res call({
 String? signedInEmail, bool isBusy
});




}
/// @nodoc
class _$CloudBackupStateCopyWithImpl<$Res>
    implements $CloudBackupStateCopyWith<$Res> {
  _$CloudBackupStateCopyWithImpl(this._self, this._then);

  final CloudBackupState _self;
  final $Res Function(CloudBackupState) _then;

/// Create a copy of CloudBackupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signedInEmail = freezed,Object? isBusy = null,}) {
  return _then(_self.copyWith(
signedInEmail: freezed == signedInEmail ? _self.signedInEmail : signedInEmail // ignore: cast_nullable_to_non_nullable
as String?,isBusy: null == isBusy ? _self.isBusy : isBusy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CloudBackupState].
extension CloudBackupStatePatterns on CloudBackupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CloudBackupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CloudBackupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CloudBackupState value)  $default,){
final _that = this;
switch (_that) {
case _CloudBackupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CloudBackupState value)?  $default,){
final _that = this;
switch (_that) {
case _CloudBackupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? signedInEmail,  bool isBusy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CloudBackupState() when $default != null:
return $default(_that.signedInEmail,_that.isBusy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? signedInEmail,  bool isBusy)  $default,) {final _that = this;
switch (_that) {
case _CloudBackupState():
return $default(_that.signedInEmail,_that.isBusy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? signedInEmail,  bool isBusy)?  $default,) {final _that = this;
switch (_that) {
case _CloudBackupState() when $default != null:
return $default(_that.signedInEmail,_that.isBusy);case _:
  return null;

}
}

}

/// @nodoc


class _CloudBackupState implements CloudBackupState {
  const _CloudBackupState({this.signedInEmail, this.isBusy = false});
  

/// Email of the signed-in Google account, or `null` if signed out.
@override final  String? signedInEmail;
/// Whether a sign-in/out, backup, or restore is currently running.
@override@JsonKey() final  bool isBusy;

/// Create a copy of CloudBackupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CloudBackupStateCopyWith<_CloudBackupState> get copyWith => __$CloudBackupStateCopyWithImpl<_CloudBackupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CloudBackupState&&(identical(other.signedInEmail, signedInEmail) || other.signedInEmail == signedInEmail)&&(identical(other.isBusy, isBusy) || other.isBusy == isBusy));
}


@override
int get hashCode => Object.hash(runtimeType,signedInEmail,isBusy);

@override
String toString() {
  return 'CloudBackupState(signedInEmail: $signedInEmail, isBusy: $isBusy)';
}


}

/// @nodoc
abstract mixin class _$CloudBackupStateCopyWith<$Res> implements $CloudBackupStateCopyWith<$Res> {
  factory _$CloudBackupStateCopyWith(_CloudBackupState value, $Res Function(_CloudBackupState) _then) = __$CloudBackupStateCopyWithImpl;
@override @useResult
$Res call({
 String? signedInEmail, bool isBusy
});




}
/// @nodoc
class __$CloudBackupStateCopyWithImpl<$Res>
    implements _$CloudBackupStateCopyWith<$Res> {
  __$CloudBackupStateCopyWithImpl(this._self, this._then);

  final _CloudBackupState _self;
  final $Res Function(_CloudBackupState) _then;

/// Create a copy of CloudBackupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signedInEmail = freezed,Object? isBusy = null,}) {
  return _then(_CloudBackupState(
signedInEmail: freezed == signedInEmail ? _self.signedInEmail : signedInEmail // ignore: cast_nullable_to_non_nullable
as String?,isBusy: null == isBusy ? _self.isBusy : isBusy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
