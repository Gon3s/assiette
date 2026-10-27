// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'migraine_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MigraineHistoryEntry {

 SymptomDraft get migraine; List<MigraineHistoryIntake> get intakes;
/// Create a copy of MigraineHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigraineHistoryEntryCopyWith<MigraineHistoryEntry> get copyWith => _$MigraineHistoryEntryCopyWithImpl<MigraineHistoryEntry>(this as MigraineHistoryEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MigraineHistoryEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigraineHistoryEntry&&(identical(other.migraine, _this.migraine) || other.migraine == _this.migraine)&&const DeepCollectionEquality().equals(other.intakes, _this.intakes));
}


@override
int get hashCode {
  final _this = this as MigraineHistoryEntry;
  return Object.hash(runtimeType,_this.migraine,const DeepCollectionEquality().hash(_this.intakes));
}

@override
String toString() {
  final _this = this as MigraineHistoryEntry;
  return 'MigraineHistoryEntry(migraine: ${_this.migraine}, intakes: ${_this.intakes})';
}


}

/// @nodoc
abstract mixin class $MigraineHistoryEntryCopyWith<$Res>  {
  factory $MigraineHistoryEntryCopyWith(MigraineHistoryEntry value, $Res Function(MigraineHistoryEntry) _then) = _$MigraineHistoryEntryCopyWithImpl;
@useResult
$Res call({
 SymptomDraft migraine, List<MigraineHistoryIntake> intakes
});


$SymptomDraftCopyWith<$Res> get migraine;

}
/// @nodoc
class _$MigraineHistoryEntryCopyWithImpl<$Res>
    implements $MigraineHistoryEntryCopyWith<$Res> {
  _$MigraineHistoryEntryCopyWithImpl(this._self, this._then);

  final MigraineHistoryEntry _self;
  final $Res Function(MigraineHistoryEntry) _then;

/// Create a copy of MigraineHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? migraine = null,Object? intakes = null,}) {
  return _then(MigraineHistoryEntry(
migraine: null == migraine ? _self.migraine : migraine // ignore: cast_nullable_to_non_nullable
as SymptomDraft,intakes: null == intakes ? _self.intakes : intakes // ignore: cast_nullable_to_non_nullable
as List<MigraineHistoryIntake>,
  ));
}
/// Create a copy of MigraineHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SymptomDraftCopyWith<$Res> get migraine {
  
  return $SymptomDraftCopyWith<$Res>(_self.migraine, (value) {
    return _then(_self.copyWith(migraine: value));
  });
}
}


/// Adds pattern-matching-related methods to [MigraineHistoryEntry].
extension MigraineHistoryEntryPatterns on MigraineHistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigraineHistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigraineHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigraineHistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _MigraineHistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigraineHistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _MigraineHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SymptomDraft migraine,  List<MigraineHistoryIntake> intakes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigraineHistoryEntry() when $default != null:
return $default(_that.migraine,_that.intakes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SymptomDraft migraine,  List<MigraineHistoryIntake> intakes)  $default,) {final _that = this;
switch (_that) {
case _MigraineHistoryEntry():
return $default(_that.migraine,_that.intakes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SymptomDraft migraine,  List<MigraineHistoryIntake> intakes)?  $default,) {final _that = this;
switch (_that) {
case _MigraineHistoryEntry() when $default != null:
return $default(_that.migraine,_that.intakes);case _:
  return null;

}
}

}

/// @nodoc


class _MigraineHistoryEntry implements MigraineHistoryEntry {
  const _MigraineHistoryEntry({required this.migraine, required  List<MigraineHistoryIntake> intakes}): _intakes = intakes;
  

@override final  SymptomDraft migraine;
 final  List<MigraineHistoryIntake> _intakes;
@override List<MigraineHistoryIntake> get intakes {
  if (_intakes is EqualUnmodifiableListView) return _intakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_intakes);
}


/// Create a copy of MigraineHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigraineHistoryEntryCopyWith<_MigraineHistoryEntry> get copyWith => __$MigraineHistoryEntryCopyWithImpl<_MigraineHistoryEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigraineHistoryEntry&&(identical(other.migraine, migraine) || other.migraine == migraine)&&const DeepCollectionEquality().equals(other.intakes, _intakes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,migraine,const DeepCollectionEquality().hash(_intakes));
}

@override
String toString() {
    return 'MigraineHistoryEntry(migraine: $migraine, intakes: $intakes)';
}


}

/// @nodoc
abstract mixin class _$MigraineHistoryEntryCopyWith<$Res> implements $MigraineHistoryEntryCopyWith<$Res> {
  factory _$MigraineHistoryEntryCopyWith(_MigraineHistoryEntry value, $Res Function(_MigraineHistoryEntry) _then) = __$MigraineHistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 SymptomDraft migraine, List<MigraineHistoryIntake> intakes
});


@override $SymptomDraftCopyWith<$Res> get migraine;

}
/// @nodoc
class __$MigraineHistoryEntryCopyWithImpl<$Res>
    implements _$MigraineHistoryEntryCopyWith<$Res> {
  __$MigraineHistoryEntryCopyWithImpl(this._self, this._then);

  final _MigraineHistoryEntry _self;
  final $Res Function(_MigraineHistoryEntry) _then;

/// Create a copy of MigraineHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? migraine = null,Object? intakes = null,}) {
  return _then(_MigraineHistoryEntry(
migraine: null == migraine ? _self.migraine : migraine // ignore: cast_nullable_to_non_nullable
as SymptomDraft,intakes: null == intakes ? _self._intakes : intakes // ignore: cast_nullable_to_non_nullable
as List<MigraineHistoryIntake>,
  ));
}

