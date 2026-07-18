// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_journal_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalMealEntry {

 DateTime get timestamp; MealType get mealType; List<String> get tagLabels; String? get note;
/// Create a copy of JournalMealEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalMealEntryCopyWith<JournalMealEntry> get copyWith => _$JournalMealEntryCopyWithImpl<JournalMealEntry>(this as JournalMealEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalMealEntry&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&const DeepCollectionEquality().equals(other.tagLabels, tagLabels)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,mealType,const DeepCollectionEquality().hash(tagLabels),note);

@override
String toString() {
  return 'JournalMealEntry(timestamp: $timestamp, mealType: $mealType, tagLabels: $tagLabels, note: $note)';
}


}

/// @nodoc
abstract mixin class $JournalMealEntryCopyWith<$Res>  {
  factory $JournalMealEntryCopyWith(JournalMealEntry value, $Res Function(JournalMealEntry) _then) = _$JournalMealEntryCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, MealType mealType, List<String> tagLabels, String? note
});




}
/// @nodoc
class _$JournalMealEntryCopyWithImpl<$Res>
    implements $JournalMealEntryCopyWith<$Res> {
  _$JournalMealEntryCopyWithImpl(this._self, this._then);

  final JournalMealEntry _self;
  final $Res Function(JournalMealEntry) _then;

/// Create a copy of JournalMealEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? mealType = null,Object? tagLabels = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as MealType,tagLabels: null == tagLabels ? _self.tagLabels : tagLabels // ignore: cast_nullable_to_non_nullable
as List<String>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalMealEntry].
extension JournalMealEntryPatterns on JournalMealEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalMealEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalMealEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalMealEntry value)  $default,){
final _that = this;
switch (_that) {
case _JournalMealEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalMealEntry value)?  $default,){
final _that = this;
switch (_that) {
case _JournalMealEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  MealType mealType,  List<String> tagLabels,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalMealEntry() when $default != null:
return $default(_that.timestamp,_that.mealType,_that.tagLabels,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  MealType mealType,  List<String> tagLabels,  String? note)  $default,) {final _that = this;
switch (_that) {
case _JournalMealEntry():
return $default(_that.timestamp,_that.mealType,_that.tagLabels,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  MealType mealType,  List<String> tagLabels,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _JournalMealEntry() when $default != null:
return $default(_that.timestamp,_that.mealType,_that.tagLabels,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _JournalMealEntry implements JournalMealEntry {
  const _JournalMealEntry({required this.timestamp, required this.mealType, required final  List<String> tagLabels, this.note}): _tagLabels = tagLabels;
  

@override final  DateTime timestamp;
@override final  MealType mealType;
 final  List<String> _tagLabels;
@override List<String> get tagLabels {
  if (_tagLabels is EqualUnmodifiableListView) return _tagLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagLabels);
}

@override final  String? note;

/// Create a copy of JournalMealEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalMealEntryCopyWith<_JournalMealEntry> get copyWith => __$JournalMealEntryCopyWithImpl<_JournalMealEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalMealEntry&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&const DeepCollectionEquality().equals(other._tagLabels, _tagLabels)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,mealType,const DeepCollectionEquality().hash(_tagLabels),note);

@override
String toString() {
  return 'JournalMealEntry(timestamp: $timestamp, mealType: $mealType, tagLabels: $tagLabels, note: $note)';
}


}

/// @nodoc
abstract mixin class _$JournalMealEntryCopyWith<$Res> implements $JournalMealEntryCopyWith<$Res> {
  factory _$JournalMealEntryCopyWith(_JournalMealEntry value, $Res Function(_JournalMealEntry) _then) = __$JournalMealEntryCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, MealType mealType, List<String> tagLabels, String? note
});




}
/// @nodoc
class __$JournalMealEntryCopyWithImpl<$Res>
    implements _$JournalMealEntryCopyWith<$Res> {
  __$JournalMealEntryCopyWithImpl(this._self, this._then);

  final _JournalMealEntry _self;
  final $Res Function(_JournalMealEntry) _then;

/// Create a copy of JournalMealEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? mealType = null,Object? tagLabels = null,Object? note = freezed,}) {
  return _then(_JournalMealEntry(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as MealType,tagLabels: null == tagLabels ? _self._tagLabels : tagLabels // ignore: cast_nullable_to_non_nullable
as List<String>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$JournalSymptomEntry {

 DateTime get timestamp; SymptomType get symptomType; int get intensity; String? get detail; String? get note;
/// Create a copy of JournalSymptomEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalSymptomEntryCopyWith<JournalSymptomEntry> get copyWith => _$JournalSymptomEntryCopyWithImpl<JournalSymptomEntry>(this as JournalSymptomEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalSymptomEntry&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.symptomType, symptomType) || other.symptomType == symptomType)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,symptomType,intensity,detail,note);

@override
String toString() {
  return 'JournalSymptomEntry(timestamp: $timestamp, symptomType: $symptomType, intensity: $intensity, detail: $detail, note: $note)';
}


}

/// @nodoc
abstract mixin class $JournalSymptomEntryCopyWith<$Res>  {
  factory $JournalSymptomEntryCopyWith(JournalSymptomEntry value, $Res Function(JournalSymptomEntry) _then) = _$JournalSymptomEntryCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, SymptomType symptomType, int intensity, String? detail, String? note
});




}
/// @nodoc
class _$JournalSymptomEntryCopyWithImpl<$Res>
    implements $JournalSymptomEntryCopyWith<$Res> {
  _$JournalSymptomEntryCopyWithImpl(this._self, this._then);

  final JournalSymptomEntry _self;
  final $Res Function(JournalSymptomEntry) _then;

/// Create a copy of JournalSymptomEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? symptomType = null,Object? intensity = null,Object? detail = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,symptomType: null == symptomType ? _self.symptomType : symptomType // ignore: cast_nullable_to_non_nullable
as SymptomType,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalSymptomEntry].
extension JournalSymptomEntryPatterns on JournalSymptomEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalSymptomEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalSymptomEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalSymptomEntry value)  $default,){
final _that = this;
switch (_that) {
case _JournalSymptomEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalSymptomEntry value)?  $default,){
final _that = this;
switch (_that) {
case _JournalSymptomEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  SymptomType symptomType,  int intensity,  String? detail,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalSymptomEntry() when $default != null:
return $default(_that.timestamp,_that.symptomType,_that.intensity,_that.detail,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  SymptomType symptomType,  int intensity,  String? detail,  String? note)  $default,) {final _that = this;
switch (_that) {
case _JournalSymptomEntry():
return $default(_that.timestamp,_that.symptomType,_that.intensity,_that.detail,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  SymptomType symptomType,  int intensity,  String? detail,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _JournalSymptomEntry() when $default != null:
return $default(_that.timestamp,_that.symptomType,_that.intensity,_that.detail,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _JournalSymptomEntry implements JournalSymptomEntry {
  const _JournalSymptomEntry({required this.timestamp, required this.symptomType, required this.intensity, this.detail, this.note});
  

@override final  DateTime timestamp;
@override final  SymptomType symptomType;
@override final  int intensity;
@override final  String? detail;
@override final  String? note;

/// Create a copy of JournalSymptomEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalSymptomEntryCopyWith<_JournalSymptomEntry> get copyWith => __$JournalSymptomEntryCopyWithImpl<_JournalSymptomEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalSymptomEntry&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.symptomType, symptomType) || other.symptomType == symptomType)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,symptomType,intensity,detail,note);

@override
String toString() {
  return 'JournalSymptomEntry(timestamp: $timestamp, symptomType: $symptomType, intensity: $intensity, detail: $detail, note: $note)';
}


}

/// @nodoc
abstract mixin class _$JournalSymptomEntryCopyWith<$Res> implements $JournalSymptomEntryCopyWith<$Res> {
  factory _$JournalSymptomEntryCopyWith(_JournalSymptomEntry value, $Res Function(_JournalSymptomEntry) _then) = __$JournalSymptomEntryCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, SymptomType symptomType, int intensity, String? detail, String? note
});




}
/// @nodoc
class __$JournalSymptomEntryCopyWithImpl<$Res>
    implements _$JournalSymptomEntryCopyWith<$Res> {
  __$JournalSymptomEntryCopyWithImpl(this._self, this._then);

  final _JournalSymptomEntry _self;
  final $Res Function(_JournalSymptomEntry) _then;

/// Create a copy of JournalSymptomEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? symptomType = null,Object? intensity = null,Object? detail = freezed,Object? note = freezed,}) {
  return _then(_JournalSymptomEntry(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,symptomType: null == symptomType ? _self.symptomType : symptomType // ignore: cast_nullable_to_non_nullable
as SymptomType,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$DayJournalEntry {

 DateTime get date; List<JournalMealEntry> get meals; List<JournalSymptomEntry> get symptoms; SleepSummary? get sleep; WeatherSummary? get weather;
/// Create a copy of DayJournalEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayJournalEntryCopyWith<DayJournalEntry> get copyWith => _$DayJournalEntryCopyWithImpl<DayJournalEntry>(this as DayJournalEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayJournalEntry&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.meals, meals)&&const DeepCollectionEquality().equals(other.symptoms, symptoms)&&(identical(other.sleep, sleep) || other.sleep == sleep)&&(identical(other.weather, weather) || other.weather == weather));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(meals),const DeepCollectionEquality().hash(symptoms),sleep,weather);

@override
String toString() {
  return 'DayJournalEntry(date: $date, meals: $meals, symptoms: $symptoms, sleep: $sleep, weather: $weather)';
}


}

/// @nodoc
abstract mixin class $DayJournalEntryCopyWith<$Res>  {
  factory $DayJournalEntryCopyWith(DayJournalEntry value, $Res Function(DayJournalEntry) _then) = _$DayJournalEntryCopyWithImpl;
@useResult
$Res call({
 DateTime date, List<JournalMealEntry> meals, List<JournalSymptomEntry> symptoms, SleepSummary? sleep, WeatherSummary? weather
});


$SleepSummaryCopyWith<$Res>? get sleep;$WeatherSummaryCopyWith<$Res>? get weather;

}
/// @nodoc
class _$DayJournalEntryCopyWithImpl<$Res>
    implements $DayJournalEntryCopyWith<$Res> {
  _$DayJournalEntryCopyWithImpl(this._self, this._then);

  final DayJournalEntry _self;
  final $Res Function(DayJournalEntry) _then;

/// Create a copy of DayJournalEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? meals = null,Object? symptoms = null,Object? sleep = freezed,Object? weather = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,meals: null == meals ? _self.meals : meals // ignore: cast_nullable_to_non_nullable
as List<JournalMealEntry>,symptoms: null == symptoms ? _self.symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as List<JournalSymptomEntry>,sleep: freezed == sleep ? _self.sleep : sleep // ignore: cast_nullable_to_non_nullable
as SleepSummary?,weather: freezed == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as WeatherSummary?,
  ));
}
/// Create a copy of DayJournalEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SleepSummaryCopyWith<$Res>? get sleep {
    if (_self.sleep == null) {
    return null;
  }

  return $SleepSummaryCopyWith<$Res>(_self.sleep!, (value) {
    return _then(_self.copyWith(sleep: value));
  });
}/// Create a copy of DayJournalEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherSummaryCopyWith<$Res>? get weather {
    if (_self.weather == null) {
    return null;
  }

  return $WeatherSummaryCopyWith<$Res>(_self.weather!, (value) {
    return _then(_self.copyWith(weather: value));
  });
}
}


/// Adds pattern-matching-related methods to [DayJournalEntry].
extension DayJournalEntryPatterns on DayJournalEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayJournalEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayJournalEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayJournalEntry value)  $default,){
final _that = this;
switch (_that) {
case _DayJournalEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayJournalEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DayJournalEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  List<JournalMealEntry> meals,  List<JournalSymptomEntry> symptoms,  SleepSummary? sleep,  WeatherSummary? weather)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayJournalEntry() when $default != null:
return $default(_that.date,_that.meals,_that.symptoms,_that.sleep,_that.weather);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  List<JournalMealEntry> meals,  List<JournalSymptomEntry> symptoms,  SleepSummary? sleep,  WeatherSummary? weather)  $default,) {final _that = this;
switch (_that) {
case _DayJournalEntry():
return $default(_that.date,_that.meals,_that.symptoms,_that.sleep,_that.weather);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  List<JournalMealEntry> meals,  List<JournalSymptomEntry> symptoms,  SleepSummary? sleep,  WeatherSummary? weather)?  $default,) {final _that = this;
switch (_that) {
case _DayJournalEntry() when $default != null:
return $default(_that.date,_that.meals,_that.symptoms,_that.sleep,_that.weather);case _:
  return null;

}
}

}

