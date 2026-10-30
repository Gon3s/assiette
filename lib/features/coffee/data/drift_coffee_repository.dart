import 'package:assiette/data/daos/coffee_intakes_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/coffee/domain/coffee_entry.dart';
import 'package:assiette/features/coffee/domain/coffee_repository.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class DriftCoffeeRepository implements CoffeeRepository {
  DriftCoffeeRepository(this._dao);
  final CoffeeIntakesDao _dao;

  @override
  Stream<List<CoffeeEntry>> watchDay(DateTime day) => _dao
      .watchByDay(day)
      .map(
        (rows) => [
          for (final row in rows)
            CoffeeEntry(id: row.id, timestamp: row.timestamp),
        ],
      );

  @override
  Future<String> add(DateTime timestamp) async {
    final id = const Uuid().v4();
    await _dao.save(
      CoffeeIntakesCompanion.insert(
        id: id,
        timestamp: timestamp.toUtc(),
      ),
    );
    return id;
  }

  @override
  Future<void> update(CoffeeEntry entry) => _dao.save(
    CoffeeIntakesCompanion.insert(
      id: entry.id,
      timestamp: entry.timestamp.toUtc(),
      updatedAt: Value(DateTime.now().toUtc()),
    ),
  );

  @override
  Future<void> setDeleted(String id, {required bool deleted}) =>
      _dao.setDeleted(id, deleted: deleted);
}
