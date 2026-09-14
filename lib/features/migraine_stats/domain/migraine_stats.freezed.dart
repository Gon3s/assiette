// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'migraine_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MigraineStats {

 DateTime get start; DateTime get end; int get migraineCount; int get migraineDays; Duration? get averageDuration; double? get averageMaximumIntensity; int get medicationIntakeCount; int get medicationDays; List<MigraineFrequencyBucket> get frequency; List<MedicationStats> get medications;
/// Create a copy of MigraineStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigraineStatsCopyWith<MigraineStats> get copyWith => _$MigraineStatsCopyWithImpl<MigraineStats>(this as MigraineStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigraineStats&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.migraineCount, migraineCount) || other.migraineCount == migraineCount)&&(identical(other.migraineDays, migraineDays) || other.migraineDays == migraineDays)&&(identical(other.averageDuration, averageDuration) || other.averageDuration == averageDuration)&&(identical(other.averageMaximumIntensity, averageMaximumIntensity) || other.averageMaximumIntensity == averageMaximumIntensity)&&(identical(other.medicationIntakeCount, medicationIntakeCount) || other.medicationIntakeCount == medicationIntakeCount)&&(identical(other.medicationDays, medicationDays) || other.medicationDays == medicationDays)&&const DeepCollectionEquality().equals(other.frequency, frequency)&&const DeepCollectionEquality().equals(other.medications, medications));
}


@override
int get hashCode => Object.hash(runtimeType,start,end,migraineCount,migraineDays,averageDuration,averageMaximumIntensity,medicationIntakeCount,medicationDays,const DeepCollectionEquality().hash(frequency),const DeepCollectionEquality().hash(medications));

@override
String toString() {
  return 'MigraineStats(start: $start, end: $end, migraineCount: $migraineCount, migraineDays: $migraineDays, averageDuration: $averageDuration, averageMaximumIntensity: $averageMaximumIntensity, medicationIntakeCount: $medicationIntakeCount, medicationDays: $medicationDays, frequency: $frequency, medications: $medications)';
}


}

/// @nodoc
abstract mixin class $MigraineStatsCopyWith<$Res>  {
  factory $MigraineStatsCopyWith(MigraineStats value, $Res Function(MigraineStats) _then) = _$MigraineStatsCopyWithImpl;
@useResult
$Res call({
 DateTime start, DateTime end, int migraineCount, int migraineDays, Duration? averageDuration, double? averageMaximumIntensity, int medicationIntakeCount, int medicationDays, List<MigraineFrequencyBucket> frequency, List<MedicationStats> medications
});




}
/// @nodoc
class _$MigraineStatsCopyWithImpl<$Res>
    implements $MigraineStatsCopyWith<$Res> {
  _$MigraineStatsCopyWithImpl(this._self, this._then);

  final MigraineStats _self;
  final $Res Function(MigraineStats) _then;

/// Create a copy of MigraineStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,Object? migraineCount = null,Object? migraineDays = null,Object? averageDuration = freezed,Object? averageMaximumIntensity = freezed,Object? medicationIntakeCount = null,Object? medicationDays = null,Object? frequency = null,Object? medications = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,migraineCount: null == migraineCount ? _self.migraineCount : migraineCount // ignore: cast_nullable_to_non_nullable
as int,migraineDays: null == migraineDays ? _self.migraineDays : migraineDays // ignore: cast_nullable_to_non_nullable
as int,averageDuration: freezed == averageDuration ? _self.averageDuration : averageDuration // ignore: cast_nullable_to_non_nullable
as Duration?,averageMaximumIntensity: freezed == averageMaximumIntensity ? _self.averageMaximumIntensity : averageMaximumIntensity // ignore: cast_nullable_to_non_nullable
as double?,medicationIntakeCount: null == medicationIntakeCount ? _self.medicationIntakeCount : medicationIntakeCount // ignore: cast_nullable_to_non_nullable
as int,medicationDays: null == medicationDays ? _self.medicationDays : medicationDays // ignore: cast_nullable_to_non_nullable
as int,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as List<MigraineFrequencyBucket>,medications: null == medications ? _self.medications : medications // ignore: cast_nullable_to_non_nullable
as List<MedicationStats>,
  ));
}

}


