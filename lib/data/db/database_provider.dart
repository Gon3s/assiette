// Riverpod provider for the Drift database singleton.
// ignore_for_file: public_member_api_docs
import 'package:assiette/data/db/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
