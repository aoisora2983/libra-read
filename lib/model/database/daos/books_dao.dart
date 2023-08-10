import 'package:drift/drift.dart';
import 'package:libra_read/constant/constant.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/model/database/table/books.dart';

part 'books_dao.g.dart';

@DriftAccessor(tables: [Books])
class BooksDao extends DatabaseAccessor<AppDatabase> with _$BooksDaoMixin {
  BooksDao(AppDatabase db) : super(db);

  Future<List<Book>> get allBooks =>
      (select(books)..orderBy([(tbl) => OrderingTerm.asc(tbl.idGoogle)])).get();

  Future<bool> hasId(String idGoogle) async {
    final query = select(books)..where((a) => a.idGoogle.like(idGoogle));

    return (await query.get()).isNotEmpty;
  }

  Future<List<Book>> getBooksByHistory(
    bool asc,
    int orderByColumn,
    int historyMode,
    String? keyword,
  ) async {
    final query = select(books);

    // キーワードがあれば
    if (keyword != null) {
      query.where(
        (tbl) => tbl.title.like('%$keyword%') | tbl.author.like('%$keyword%'),
      );
    }

    // ソート
    query.orderBy(
      [
        (tbl) {
          var expression = tbl.title;
          switch (orderByColumn) {
            case HistorySortType.author:
              expression = tbl.author;
              break;
            case HistorySortType.createdAt:
              return OrderingTerm(
                expression: tbl.createdAt,
                mode: asc ? OrderingMode.asc : OrderingMode.desc,
              );
            case HistorySortType.publisher:
              expression = tbl.published;
              break;
          }

          return OrderingTerm(
            expression: expression,
            mode: asc ? OrderingMode.asc : OrderingMode.desc,
          );
        }
      ],
    );

    // フラグ
    switch (historyMode) {
      case HistoryType.all:
        break;
      case HistoryType.unread:
        query.where(
          (tbl) => tbl.read.equals(false),
        );
        break;
      case HistoryType.read:
        query.where(
          (tbl) => tbl.read.equals(true),
        );
        break;
      case HistoryType.favorite:
        query.where(
          (tbl) => tbl.favorite.equals(true),
        );
        break;
    }

    return (await query.get());
  }

  Future<int> updateBooksRead(bool value, int id) {
    return (update(books)..where((tbl) => tbl.id.equals(id))).write(
      BooksCompanion(
        read: Value(value),
        readAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> updateBooksFavorite(bool value, int id) {
    return (update(books)..where((tbl) => tbl.id.equals(id)))
        .write(BooksCompanion(favorite: Value(value)));
  }

  Future<int> updateBooksMemo(String memo, int id) {
    return (update(books)..where((tbl) => tbl.id.equals(id)))
        .write(BooksCompanion(memo: Value(memo)));
  }
}