/// Adds pattern-matching-related methods to [MigraineStats].
extension MigraineStatsPatterns on MigraineStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigraineStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigraineStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigraineStats value)  $default,){
final _that = this;
switch (_that) {
case _MigraineStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigraineStats value)?  $default,){
final _that = this;
switch (_that) {
case _MigraineStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime start,  DateTime end,  int migraineCount,  int migraineDays,  Duration? averageDuration,  double? averageMaximumIntensity,  int medicationIntakeCount,  int medicationDays,  List<MigraineFrequencyBucket> frequency,  List<MedicationStats> medications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigraineStats() when $default != null:
return $default(_that.start,_that.end,_that.migraineCount,_that.migraineDays,_that.averageDuration,_that.averageMaximumIntensity,_that.medicationIntakeCount,_that.medicationDays,_that.frequency,_that.medications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime start,  DateTime end,  int migraineCount,  int migraineDays,  Duration? averageDuration,  double? averageMaximumIntensity,  int medicationIntakeCount,  int medicationDays,  List<MigraineFrequencyBucket> frequency,  List<MedicationStats> medications)  $default,) {final _that = this;
switch (_that) {
case _MigraineStats():
return $default(_that.start,_that.end,_that.migraineCount,_that.migraineDays,_that.averageDuration,_that.averageMaximumIntensity,_that.medicationIntakeCount,_that.medicationDays,_that.frequency,_that.medications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime start,  DateTime end,  int migraineCount,  int migraineDays,  Duration? averageDuration,  double? averageMaximumIntensity,  int medicationIntakeCount,  int medicationDays,  List<MigraineFrequencyBucket> frequency,  List<MedicationStats> medications)?  $default,) {final _that = this;
switch (_that) {
case _MigraineStats() when $default != null:
return $default(_that.start,_that.end,_that.migraineCount,_that.migraineDays,_that.averageDuration,_that.averageMaximumIntensity,_that.medicationIntakeCount,_that.medicationDays,_that.frequency,_that.medications);case _:
  return null;

}
}

}

/// @nodoc


class _MigraineStats implements MigraineStats {
  const _MigraineStats({required this.start, required this.end, required this.migraineCount, required this.migraineDays, required this.averageDuration, required this.averageMaximumIntensity, required this.medicationIntakeCount, required this.medicationDays, required final  List<MigraineFrequencyBucket> frequency, required final  List<MedicationStats> medications}): _frequency = frequency,_medications = medications;
  

@override final  DateTime start;
@override final  DateTime end;
@override final  int migraineCount;
@override final  int migraineDays;
@override final  Duration? averageDuration;
@override final  double? averageMaximumIntensity;
@override final  int medicationIntakeCount;
@override final  int medicationDays;
 final  List<MigraineFrequencyBucket> _frequency;
@override List<MigraineFrequencyBucket> get frequency {
  if (_frequency is EqualUnmodifiableListView) return _frequency;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_frequency);
}

 final  List<MedicationStats> _medications;
@override List<MedicationStats> get medications {
  if (_medications is EqualUnmodifiableListView) return _medications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medications);
}


/// Create a copy of MigraineStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigraineStatsCopyWith<_MigraineStats> get copyWith => __$MigraineStatsCopyWithImpl<_MigraineStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigraineStats&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.migraineCount, migraineCount) || other.migraineCount == migraineCount)&&(identical(other.migraineDays, migraineDays) || other.migraineDays == migraineDays)&&(identical(other.averageDuration, averageDuration) || other.averageDuration == averageDuration)&&(identical(other.averageMaximumIntensity, averageMaximumIntensity) || other.averageMaximumIntensity == averageMaximumIntensity)&&(identical(other.medicationIntakeCount, medicationIntakeCount) || other.medicationIntakeCount == medicationIntakeCount)&&(identical(other.medicationDays, medicationDays) || other.medicationDays == medicationDays)&&const DeepCollectionEquality().equals(other._frequency, _frequency)&&const DeepCollectionEquality().equals(other._medications, _medications));
}


@override
int get hashCode => Object.hash(runtimeType,start,end,migraineCount,migraineDays,averageDuration,averageMaximumIntensity,medicationIntakeCount,medicationDays,const DeepCollectionEquality().hash(_frequency),const DeepCollectionEquality().hash(_medications));

