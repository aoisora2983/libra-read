import 'dart:io';

import 'package:drift/drift.dart';
import 'package:libra_read/model/database/daos/books_dao.dart';
import 'package:libra_read/model/database/daos/goals_read_dao.dart';
import 'package:libra_read/model/database/daos/histories_read_dao.dart';
import 'package:libra_read/model/database/table/books.dart';
import 'package:libra_read/model/database/table/histories_read.dart';
import 'package:libra_read/model/database/table/goals_read.dart';
import 'package:path/path.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

// 自動生成用
part 'database.g.dart';

@DriftDatabase(tables: [
  HistoriesRead,
  Books,
  GoalsRead,
], daos: [
  HistoriesReadDao,
  BooksDao,
  GoalsReadDao
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'books.sqlite'));
    return NativeDatabase(file);
  });
}
