import 'package:flutter/material.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:provider/provider.dart';
import '../constant/constant.dart';

// ホームから遷移した先の画面のデフォルトレイアウト
class SecondaryView extends StatelessWidget {
  const SecondaryView({
    super.key,
    required this.pageIndex,
    required this.page,
  });

  final int pageIndex;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    String title = '';
    switch (pageIndex) {
      case SecondaryPage.pageSearchByInput:
        title = 'キーワード検索';
        break;
      case SecondaryPage.pageSearchByBarCode:
        title = 'バーコード読み取り';
        break;
      case SecondaryPage.pageSearchListBook:
        title = '検索一覧';
        break;
      case SecondaryPage.pageDetailBook:
        title = '詳細';
        break;
      case SecondaryPage.pageHistoryBookDetail:
        title = '詳細';
        break;
      case SecondaryPage.pageHistoryReadGoal:
        title = '目標達成履歴';
        break;
    }

    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(title),
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            ),
            body: page,
          ),
        ),
        if (appState.isLoading)
          const ColoredBox(
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
