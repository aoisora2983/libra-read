import 'package:drift/drift.dart';

@DataClassName('GoalRead')
class GoalsRead extends Table {
  @override
  String? get tableName => 'goals_read';

  @override
  List<Set<Column>> get uniqueKeys => [
        {id}
      ];

  IntColumn get id => integer().autoIncrement()();

  IntColumn get goal => integer().withDefault(const Constant(0))();

  DateTimeColumn get setDate => dateTime().withDefault(currentDateAndTime)();
}
