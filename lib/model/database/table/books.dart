import 'package:drift/drift.dart';

@DataClassName('Book')
class Books extends Table {
  @override
  String? get tableName => 'books';

  @override
  List<Set<Column>> get uniqueKeys => [
        {id}
      ];

  IntColumn get id => integer().autoIncrement()(); // ID
  TextColumn get idGoogle => text()(); // Google API ID
  IntColumn get category => integer().nullable()(); // カテゴリーID
  TextColumn get title => text()(); // タイトル
  TextColumn get author => text().nullable()(); // 著者
  TextColumn get published => text().nullable()(); // 出版日
  TextColumn get description => text().nullable()(); // 概要
  TextColumn get isbn => text().nullable()(); // isbn
  TextColumn get isbn13 => text().nullable()(); // isbn13
  TextColumn get thumbnail => text().nullable()(); // サムネイル
  BoolColumn get read =>
      boolean().withDefault(const Constant(false))(); // 読了フラグ
  DateTimeColumn get readAt => dateTime().nullable()(); // 読了日
  BoolColumn get favorite =>
      boolean().withDefault(const Constant(false))(); // お気に入りフラグ
  TextColumn get memo => text().nullable()(); // ユーザーメモ
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)(); // 登録日時
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)(); // 更新日
}


