import 'package:flutter/material.dart';
import 'package:libra_read/model/google_books.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:libra_read/view/components/search_book_container.dart';
import 'package:provider/provider.dart';

String keyword = "";

class SearchByInputView extends StatefulWidget {
  const SearchByInputView({super.key});

  @override
  State<SearchByInputView> createState() => SearchByInputViewState();
}

class SearchByInputViewState extends State<SearchByInputView> {
  GoogleBooks list = GoogleBooks(totalItems: 0, items: []);
  var searchKeywordController = TextEditingController();
  int startIndex = 0;
  var appState;

  @override
  Widget build(BuildContext context) {
    appState = context.watch<AppState>();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          TextField(
            controller: searchKeywordController,
            decoration: InputDecoration(
              labelText: 'キーワード',
              hintText: '本のタイトルや作者などを入力してください。',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () async {
                        // 入力無はエラー
                        if (searchKeywordController.text == '') {
                          return;
                        }

                        appState.lock();
                        var result = GoogleBooks(totalItems: 0, items: []);
                        try {
                          result = await GoogleBooks.fetchBooksByKeyword(
                            searchKeywordController.text,
                          );
                        } catch (e) {
                          // show alert dialog
                        }

                        setState(() {
                          list = result;
                          appState.unlock();
                        });
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('検索する')),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      searchKeywordController.text = '';
                    },
                    icon: const Icon(Icons.clear),
                    label: const Text('クリア'),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  for (int i = 0; i < list.items.length; i++) ...{
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SearchBookContainer(
                        googleBook: list.items[i],
                      ),
                    ),
                  },
                ],
              ),
            ),
          ),
          // paginate
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: renderPageButtonList(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> renderPageButtonList() {
    List<Widget> buttonList = [];
    // 検索結果が出てない間は出さない
    if (list.items.isEmpty) {
      return buttonList;
    }

    // 前へはstartIndexが0以上の時しかださない
    if (startIndex != 0) {
      buttonList.add(renderPageButton('前へ', false));
    }
    // 次へは今のstartIndex + 10 の値がtotalより小さい場合しか出さない
    if (startIndex + 10 < list.totalItems) {
      buttonList.add(renderPageButton('次へ', true));
    }

    return buttonList;
  }

  Widget renderPageButton(String label, bool isNext) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 36,
      child: ElevatedButton(
        onPressed: () async {
          appState.lock();
          if (isNext) {
            startIndex += 10;
          } else {
            startIndex -= 10;
          }
          var result = GoogleBooks(totalItems: 0, items: []);
          try {
            result = await GoogleBooks.fetchBooksByKeyword(
              searchKeywordController.text,
              startIndex: startIndex,
            );
          } catch (e) {
            // show alert dialog
          }

          setState(() {
            list = result;
            appState.unlock();
          });
        },
        child: Text(label),
      ),
    );
  }
}