/// Create a copy of MigraineHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SymptomDraftCopyWith<$Res> get migraine {
  
  return $SymptomDraftCopyWith<$Res>(_self.migraine, (value) {
    return _then(_self.copyWith(migraine: value));
  });
}
}

/// @nodoc
mixin _$MigraineHistoryIntake {

 String get id; String get name; DateTime get timestamp; String? get dose;
/// Create a copy of MigraineHistoryIntake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigraineHistoryIntakeCopyWith<MigraineHistoryIntake> get copyWith => _$MigraineHistoryIntakeCopyWithImpl<MigraineHistoryIntake>(this as MigraineHistoryIntake, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MigraineHistoryIntake;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigraineHistoryIntake&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.dose, _this.dose) || other.dose == _this.dose));
}


@override
int get hashCode {
  final _this = this as MigraineHistoryIntake;
  return Object.hash(runtimeType,_this.id,_this.name,_this.timestamp,_this.dose);
}

@override
String toString() {
  final _this = this as MigraineHistoryIntake;
  return 'MigraineHistoryIntake(id: ${_this.id}, name: ${_this.name}, timestamp: ${_this.timestamp}, dose: ${_this.dose})';
}


}

/// @nodoc
abstract mixin class $MigraineHistoryIntakeCopyWith<$Res>  {
  factory $MigraineHistoryIntakeCopyWith(MigraineHistoryIntake value, $Res Function(MigraineHistoryIntake) _then) = _$MigraineHistoryIntakeCopyWithImpl;
@useResult
$Res call({
 String id, String name, DateTime timestamp, String? dose
});




}
/// @nodoc
class _$MigraineHistoryIntakeCopyWithImpl<$Res>
    implements $MigraineHistoryIntakeCopyWith<$Res> {
  _$MigraineHistoryIntakeCopyWithImpl(this._self, this._then);

  final MigraineHistoryIntake _self;
  final $Res Function(MigraineHistoryIntake) _then;

/// Create a copy of MigraineHistoryIntake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? timestamp = null,Object? dose = freezed,}) {
  return _then(MigraineHistoryIntake(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,dose: freezed == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MigraineHistoryIntake].
extension MigraineHistoryIntakePatterns on MigraineHistoryIntake {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigraineHistoryIntake value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigraineHistoryIntake() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigraineHistoryIntake value)  $default,){
final _that = this;
switch (_that) {
case _MigraineHistoryIntake():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigraineHistoryIntake value)?  $default,){
final _that = this;
switch (_that) {
case _MigraineHistoryIntake() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DateTime timestamp,  String? dose)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigraineHistoryIntake() when $default != null:
return $default(_that.id,_that.name,_that.timestamp,_that.dose);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DateTime timestamp,  String? dose)  $default,) {final _that = this;
switch (_that) {
case _MigraineHistoryIntake():
return $default(_that.id,_that.name,_that.timestamp,_that.dose);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DateTime timestamp,  String? dose)?  $default,) {final _that = this;
switch (_that) {
case _MigraineHistoryIntake() when $default != null:
return $default(_that.id,_that.name,_that.timestamp,_that.dose);case _:
  return null;

}
}

}

/// @nodoc


class _MigraineHistoryIntake implements MigraineHistoryIntake {
  const _MigraineHistoryIntake({required this.id, required this.name, required this.timestamp, this.dose});
  

@override final  String id;
@override final  String name;
@override final  DateTime timestamp;
@override final  String? dose;

/// Create a copy of MigraineHistoryIntake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigraineHistoryIntakeCopyWith<_MigraineHistoryIntake> get copyWith => __$MigraineHistoryIntakeCopyWithImpl<_MigraineHistoryIntake>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigraineHistoryIntake&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.dose, dose) || other.dose == dose));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,timestamp,dose);
}

@override
String toString() {
    return 'MigraineHistoryIntake(id: $id, name: $name, timestamp: $timestamp, dose: $dose)';
}


}

/// @nodoc
abstract mixin class _$MigraineHistoryIntakeCopyWith<$Res> implements $MigraineHistoryIntakeCopyWith<$Res> {
  factory _$MigraineHistoryIntakeCopyWith(_MigraineHistoryIntake value, $Res Function(_MigraineHistoryIntake) _then) = __$MigraineHistoryIntakeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DateTime timestamp, String? dose
});




}
/// @nodoc
class __$MigraineHistoryIntakeCopyWithImpl<$Res>
    implements _$MigraineHistoryIntakeCopyWith<$Res> {
  __$MigraineHistoryIntakeCopyWithImpl(this._self, this._then);

  final _MigraineHistoryIntake _self;
  final $Res Function(_MigraineHistoryIntake) _then;

/// Create a copy of MigraineHistoryIntake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? timestamp = null,Object? dose = freezed,}) {
  return _then(_MigraineHistoryIntake(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,dose: freezed == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
