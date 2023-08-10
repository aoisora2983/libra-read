import 'dart:io';

import 'package:flutter/material.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:provider/provider.dart';

/// 検索結果の本の一覧
class HistoryBookDetail extends StatefulWidget {
  const HistoryBookDetail({super.key, required this.book});

  final Book book;

  @override
  State<HistoryBookDetail> createState() => HistoryBookDetailState();
}

class HistoryBookDetailState extends State<HistoryBookDetail> {
  bool read = false;
  bool favorite = false;
  final memoController = TextEditingController();

  void _handleReadCheckbox(bool? e) {
    setState(() {
      read = e ?? false;
    });
    onPressedRead(read);
  }

  void _handleFavoriteCheckbox(bool? e) {
    setState(() {
      favorite = e ?? false;
    });
    onPressedFavorite(favorite);
  }

  @override
  void initState() {
    super.initState();
    read = widget.book.read;
    favorite = widget.book.favorite;
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    memoController.text = widget.book.memo ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('削除'),
                                content: const Text('本を削除します。よろしいですか？'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      appState.lock();
                                      onPressedDelete();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      appState.unlock();
                                    },
                                    child: const Text('消す'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('消さない'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    Positioned(
                      // thumbnail,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: existsThumbnail(widget.book.thumbnail ?? ''),
                      ),
                    )
                  ],
                ),
                DataTable(
                  columnSpacing: 20,
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
                    createRow('タイトル', widget.book.title),
                    createRow('著者', widget.book.author ?? ''),
                    createRow('出版年', widget.book.published ?? ''),
                    createRow(
                      'ISBN',
                      'ISBN： ${widget.book.isbn}\nISBN13： ${widget.book.isbn13}',
                    ),
                    createRow('概要', widget.book.description ?? ''),
                    DataRow(
                      cells: [
                        const DataCell(
                          Text('メモ'),
                        ),
                        DataCell(
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 145,
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  controller: memoController,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText:
                                        widget.book.memo ?? '本の感想やメモを書いてみましょう！',
                                    hintStyle: const TextStyle(
                                      fontSize: 13,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          appState.lock();
                                          String memo = memoController.text;
                                          onPressedSaveMemo(memo);
                                          appState.unlock();
                                        },
                                        icon: const Row(
                                          children: [
                                            Icon(
                                              Icons.save_alt,
                                              size: 20,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                              child: Text(
                                                '保存',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    enabled: !read, // 読み終わったフラグ建ってたらもう変更できなくて良い,
                    value: read,
                    title: const Text('読了'),
                    secondary: Icon(
                      Icons.done,
                      color: read
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[500],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: _handleReadCheckbox,
                  ),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                  child: CheckboxListTile(
                    value: favorite,
                    title: const Text('お気に入り'),
                    secondary: Icon(
                      Icons.favorite,
                      color: favorite
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[500],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: _handleFavoriteCheckbox,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }

  Widget existsThumbnail(String thumbnail) {
    if (thumbnail.isNotEmpty) {
      RegExp exp = RegExp(r'https?://.*');
      if (exp.hasMatch(thumbnail)) {
        return SizedBox(
          height: 145,
          child: Image.network(thumbnail),
        );
      } else {
        return SizedBox(
          height: 145,
          child: Image.file(File(thumbnail)),
        );
      }
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

  // データ更新
  void onPressedRead(bool value) async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    await database.booksDao.updateBooksRead(value, widget.book.id);
    await database.historiesReadDao.upsertHistory();
  }

  void onPressedFavorite(bool value) async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    await database.booksDao.updateBooksFavorite(value, widget.book.id);
  }

  // データ削除
  void onPressedDelete() async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    // 読了済みなら、readAtの日付の読書履歴も一件消す
    if (widget.book.readAt != null) {
      await database.historiesReadDao
          .decrementHistoryByReadAt(widget.book.readAt ?? DateTime.now());
    }

    await (database.delete(database.booksDao.books)
          ..where((tbl) => tbl.id.equals(widget.book.id)))
        .go();
  }

  // メモ更新
  void onPressedSaveMemo(String memo) async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    await database.booksDao.updateBooksMemo(memo, widget.book.id);
  }
}