@override
String toString() {
  return 'MigraineStats(start: $start, end: $end, migraineCount: $migraineCount, migraineDays: $migraineDays, averageDuration: $averageDuration, averageMaximumIntensity: $averageMaximumIntensity, medicationIntakeCount: $medicationIntakeCount, medicationDays: $medicationDays, frequency: $frequency, medications: $medications)';
}


}

/// @nodoc
abstract mixin class _$MigraineStatsCopyWith<$Res> implements $MigraineStatsCopyWith<$Res> {
  factory _$MigraineStatsCopyWith(_MigraineStats value, $Res Function(_MigraineStats) _then) = __$MigraineStatsCopyWithImpl;
@override @useResult
$Res call({
 DateTime start, DateTime end, int migraineCount, int migraineDays, Duration? averageDuration, double? averageMaximumIntensity, int medicationIntakeCount, int medicationDays, List<MigraineFrequencyBucket> frequency, List<MedicationStats> medications
});




}
/// @nodoc
class __$MigraineStatsCopyWithImpl<$Res>
    implements _$MigraineStatsCopyWith<$Res> {
  __$MigraineStatsCopyWithImpl(this._self, this._then);

  final _MigraineStats _self;
  final $Res Function(_MigraineStats) _then;

/// Create a copy of MigraineStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? migraineCount = null,Object? migraineDays = null,Object? averageDuration = freezed,Object? averageMaximumIntensity = freezed,Object? medicationIntakeCount = null,Object? medicationDays = null,Object? frequency = null,Object? medications = null,}) {
  return _then(_MigraineStats(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,migraineCount: null == migraineCount ? _self.migraineCount : migraineCount // ignore: cast_nullable_to_non_nullable
as int,migraineDays: null == migraineDays ? _self.migraineDays : migraineDays // ignore: cast_nullable_to_non_nullable
as int,averageDuration: freezed == averageDuration ? _self.averageDuration : averageDuration // ignore: cast_nullable_to_non_nullable
as Duration?,averageMaximumIntensity: freezed == averageMaximumIntensity ? _self.averageMaximumIntensity : averageMaximumIntensity // ignore: cast_nullable_to_non_nullable
as double?,medicationIntakeCount: null == medicationIntakeCount ? _self.medicationIntakeCount : medicationIntakeCount // ignore: cast_nullable_to_non_nullable
as int,medicationDays: null == medicationDays ? _self.medicationDays : medicationDays // ignore: cast_nullable_to_non_nullable
as int,frequency: null == frequency ? _self._frequency : frequency // ignore: cast_nullable_to_non_nullable
as List<MigraineFrequencyBucket>,medications: null == medications ? _self._medications : medications // ignore: cast_nullable_to_non_nullable
as List<MedicationStats>,
  ));
}


}

/// @nodoc
mixin _$MigraineFrequencyBucket {

 DateTime get start; DateTime get end; int get count;
/// Create a copy of MigraineFrequencyBucket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigraineFrequencyBucketCopyWith<MigraineFrequencyBucket> get copyWith => _$MigraineFrequencyBucketCopyWithImpl<MigraineFrequencyBucket>(this as MigraineFrequencyBucket, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigraineFrequencyBucket&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,start,end,count);

@override
String toString() {
  return 'MigraineFrequencyBucket(start: $start, end: $end, count: $count)';
}


}

