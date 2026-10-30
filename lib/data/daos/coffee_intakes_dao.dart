import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/coffee_intakes_table.dart';
import 'package:drift/drift.dart';

part 'coffee_intakes_dao.g.dart';

@DriftAccessor(tables: [CoffeeIntakes])
class CoffeeIntakesDao extends DatabaseAccessor<AppDatabase>
    with _$CoffeeIntakesDaoMixin {
  CoffeeIntakesDao(super.attachedDatabase);

  SimpleSelectStatement<CoffeeIntakes, CoffeeIntake> _range(
    DateTime start,
    DateTime end,
  ) => select(coffeeIntakes)
    ..where(
      (t) =>
          t.deletedAt.isNull() &
          t.timestamp.isBiggerOrEqualValue(start.toUtc()) &
          t.timestamp.isSmallerThanValue(end.toUtc()),
    )
    ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]);

  Stream<List<CoffeeIntake>> watchByDay(DateTime day) => _range(
    DateTime(day.year, day.month, day.day),
    DateTime(day.year, day.month, day.day + 1),
  ).watch();

  Future<List<CoffeeIntake>> getRange(DateTime start, DateTime end) =>
      _range(start, end).get();

  Future<void> save(CoffeeIntakesCompanion entry) =>
      into(coffeeIntakes).insertOnConflictUpdate(entry);

  Future<void> setDeleted(String id, {required bool deleted}) =>
      (update(coffeeIntakes)..where((t) => t.id.equals(id))).write(
        CoffeeIntakesCompanion(
          deletedAt: Value(deleted ? DateTime.now().toUtc() : null),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
}
