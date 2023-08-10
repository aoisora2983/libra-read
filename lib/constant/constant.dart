// mainレイアウトページ
class MainPage {
  static const int pageHome = 0; // HOME画面
  static const int pageHistory = 1; // 履歴画面
}

// 履歴画面 : リストタイプ
class HistoryType {
  static const int all = 0;
  static const int unread = 1;
  static const int read = 2;
  static const int favorite = 3;
}

class HistoryAppBarMode {
  static const int first = 0; // 初期表示
  static const int search = 1; // 検索枠
  static const int sort = 2; // ソート
}

class HistorySortType {
  static const int title = 0;
  static const int author = 1;
  static const int publisher = 2;
  static const int createdAt = 3;
}

class SortStatus {
  static const int none = 0;
  static const int asc = 1;
  static const int desc = 2;
}

// セカンダリーレイアウトページ
class SecondaryPage {
  static const int pageSearchByInput = 0; // 検索画面
  static const int pageSearchByBarCode = 1; // バーコード読み取り画面
  static const int pageSearchListBook = 2; // 103, 104で検索した結果のリスト表示画面
  static const int pageDetailBook = 3; // 本の詳細画面
  static const int pageConfig = 4; // 設定画面
  static const int pageHistoryBookDetail = 5; // 登録した本の詳細画面
  static const int pageRegisterBook = 6; // 本の登録画面
  static const int pageHistoryReadGoal = 7; // 過去の目標達成履歴閲覧画面
}

class ApiUrl {
  static const String googleApiRoute = "https://www.googleapis.com/books/v1";
}
