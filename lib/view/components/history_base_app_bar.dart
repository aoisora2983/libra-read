import 'package:flutter/material.dart';
import 'package:libra_read/constant/constant.dart';
import 'package:libra_read/view/components/column_icon_button.dart';

class HistoryBaseAppBar extends StatefulWidget {
  const HistoryBaseAppBar({
    super.key,
    required this.keywordController,
    required this.setKeyword,
    required this.orderBooks,
  });

  final dynamic keywordController;
  final dynamic setKeyword;
  final dynamic orderBooks;

  @override
  State<HistoryBaseAppBar> createState() => HistoryBaseAppBarState();
}

class HistoryBaseAppBarState extends State<HistoryBaseAppBar> {
  int nowHistoryMode = HistoryType.all;
  int mode = HistoryAppBarMode.first;
  int titleSort = SortStatus.none;
  int authorSort = SortStatus.none;
  int publisherSort = SortStatus.none;
  int createdAtSort = SortStatus.none;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 55,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      title: switchAppBar(mode, widget.keywordController),
      actions: [
        mode != HistoryAppBarMode.first
            ? ColumnIconButton(
                icon: Icons.clear,
                label: '',
                callback: onClear,
              )
            : const Text(''),
        mode != HistoryAppBarMode.first
            ? const Text('')
            : ColumnIconButton(
                icon: Icons.search,
                label: '検索',
                callback: onSearch,
                sortStatus: null,
              ),
        mode != HistoryAppBarMode.first
            ? const Text('')
            : ColumnIconButton(
                icon: Icons.sort,
                label: 'ソート',
                callback: onSort,
              ),
      ],
    );
  }

  onClear() {
    setState(() {
      mode = HistoryAppBarMode.first;
    });
    widget.keywordController.text = '';
    widget.setKeyword(widget.keywordController.text);
  }

  onSearch() {
    // 検索枠表示
    setState(() {
      mode = HistoryAppBarMode.search;
    });
  }

  onSort() {
    // 並び替えメニュー表示
    setState(() {
      mode = HistoryAppBarMode.sort;
    });
  }

  Widget switchAppBar(int mode, keywordController) {
    Widget appBarTitle = const Text('');

    switch (mode) {
      case HistoryAppBarMode.search:
        appBarTitle = Row(
          children: [
            Expanded(
              child: TextField(
                controller: keywordController,
                decoration: const InputDecoration(
                  hintText: '検索キーワードを入力',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  widget.setKeyword(keywordController.text);
                },
                child: const Text('検索'))
          ],
        );
        break;
      case HistoryAppBarMode.sort:
        appBarTitle = Row(
          children: [
            ColumnIconButton(
              icon: Icons.abc,
              label: 'タイトル',
              callback: () {
                widget.orderBooks(isAsc(titleSort), HistorySortType.title);
                int tmpTitleSort = titleSort;
                resetSort();
                titleSort = switchSort(tmpTitleSort);
              },
              sortStatus: titleSort,
            ),
            ColumnIconButton(
              icon: Icons.abc,
              label: '作者',
              callback: () {
                widget.orderBooks(isAsc(authorSort), HistorySortType.author);
                int tmpAuthorSort = authorSort;
                resetSort();
                authorSort = switchSort(tmpAuthorSort);
              },
              sortStatus: authorSort,
            ),
            ColumnIconButton(
              icon: Icons.date_range,
              label: '登録日',
              callback: () {
                widget.orderBooks(
                    isAsc(createdAtSort), HistorySortType.createdAt);
                int tmpCreatedAtSort = createdAtSort;
                resetSort();
                createdAtSort = switchSort(tmpCreatedAtSort);
              },
              sortStatus: createdAtSort,
            ),
            ColumnIconButton(
              icon: Icons.date_range,
              label: '出版年',
              callback: () {
                widget.orderBooks(isAsc(publisherSort), HistorySortType.author);
                int tmpPublisherSort = publisherSort;
                resetSort();
                publisherSort = switchSort(tmpPublisherSort);
              },
              sortStatus: publisherSort,
            ),
          ],
        );
        break;
      case HistoryAppBarMode.first:
      default:
        // 空のテキストを返す
        break;
    }

    return appBarTitle;
  }

  int switchSort(sortStatus) {
    int result = SortStatus.asc;
    switch (sortStatus) {
      case SortStatus.none:
      case SortStatus.desc:
        result = SortStatus.asc;
        break;
      case SortStatus.asc:
        result = SortStatus.desc;
        break;
    }

    return result;
  }

  bool isAsc(int sortStatus) {
    return sortStatus == SortStatus.asc;
  }

  void resetSort() {
    titleSort = SortStatus.none;
    authorSort = SortStatus.none;
    publisherSort = SortStatus.none;
    createdAtSort = SortStatus.none;
  }
}
