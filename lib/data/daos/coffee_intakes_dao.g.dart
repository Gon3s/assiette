// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_intakes_dao.dart';

// ignore_for_file: type=lint
mixin _$CoffeeIntakesDaoMixin on DatabaseAccessor<AppDatabase> {
  $CoffeeIntakesTable get coffeeIntakes => attachedDatabase.coffeeIntakes;
  CoffeeIntakesDaoManager get managers => CoffeeIntakesDaoManager(this);
}

class CoffeeIntakesDaoManager {
  final _$CoffeeIntakesDaoMixin _db;
  CoffeeIntakesDaoManager(this._db);
  $$CoffeeIntakesTableTableManager get coffeeIntakes =>
      $$CoffeeIntakesTableTableManager(_db.attachedDatabase, _db.coffeeIntakes);
}
