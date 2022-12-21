import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Task, Todos],
  // include: {'tables.drift'},
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<TaskData>> getTask() async {
    return await select(task).get();
  }

  Future<int> saveTask(TaskData companion) async {
    return await into(task).insertOnConflictUpdate(companion);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}

class Task extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().nullable().named('body')();
  IntColumn get timeSpent => integer().nullable()();
  IntColumn get priority => integer()();
}

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().nullable()();
}
