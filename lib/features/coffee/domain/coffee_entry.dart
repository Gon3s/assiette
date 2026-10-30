import 'package:freezed_annotation/freezed_annotation.dart';

part 'coffee_entry.freezed.dart';

@freezed
abstract class CoffeeEntry with _$CoffeeEntry {
  const factory CoffeeEntry({
    required String id,
    required DateTime timestamp,
  }) = _CoffeeEntry;
}
