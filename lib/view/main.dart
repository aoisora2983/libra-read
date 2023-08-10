import 'package:flutter/material.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:libra_read/view/page/history.dart';
import 'package:provider/provider.dart';
import 'package:libra_read/view/page/home.dart';
import 'package:libra_read/view/components/bottom_navigation.dart';
import 'package:libra_read/view/components/float_action_add_book_button.dart';
import 'package:libra_read/constant/constant.dart';

class MainAppView extends StatefulWidget {
  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => MainAppViewState();
}

class MainAppViewState extends State<MainAppView>
    with SingleTickerProviderStateMixin {
  int selectedIndex = MainPage.pageHome;
  static const List<Tab> tabs = <Tab>[
    Tab(
      text: "すべて",
      icon: Icon(Icons.shelves),
    ),
    Tab(
      text: "未読",
      icon: Icon(Icons.toc),
    ),
    Tab(
      text: "読了",
      icon: Icon(Icons.done),
    ),
    Tab(
      text: "お気に入り",
      icon: Icon(Icons.favorite),
    ),
  ];
  bool topTabVisible = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    String title = "";
    Widget page;

    switch (appState.currentPage) {
      case MainPage.pageHome:
        topTabVisible = false;
        page = const HomeView();
        title = "HOME";
        break;
      case MainPage.pageHistory:
        page = const HistoryView();
        topTabVisible = true;
        title = "本棚";
        break;
      default:
        throw UnimplementedError("ウィジェットがありません。$appState.currentPage");
    }
    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              title,
            ),
            actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
            backgroundColor: Theme.of(context).colorScheme.outlineVariant,
            bottom: topTabVisible
                ? TabBar(
                    tabs: tabs,
                    onTap: (value) {
                      appState.setHistoryMode(value);
                    },
                  )
                : null,
          ),
          body: page,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const FloatingActionAddBookButton(),
          bottomNavigationBar: const BottomNavigation(),
        ),
      ),
    );
  }
}