/// @nodoc


class _DayJournalEntry extends DayJournalEntry {
  const _DayJournalEntry({required this.date, required final  List<JournalMealEntry> meals, required final  List<JournalSymptomEntry> symptoms, this.sleep, this.weather}): _meals = meals,_symptoms = symptoms,super._();
  

@override final  DateTime date;
 final  List<JournalMealEntry> _meals;
@override List<JournalMealEntry> get meals {
  if (_meals is EqualUnmodifiableListView) return _meals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meals);
}

 final  List<JournalSymptomEntry> _symptoms;
@override List<JournalSymptomEntry> get symptoms {
  if (_symptoms is EqualUnmodifiableListView) return _symptoms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_symptoms);
}

@override final  SleepSummary? sleep;
@override final  WeatherSummary? weather;

/// Create a copy of DayJournalEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayJournalEntryCopyWith<_DayJournalEntry> get copyWith => __$DayJournalEntryCopyWithImpl<_DayJournalEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayJournalEntry&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._meals, _meals)&&const DeepCollectionEquality().equals(other._symptoms, _symptoms)&&(identical(other.sleep, sleep) || other.sleep == sleep)&&(identical(other.weather, weather) || other.weather == weather));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_meals),const DeepCollectionEquality().hash(_symptoms),sleep,weather);

