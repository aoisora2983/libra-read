import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/model/google_book.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:libra_read/view/page/detail.dart';
import 'package:libra_read/view/secondary.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';

/// 検索結果の本の一覧
class SearchBookContainer extends StatelessWidget {
  const SearchBookContainer({
    super.key,
    required this.googleBook,
  });

  final GoogleBook googleBook;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Container(
      width: double.infinity,
      height: 235,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 24, left: 8, right: 24),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: existsThumbnail(googleBook.thumbnail),
                ),
                Expanded(
                  // 書籍情報枠
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          googleBook.title,
                          style: const TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            googleBook.authors.join("、"),
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            googleBook.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: registeredBook(googleBook.id, context),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data) {
                          return ElevatedButton.icon(
                            onPressed: null, // disabled
                            icon: const Icon(Icons.check),
                            label: const Text('登録済み'),
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
                      onPressedMoreDetail(googleBook, context);
                    },
                    icon: const Icon(Icons.read_more),
                    label: const Text('詳細'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget existsThumbnail(String thumbnail) {
    if (thumbnail.isNotEmpty) {
      return SizedBox(
        height: 125,
        child: Image.network(thumbnail),
      );
    } else {
      return SizedBox(
        height: 125,
        child: Image.asset(
          'assets/images/no_image.jpg',
        ),
      );
    }
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

  void onPressedMoreDetail(GoogleBook googleBook, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SecondaryView(
          pageIndex: SecondaryPage.pageDetailBook,
          page: Detail(googleBook: googleBook),
        );
      }),
    );
  }
}
