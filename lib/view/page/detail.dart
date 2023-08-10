import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/model/google_book.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:provider/provider.dart';

/// 検索結果の本の一覧
class Detail extends StatelessWidget {
  const Detail({
    super.key,
    required this.googleBook,
  });

  final GoogleBook googleBook;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              // thumbnail
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: existsThumbnail(googleBook.thumbnail),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DataTable(
                  headingRowHeight: 0,
                  dataRowMaxHeight: double.infinity,
                  columns: const [
                    DataColumn(
                      label: SizedBox(
                        width: 60,
                        child: Text(''),
                      ),
                    ),
                    DataColumn(
                      label: Text(''),
                    ),
                  ],
                  rows: [
                    createRow('タイトル', googleBook.title),
                    createRow('著者', googleBook.authors.join("\r\n")),
                    createRow('出版年', googleBook.published),
                    createRow(
                      'ISBN',
                      'ISBN： ${googleBook.isbn}\nISBN13： ${googleBook.isbn13}',
                    ),
                    createRow('概要', googleBook.description),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FutureBuilder(
                future: registeredBook(googleBook.id, context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data) {
                      return ElevatedButton.icon(
                        onPressed: null, // disabled
                        icon: const Icon(Icons.check),
                        label: const Text('　　登録済み　　'),
                      );
                    }
                  }

                  return ElevatedButton.icon(
                    onPressed: () {
                      appState.lock();
                      try {
                        onPressedRegister(googleBook, context);
                        appState.unlock();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('登録完了'),
                              content: const Text('本を登録しました。'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                )
                              ],
                            );
                          },
                        );
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('エラー'),
                              content: const Text('本を登録できませんでした。'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('この本を登録する'),
                  );
                },
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.backspace_outlined),
                label: const Text('戻る'),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget existsThumbnail(String thumbnail) {
    if (thumbnail.isNotEmpty) {
      return SizedBox(
        height: 145,
        child: Image.network(thumbnail),
      );
    } else {
      return SizedBox(
        height: 120,
        child: Image.asset(
          'assets/images/no_image.jpg',
        ),
      );
    }
  }

  DataRow createRow(String label, String value) {
    return DataRow(
      cells: [
        DataCell(Text(label)),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(value),
        )),
      ],
    );
  }

  // 登録済みデータかどうか
  Future<bool> registeredBook(String id, BuildContext context) async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    return await database.booksDao.hasId(id);
  }

  void onPressedRegister(GoogleBook googleBook, BuildContext context) async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    await database.into(database.booksDao.books).insert(
          BooksCompanion.insert(
            idGoogle: googleBook.id,
            title: googleBook.title,
            author: Value(
              googleBook.authors.isNotEmpty ? googleBook.authors.join("、") : '',
            ),
            published: Value(googleBook.published),
            description: Value(googleBook.description),
            isbn: Value(googleBook.isbn),
            isbn13: Value(googleBook.isbn13),
            thumbnail: Value(googleBook.thumbnail),
          ),
        );
  }
}