/// @nodoc
abstract mixin class $MigraineFrequencyBucketCopyWith<$Res>  {
  factory $MigraineFrequencyBucketCopyWith(MigraineFrequencyBucket value, $Res Function(MigraineFrequencyBucket) _then) = _$MigraineFrequencyBucketCopyWithImpl;
@useResult
$Res call({
 DateTime start, DateTime end, int count
});




}
/// @nodoc
class _$MigraineFrequencyBucketCopyWithImpl<$Res>
    implements $MigraineFrequencyBucketCopyWith<$Res> {
  _$MigraineFrequencyBucketCopyWithImpl(this._self, this._then);

  final MigraineFrequencyBucket _self;
  final $Res Function(MigraineFrequencyBucket) _then;

/// Create a copy of MigraineFrequencyBucket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,Object? count = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MigraineFrequencyBucket].
extension MigraineFrequencyBucketPatterns on MigraineFrequencyBucket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigraineFrequencyBucket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigraineFrequencyBucket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigraineFrequencyBucket value)  $default,){
final _that = this;
switch (_that) {
case _MigraineFrequencyBucket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigraineFrequencyBucket value)?  $default,){
final _that = this;
switch (_that) {
case _MigraineFrequencyBucket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime start,  DateTime end,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigraineFrequencyBucket() when $default != null:
return $default(_that.start,_that.end,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime start,  DateTime end,  int count)  $default,) {final _that = this;
switch (_that) {
case _MigraineFrequencyBucket():
return $default(_that.start,_that.end,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime start,  DateTime end,  int count)?  $default,) {final _that = this;
switch (_that) {
case _MigraineFrequencyBucket() when $default != null:
return $default(_that.start,_that.end,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _MigraineFrequencyBucket implements MigraineFrequencyBucket {
  const _MigraineFrequencyBucket({required this.start, required this.end, required this.count});
  

@override final  DateTime start;
@override final  DateTime end;
@override final  int count;

/// Create a copy of MigraineFrequencyBucket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigraineFrequencyBucketCopyWith<_MigraineFrequencyBucket> get copyWith => __$MigraineFrequencyBucketCopyWithImpl<_MigraineFrequencyBucket>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigraineFrequencyBucket&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,start,end,count);

@override
String toString() {
  return 'MigraineFrequencyBucket(start: $start, end: $end, count: $count)';
}


}

/// @nodoc
abstract mixin class _$MigraineFrequencyBucketCopyWith<$Res> implements $MigraineFrequencyBucketCopyWith<$Res> {
  factory _$MigraineFrequencyBucketCopyWith(_MigraineFrequencyBucket value, $Res Function(_MigraineFrequencyBucket) _then) = __$MigraineFrequencyBucketCopyWithImpl;
@override @useResult
$Res call({
 DateTime start, DateTime end, int count
});




}
/// @nodoc
class __$MigraineFrequencyBucketCopyWithImpl<$Res>
    implements _$MigraineFrequencyBucketCopyWith<$Res> {
  __$MigraineFrequencyBucketCopyWithImpl(this._self, this._then);

  final _MigraineFrequencyBucket _self;
  final $Res Function(_MigraineFrequencyBucket) _then;

/// Create a copy of MigraineFrequencyBucket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? count = null,}) {
  return _then(_MigraineFrequencyBucket(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$MedicationStats {

 String get name; int get intakeCount; int get linkedMigraineCount; Duration? get averageDelayAfterMigraineStart;
/// Create a copy of MedicationStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicationStatsCopyWith<MedicationStats> get copyWith => _$MedicationStatsCopyWithImpl<MedicationStats>(this as MedicationStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationStats&&(identical(other.name, name) || other.name == name)&&(identical(other.intakeCount, intakeCount) || other.intakeCount == intakeCount)&&(identical(other.linkedMigraineCount, linkedMigraineCount) || other.linkedMigraineCount == linkedMigraineCount)&&(identical(other.averageDelayAfterMigraineStart, averageDelayAfterMigraineStart) || other.averageDelayAfterMigraineStart == averageDelayAfterMigraineStart));
}


@override
int get hashCode => Object.hash(runtimeType,name,intakeCount,linkedMigraineCount,averageDelayAfterMigraineStart);

@override
String toString() {
  return 'MedicationStats(name: $name, intakeCount: $intakeCount, linkedMigraineCount: $linkedMigraineCount, averageDelayAfterMigraineStart: $averageDelayAfterMigraineStart)';
}


}

/// @nodoc
abstract mixin class $MedicationStatsCopyWith<$Res>  {
  factory $MedicationStatsCopyWith(MedicationStats value, $Res Function(MedicationStats) _then) = _$MedicationStatsCopyWithImpl;
@useResult
$Res call({
 String name, int intakeCount, int linkedMigraineCount, Duration? averageDelayAfterMigraineStart
});




}
/// @nodoc
class _$MedicationStatsCopyWithImpl<$Res>
    implements $MedicationStatsCopyWith<$Res> {
  _$MedicationStatsCopyWithImpl(this._self, this._then);

  final MedicationStats _self;
  final $Res Function(MedicationStats) _then;

/// Create a copy of MedicationStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? intakeCount = null,Object? linkedMigraineCount = null,Object? averageDelayAfterMigraineStart = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intakeCount: null == intakeCount ? _self.intakeCount : intakeCount // ignore: cast_nullable_to_non_nullable
as int,linkedMigraineCount: null == linkedMigraineCount ? _self.linkedMigraineCount : linkedMigraineCount // ignore: cast_nullable_to_non_nullable
as int,averageDelayAfterMigraineStart: freezed == averageDelayAfterMigraineStart ? _self.averageDelayAfterMigraineStart : averageDelayAfterMigraineStart // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [MedicationStats].
extension MedicationStatsPatterns on MedicationStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedicationStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedicationStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedicationStats value)  $default,){
final _that = this;
switch (_that) {
case _MedicationStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedicationStats value)?  $default,){
final _that = this;
switch (_that) {
case _MedicationStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int intakeCount,  int linkedMigraineCount,  Duration? averageDelayAfterMigraineStart)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedicationStats() when $default != null:
return $default(_that.name,_that.intakeCount,_that.linkedMigraineCount,_that.averageDelayAfterMigraineStart);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int intakeCount,  int linkedMigraineCount,  Duration? averageDelayAfterMigraineStart)  $default,) {final _that = this;
switch (_that) {
case _MedicationStats():
return $default(_that.name,_that.intakeCount,_that.linkedMigraineCount,_that.averageDelayAfterMigraineStart);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int intakeCount,  int linkedMigraineCount,  Duration? averageDelayAfterMigraineStart)?  $default,) {final _that = this;
switch (_that) {
case _MedicationStats() when $default != null:
return $default(_that.name,_that.intakeCount,_that.linkedMigraineCount,_that.averageDelayAfterMigraineStart);case _:
  return null;

}
}

}

/// @nodoc


class _MedicationStats implements MedicationStats {
  const _MedicationStats({required this.name, required this.intakeCount, required this.linkedMigraineCount, required this.averageDelayAfterMigraineStart});
  

@override final  String name;
@override final  int intakeCount;
@override final  int linkedMigraineCount;
@override final  Duration? averageDelayAfterMigraineStart;

/// Create a copy of MedicationStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicationStatsCopyWith<_MedicationStats> get copyWith => __$MedicationStatsCopyWithImpl<_MedicationStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicationStats&&(identical(other.name, name) || other.name == name)&&(identical(other.intakeCount, intakeCount) || other.intakeCount == intakeCount)&&(identical(other.linkedMigraineCount, linkedMigraineCount) || other.linkedMigraineCount == linkedMigraineCount)&&(identical(other.averageDelayAfterMigraineStart, averageDelayAfterMigraineStart) || other.averageDelayAfterMigraineStart == averageDelayAfterMigraineStart));
}


@override
int get hashCode => Object.hash(runtimeType,name,intakeCount,linkedMigraineCount,averageDelayAfterMigraineStart);

@override
String toString() {
  return 'MedicationStats(name: $name, intakeCount: $intakeCount, linkedMigraineCount: $linkedMigraineCount, averageDelayAfterMigraineStart: $averageDelayAfterMigraineStart)';
}


}

/// @nodoc
abstract mixin class _$MedicationStatsCopyWith<$Res> implements $MedicationStatsCopyWith<$Res> {
  factory _$MedicationStatsCopyWith(_MedicationStats value, $Res Function(_MedicationStats) _then) = __$MedicationStatsCopyWithImpl;
@override @useResult
$Res call({
 String name, int intakeCount, int linkedMigraineCount, Duration? averageDelayAfterMigraineStart
});




}
/// @nodoc
class __$MedicationStatsCopyWithImpl<$Res>
    implements _$MedicationStatsCopyWith<$Res> {
  __$MedicationStatsCopyWithImpl(this._self, this._then);

  final _MedicationStats _self;
  final $Res Function(_MedicationStats) _then;

/// Create a copy of MedicationStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? intakeCount = null,Object? linkedMigraineCount = null,Object? averageDelayAfterMigraineStart = freezed,}) {
  return _then(_MedicationStats(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intakeCount: null == intakeCount ? _self.intakeCount : intakeCount // ignore: cast_nullable_to_non_nullable
as int,linkedMigraineCount: null == linkedMigraineCount ? _self.linkedMigraineCount : linkedMigraineCount // ignore: cast_nullable_to_non_nullable
as int,averageDelayAfterMigraineStart: freezed == averageDelayAfterMigraineStart ? _self.averageDelayAfterMigraineStart : averageDelayAfterMigraineStart // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on
