import 'package:drift/drift.dart';

@DataClassName('HistoryRead')
class HistoriesRead extends Table {
  @override
  String? get tableName => 'histories_read';

  @override
  List<Set<Column>> get uniqueKeys => [
        {id}
      ];

  IntColumn get id => integer().autoIncrement()();

  IntColumn get readCount => integer().withDefault(const Constant(0))();

  DateTimeColumn get readDate => dateTime().withDefault(currentDateAndTime)();
}
