import 'package:flutter/material.dart';
import 'package:libra_read/constant/constant.dart';

class AppState extends ChangeNotifier {
  var currentPage = MainPage.pageHome; // ページID
  var secondaryCurrentPage = SecondaryPage.pageSearchByInput; // ページID
  var historyMode = 0; // 本棚カテゴリ
  var historyAppBar = 0; // 本棚バーステータス
  bool isLoading = false; // ローディング

  void setSecondaryCurrentPage(value) {
    secondaryCurrentPage = value;
    notifyListeners();
  }

  void setCurrentPage(value) {
    currentPage = value;
    notifyListeners();
  }

  void setHistoryMode(value) {
    historyMode = value;
    notifyListeners();
  }

  void setHistoryAppBar(value) {
    historyAppBar = value;
    notifyListeners();
  }

  void lock() {
    isLoading = true;
    notifyListeners();
  }

  void unlock() {
    isLoading = false;
    notifyListeners();
  }
}
