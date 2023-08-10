import 'package:drift/drift.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/model/database/table/histories_read.dart';

part 'histories_read_dao.g.dart';

@DriftAccessor(tables: [HistoriesRead])
class HistoriesReadDao extends DatabaseAccessor<AppDatabase>
    with _$HistoriesReadDaoMixin {
  HistoriesReadDao(AppDatabase db) : super(db);

  Future<int> getTotalRead() async {
    final array = await select(historiesRead).get();
    int total = 0;
    for (final row in array) {
      total += row.readCount;
    }

    return total;
  }

  Future<HistoryRead?> getHistoryRead() async {
    DateTime now = DateTime.now();
    DateTime thisMonth = DateTime(now.year, now.month, 1);
    DateTime nextMonth = DateTime(now.year, now.month + 1, 1);
    final query = select(historiesRead)
      ..where((tbl) =>
          tbl.readDate.datetime.isBiggerOrEqualValue(thisMonth.toString()) &
          tbl.readDate.datetime.isSmallerThanValue(nextMonth.toString()));

    return (await query.getSingleOrNull());
  }

  Future<Map> getHistoryReadList() async {
    DateTime now = DateTime.now();
    DateTime lastMonth = DateTime(now.year, now.month + 1, 1)
        .add(const Duration(days: -1)); // 今月末
    DateTime past = DateTime(now.year, now.month - 6, 1); // 半年前の1日
    final sumOfReadCount = historiesRead.readCount.total();

    var query = select(historiesRead).join([])
      ..where(
          // 半月前以上の日付で今月末以下
          historiesRead.readDate.datetime
                  .isBiggerOrEqualValue(past.toString()) &
              historiesRead.readDate.datetime
                  .isSmallerOrEqualValue(lastMonth.toString()))
      ..addColumns([sumOfReadCount])
      ..groupBy([historiesRead.readDate.year, historiesRead.readDate.month])
      ..orderBy([OrderingTerm(expression: historiesRead.readDate)]);

    final result = await query.get();

    Map list = {};
    for (final row in result) {
      int year = row.readTable(historiesRead).readDate.year;
      int month = row.readTable(historiesRead).readDate.month;
      double? sum = row.read(sumOfReadCount);
      if (list[year] != null) {
        list[year].add({month: sum});
      } else {
        list[year] = [];
        list[year].add({month: sum});
      }
    }

    return list;
  }

  Future<int> upsertHistory() async {
    DateTime now = DateTime.now();
    HistoryRead? data = await getHistoryRead();
    if (data == null) {
      // insert
      return db.into(historiesRead).insert(
            HistoriesReadCompanion(
                readCount: const Value(1), readDate: Value(now)),
          );
    } else {
      // update
      return (update(historiesRead)..where((tbl) => tbl.id.equals(data.id)))
          .write(
        HistoriesReadCompanion(readCount: Value(data.readCount + 1)),
      );
    }
  }

  Future<int> decrementHistoryByReadAt(DateTime readAt) async {
    DateTime startMonth = DateTime(readAt.year, readAt.month, 1);
    DateTime endMonth = DateTime(readAt.year, readAt.month + 1, 1);
    final query = select(historiesRead)
      ..where((tbl) =>
          tbl.readDate.datetime.isBiggerOrEqualValue(startMonth.toString()) &
          tbl.readDate.datetime.isSmallerThanValue(endMonth.toString()));

    HistoryRead? data = await query.getSingleOrNull();
    if (data != null) {
      // update
      return (update(historiesRead)..where((tbl) => tbl.id.equals(data.id)))
          .write(
        HistoriesReadCompanion(readCount: Value(data.readCount - 1)),
      );
    } else {
      return 1;
    }
  }

  // 全履歴取得
  Future<List<HistoryRead>> getAllHistory() {
    final query = select(historiesRead)..orderBy([
      (tbl) => OrderingTerm.asc(tbl.readDate)
    ]);

    return query.get();
  }
}