@override
String toString() {
  return 'DayJournalEntry(date: $date, meals: $meals, symptoms: $symptoms, sleep: $sleep, weather: $weather)';
}


}

/// @nodoc
abstract mixin class _$DayJournalEntryCopyWith<$Res> implements $DayJournalEntryCopyWith<$Res> {
  factory _$DayJournalEntryCopyWith(_DayJournalEntry value, $Res Function(_DayJournalEntry) _then) = __$DayJournalEntryCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, List<JournalMealEntry> meals, List<JournalSymptomEntry> symptoms, SleepSummary? sleep, WeatherSummary? weather
});


@override $SleepSummaryCopyWith<$Res>? get sleep;@override $WeatherSummaryCopyWith<$Res>? get weather;

}
/// @nodoc
class __$DayJournalEntryCopyWithImpl<$Res>
    implements _$DayJournalEntryCopyWith<$Res> {
  __$DayJournalEntryCopyWithImpl(this._self, this._then);

  final _DayJournalEntry _self;
  final $Res Function(_DayJournalEntry) _then;

/// Create a copy of DayJournalEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? meals = null,Object? symptoms = null,Object? sleep = freezed,Object? weather = freezed,}) {
  return _then(_DayJournalEntry(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,meals: null == meals ? _self._meals : meals // ignore: cast_nullable_to_non_nullable
as List<JournalMealEntry>,symptoms: null == symptoms ? _self._symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as List<JournalSymptomEntry>,sleep: freezed == sleep ? _self.sleep : sleep // ignore: cast_nullable_to_non_nullable
as SleepSummary?,weather: freezed == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as WeatherSummary?,
  ));
}

/// Create a copy of DayJournalEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SleepSummaryCopyWith<$Res>? get sleep {
    if (_self.sleep == null) {
    return null;
  }

  return $SleepSummaryCopyWith<$Res>(_self.sleep!, (value) {
    return _then(_self.copyWith(sleep: value));
  });
}/// Create a copy of DayJournalEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherSummaryCopyWith<$Res>? get weather {
    if (_self.weather == null) {
    return null;
  }

  return $WeatherSummaryCopyWith<$Res>(_self.weather!, (value) {
    return _then(_self.copyWith(weather: value));
  });
}
}

// dart format on
