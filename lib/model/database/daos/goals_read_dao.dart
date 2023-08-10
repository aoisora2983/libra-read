import 'package:drift/drift.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/model/database/table/goals_read.dart';

part 'goals_read_dao.g.dart';

@DriftAccessor(tables: [GoalsRead])
class GoalsReadDao extends DatabaseAccessor<AppDatabase>
    with _$GoalsReadDaoMixin {
  GoalsReadDao(AppDatabase db) : super(db);

  // 今月の目標値取得
  Future<GoalRead?> getThisGoal() async {
    DateTime now = DateTime.now();
    DateTime startThisMonth = DateTime(now.year, now.month, 1);
    DateTime endThisMonth =
        DateTime(now.year, now.month + 1, 1).add(const Duration(days: -1));

    final query = select(goalsRead)
      ..where((tbl) =>
          tbl.setDate.datetime.isBiggerOrEqualValue(startThisMonth.toString()) &
          tbl.setDate.datetime.isSmallerOrEqualValue(endThisMonth.toString()));

    return (await query.getSingleOrNull());
  }

  // 目標設定
  Future<int> setGoal(int goalCount) async {
    DateTime now = DateTime.now();
    // 今月の目標値が設定されているか確認し、
    GoalRead? data = await getThisGoal();

    if (data == null) {
      // 無ければinsert
      return db.into(goalsRead).insert(
          GoalsReadCompanion(goal: Value(goalCount), setDate: Value(now)));
    } else {
      // あればupdate
      return (update(goalsRead)..where((tbl) => tbl.id.equals(data.id)))
          .write(GoalsReadCompanion(goal: Value(goalCount)));
    }
  }

  // 全目標取得
  Future<List<GoalRead>> getAllGoal() {
    final query = select(goalsRead)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.setDate)]);

    return query.get();
  }
}
