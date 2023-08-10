import 'package:flutter/material.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:provider/provider.dart';

//
class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return BottomNavigationBar(
      onTap: (value) {
        appState.setCurrentPage(value);
      },
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      currentIndex: appState.currentPage,
      selectedFontSize: 16,
      unselectedFontSize: 16,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shelves),
          label: '本棚',
        )
      ],
    );
  }
}
