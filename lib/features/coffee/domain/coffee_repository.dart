import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/coffee/data/drift_coffee_repository.dart';
import 'package:assiette/features/coffee/domain/coffee_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coffee_repository.g.dart';

abstract class CoffeeRepository {
  Stream<List<CoffeeEntry>> watchDay(DateTime day);
  Future<String> add(DateTime timestamp);
  Future<void> update(CoffeeEntry entry);
  Future<void> setDeleted(String id, {required bool deleted});
}

@riverpod
CoffeeRepository coffeeRepository(Ref ref) =>
    DriftCoffeeRepository(ref.watch(appDatabaseProvider).coffeeIntakesDao);

@riverpod
Stream<List<CoffeeEntry>> coffeeDay(Ref ref, DateTime day) =>
    ref.watch(coffeeRepositoryProvider).watchDay(day);
