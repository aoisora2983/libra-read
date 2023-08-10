import 'package:flutter/material.dart';
import 'package:libra_read/constant/constant.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:libra_read/view/components/history_base_app_bar.dart';
import 'package:libra_read/view/components/no_data.dart';
import 'package:provider/provider.dart';
import 'package:libra_read/view/components/book_container.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => HistoryViewState();
}

class HistoryViewState extends State<HistoryView> {
  Future<List<Book>>? _books;
  String keyword = '';
  final keywordController = TextEditingController();
  bool orderByAsc = true;
  int orderByColumn = HistorySortType.title;
  int historyType = HistoryType.all;

  void setKeyword(value) {
    setState(() {
      keyword = value;
    });
    getBooks();
  }

  /// AppBar及び検索・ソート状況を判断して検索する必要がある。
  void getBooks() {
    final database = Provider.of<AppDatabase>(context, listen: false);
    final appState = Provider.of<AppState>(context, listen: false);

    _books = database.booksDao.getBooksByHistory(
      orderByAsc,
      orderByColumn,
      appState.historyMode,
      keyword,
    );
  }

  void orderBooks(bool asc, int orderColumn) {
    setState(() {
      orderByAsc = asc;
      orderByColumn = orderColumn;
    });
    getBooks();
  }

  void reload() {
    setState(() {
      final database = Provider.of<AppDatabase>(context, listen: false);
      _books = database.booksDao.allBooks;
    });
  }

  @override
  void initState() {
    final database = Provider.of<AppDatabase>(context, listen: false);
    _books = database.booksDao.allBooks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    String noDataMessage = '';
    switch (appState.historyMode) {
      case HistoryType.all:
        noDataMessage = "登録した本がありません。\nまずは登録してみましょう！";
        break;
      case HistoryType.unread:
        noDataMessage = "登録した本がありません。\nこれから読みたい本などを登録してみましょう！";
        break;
      case HistoryType.read:
        noDataMessage =
            "登録した本がありません。\n読んだ本を登録したり、未読の本を読んだら「読了」にチェックを付けて記録を付けましょう。";
        break;
      case HistoryType.favorite:
        noDataMessage = "登録した本がありません。\n気に入った本を「お気に入り」にチェックして思い出に残してみませんか？";
        break;
    }
    getBooks();

    return Column(
      children: [
        HistoryBaseAppBar(
          keywordController: keywordController,
          setKeyword: setKeyword,
          orderBooks: orderBooks,
        ),
        FutureBuilder(
          future: _books,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Widget> list = [];
            if (snapshot.hasData) {
              List<Book> books = snapshot.data;
              if (books.isNotEmpty) {
                for (int i = 0; i < books.length; i++) {
                  Book book = books[i];
                  list.add(BookContainer(
                    book: book,
                    reload: reload,
                  ));
                }

                return Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: list,
                      ),
                    ),
                  ),
                );
              }
            }
            return NoData(message: noDataMessage);
          },
        ),
      ],
    );
  }

  void resetQuery() {
    keyword = "";
    keywordController.text = "";
    orderByAsc = true;
    orderByColumn = HistorySortType.title;
  }
}
