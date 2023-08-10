// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $HistoriesReadTable extends HistoriesRead
    with TableInfo<$HistoriesReadTable, HistoryRead> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoriesReadTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _readCountMeta =
      const VerificationMeta('readCount');
  @override
  late final GeneratedColumn<int> readCount = GeneratedColumn<int>(
      'read_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _readDateMeta =
      const VerificationMeta('readDate');
  @override
  late final GeneratedColumn<DateTime> readDate = GeneratedColumn<DateTime>(
      'read_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, readCount, readDate];
  @override
  String get aliasedName => _alias ?? 'histories_read';
  @override
  String get actualTableName => 'histories_read';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryRead> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('read_count')) {
      context.handle(_readCountMeta,
          readCount.isAcceptableOrUnknown(data['read_count']!, _readCountMeta));
    }
    if (data.containsKey('read_date')) {
      context.handle(_readDateMeta,
          readDate.isAcceptableOrUnknown(data['read_date']!, _readDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {id},
      ];
  @override
  HistoryRead map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryRead(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      readCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}read_count'])!,
      readDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}read_date'])!,
    );
  }

  @override
  $HistoriesReadTable createAlias(String alias) {
    return $HistoriesReadTable(attachedDatabase, alias);
  }
}

class HistoryRead extends DataClass implements Insertable<HistoryRead> {
  final int id;
  final int readCount;
  final DateTime readDate;
  const HistoryRead(
      {required this.id, required this.readCount, required this.readDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['read_count'] = Variable<int>(readCount);
    map['read_date'] = Variable<DateTime>(readDate);
    return map;
  }

  HistoriesReadCompanion toCompanion(bool nullToAbsent) {
    return HistoriesReadCompanion(
      id: Value(id),
      readCount: Value(readCount),
      readDate: Value(readDate),
    );
  }

  factory HistoryRead.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryRead(
      id: serializer.fromJson<int>(json['id']),
      readCount: serializer.fromJson<int>(json['readCount']),
      readDate: serializer.fromJson<DateTime>(json['readDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'readCount': serializer.toJson<int>(readCount),
      'readDate': serializer.toJson<DateTime>(readDate),
    };
  }

  HistoryRead copyWith({int? id, int? readCount, DateTime? readDate}) =>
      HistoryRead(
        id: id ?? this.id,
        readCount: readCount ?? this.readCount,
        readDate: readDate ?? this.readDate,
      );
  @override
  String toString() {
    return (StringBuffer('HistoryRead(')
          ..write('id: $id, ')
          ..write('readCount: $readCount, ')
          ..write('readDate: $readDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, readCount, readDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryRead &&
          other.id == this.id &&
          other.readCount == this.readCount &&
          other.readDate == this.readDate);
}

class HistoriesReadCompanion extends UpdateCompanion<HistoryRead> {
  final Value<int> id;
  final Value<int> readCount;
  final Value<DateTime> readDate;
  const HistoriesReadCompanion({
    this.id = const Value.absent(),
    this.readCount = const Value.absent(),
    this.readDate = const Value.absent(),
  });
  HistoriesReadCompanion.insert({
    this.id = const Value.absent(),
    this.readCount = const Value.absent(),
    this.readDate = const Value.absent(),
  });
  static Insertable<HistoryRead> custom({
    Expression<int>? id,
    Expression<int>? readCount,
    Expression<DateTime>? readDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (readCount != null) 'read_count': readCount,
      if (readDate != null) 'read_date': readDate,
    });
  }

  HistoriesReadCompanion copyWith(
      {Value<int>? id, Value<int>? readCount, Value<DateTime>? readDate}) {
    return HistoriesReadCompanion(
      id: id ?? this.id,
      readCount: readCount ?? this.readCount,
      readDate: readDate ?? this.readDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (readCount.present) {
      map['read_count'] = Variable<int>(readCount.value);
    }
    if (readDate.present) {
      map['read_date'] = Variable<DateTime>(readDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoriesReadCompanion(')
          ..write('id: $id, ')
          ..write('readCount: $readCount, ')
          ..write('readDate: $readDate')
          ..write(')'))
        .toString();
  }
}

class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idGoogleMeta =
      const VerificationMeta('idGoogle');
  @override
  late final GeneratedColumn<String> idGoogle = GeneratedColumn<String>(
      'id_google', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
      'category', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _publishedMeta =
      const VerificationMeta('published');
  @override
  late final GeneratedColumn<String> published = GeneratedColumn<String>(
      'published', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isbnMeta = const VerificationMeta('isbn');
  @override
  late final GeneratedColumn<String> isbn = GeneratedColumn<String>(
      'isbn', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isbn13Meta = const VerificationMeta('isbn13');
  @override
  late final GeneratedColumn<String> isbn13 = GeneratedColumn<String>(
      'isbn13', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _thumbnailMeta =
      const VerificationMeta('thumbnail');
  @override
  late final GeneratedColumn<String> thumbnail = GeneratedColumn<String>(
      'thumbnail', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _readMeta = const VerificationMeta('read');
  @override
  late final GeneratedColumn<bool> read = GeneratedColumn<bool>(
      'read', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("read" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _readAtMeta = const VerificationMeta('readAt');
  @override
  late final GeneratedColumn<DateTime> readAt = GeneratedColumn<DateTime>(
      'read_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _favoriteMeta =
      const VerificationMeta('favorite');
  @override
  late final GeneratedColumn<bool> favorite = GeneratedColumn<bool>(
      'favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
      'memo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idGoogle,
        category,
        title,
        author,
        published,
        description,
        isbn,
        isbn13,
        thumbnail,
        read,
        readAt,
        favorite,
        memo,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'books';
  @override
  String get actualTableName => 'books';
  @override
  VerificationContext validateIntegrity(Insertable<Book> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_google')) {
      context.handle(_idGoogleMeta,
          idGoogle.isAcceptableOrUnknown(data['id_google']!, _idGoogleMeta));
    } else if (isInserting) {
      context.missing(_idGoogleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('published')) {
      context.handle(_publishedMeta,
          published.isAcceptableOrUnknown(data['published']!, _publishedMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('isbn')) {
      context.handle(
          _isbnMeta, isbn.isAcceptableOrUnknown(data['isbn']!, _isbnMeta));
    }
    if (data.containsKey('isbn13')) {
      context.handle(_isbn13Meta,
          isbn13.isAcceptableOrUnknown(data['isbn13']!, _isbn13Meta));
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    }
    if (data.containsKey('read')) {
      context.handle(
          _readMeta, read.isAcceptableOrUnknown(data['read']!, _readMeta));
    }
    if (data.containsKey('read_at')) {
      context.handle(_readAtMeta,
          readAt.isAcceptableOrUnknown(data['read_at']!, _readAtMeta));
    }
    if (data.containsKey('favorite')) {
      context.handle(_favoriteMeta,
          favorite.isAcceptableOrUnknown(data['favorite']!, _favoriteMeta));
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {id},
      ];
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idGoogle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_google'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author']),
      published: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}published']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isbn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}isbn']),
      isbn13: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}isbn13']),
      thumbnail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail']),
      read: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}read'])!,
      readAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}read_at']),
      favorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}favorite'])!,
      memo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memo']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class Book extends DataClass implements Insertable<Book> {
  final int id;
  final String idGoogle;
  final int? category;
  final String title;
  final String? author;
  final String? published;
  final String? description;
  final String? isbn;
  final String? isbn13;
  final String? thumbnail;
  final bool read;
  final DateTime? readAt;
  final bool favorite;
  final String? memo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Book(
      {required this.id,
      required this.idGoogle,
      this.category,
      required this.title,
      this.author,
      this.published,
      this.description,
      this.isbn,
      this.isbn13,
      this.thumbnail,
      required this.read,
      this.readAt,
      required this.favorite,
      this.memo,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_google'] = Variable<String>(idGoogle);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int>(category);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || published != null) {
      map['published'] = Variable<String>(published);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || isbn != null) {
      map['isbn'] = Variable<String>(isbn);
    }
    if (!nullToAbsent || isbn13 != null) {
      map['isbn13'] = Variable<String>(isbn13);
    }
    if (!nullToAbsent || thumbnail != null) {
      map['thumbnail'] = Variable<String>(thumbnail);
    }
    map['read'] = Variable<bool>(read);
    if (!nullToAbsent || readAt != null) {
      map['read_at'] = Variable<DateTime>(readAt);
    }
    map['favorite'] = Variable<bool>(favorite);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      idGoogle: Value(idGoogle),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      title: Value(title),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      published: published == null && nullToAbsent
          ? const Value.absent()
          : Value(published),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isbn: isbn == null && nullToAbsent ? const Value.absent() : Value(isbn),
      isbn13:
          isbn13 == null && nullToAbsent ? const Value.absent() : Value(isbn13),
      thumbnail: thumbnail == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnail),
      read: Value(read),
      readAt:
          readAt == null && nullToAbsent ? const Value.absent() : Value(readAt),
      favorite: Value(favorite),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Book.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      id: serializer.fromJson<int>(json['id']),
      idGoogle: serializer.fromJson<String>(json['idGoogle']),
      category: serializer.fromJson<int?>(json['category']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String?>(json['author']),
      published: serializer.fromJson<String?>(json['published']),
      description: serializer.fromJson<String?>(json['description']),
      isbn: serializer.fromJson<String?>(json['isbn']),
      isbn13: serializer.fromJson<String?>(json['isbn13']),
      thumbnail: serializer.fromJson<String?>(json['thumbnail']),
      read: serializer.fromJson<bool>(json['read']),
      readAt: serializer.fromJson<DateTime?>(json['readAt']),
      favorite: serializer.fromJson<bool>(json['favorite']),
      memo: serializer.fromJson<String?>(json['memo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idGoogle': serializer.toJson<String>(idGoogle),
      'category': serializer.toJson<int?>(category),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String?>(author),
      'published': serializer.toJson<String?>(published),
      'description': serializer.toJson<String?>(description),
      'isbn': serializer.toJson<String?>(isbn),
      'isbn13': serializer.toJson<String?>(isbn13),
      'thumbnail': serializer.toJson<String?>(thumbnail),
      'read': serializer.toJson<bool>(read),
      'readAt': serializer.toJson<DateTime?>(readAt),
      'favorite': serializer.toJson<bool>(favorite),
      'memo': serializer.toJson<String?>(memo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Book copyWith(
          {int? id,
          String? idGoogle,
          Value<int?> category = const Value.absent(),
          String? title,
          Value<String?> author = const Value.absent(),
          Value<String?> published = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> isbn = const Value.absent(),
          Value<String?> isbn13 = const Value.absent(),
          Value<String?> thumbnail = const Value.absent(),
          bool? read,
          Value<DateTime?> readAt = const Value.absent(),
          bool? favorite,
          Value<String?> memo = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Book(
        id: id ?? this.id,
        idGoogle: idGoogle ?? this.idGoogle,
        category: category.present ? category.value : this.category,
        title: title ?? this.title,
        author: author.present ? author.value : this.author,
        published: published.present ? published.value : this.published,
        description: description.present ? description.value : this.description,
        isbn: isbn.present ? isbn.value : this.isbn,
        isbn13: isbn13.present ? isbn13.value : this.isbn13,
        thumbnail: thumbnail.present ? thumbnail.value : this.thumbnail,
        read: read ?? this.read,
        readAt: readAt.present ? readAt.value : this.readAt,
        favorite: favorite ?? this.favorite,
        memo: memo.present ? memo.value : this.memo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('id: $id, ')
          ..write('idGoogle: $idGoogle, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('published: $published, ')
          ..write('description: $description, ')
          ..write('isbn: $isbn, ')
          ..write('isbn13: $isbn13, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('read: $read, ')
          ..write('readAt: $readAt, ')
          ..write('favorite: $favorite, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      idGoogle,
      category,
      title,
      author,
      published,
      description,
      isbn,
      isbn13,
      thumbnail,
      read,
      readAt,
      favorite,
      memo,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.id == this.id &&
          other.idGoogle == this.idGoogle &&
          other.category == this.category &&
          other.title == this.title &&
          other.author == this.author &&
          other.published == this.published &&
          other.description == this.description &&
          other.isbn == this.isbn &&
          other.isbn13 == this.isbn13 &&
          other.thumbnail == this.thumbnail &&
          other.read == this.read &&
          other.readAt == this.readAt &&
          other.favorite == this.favorite &&
          other.memo == this.memo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<int> id;
  final Value<String> idGoogle;
  final Value<int?> category;
  final Value<String> title;
  final Value<String?> author;
  final Value<String?> published;
  final Value<String?> description;
  final Value<String?> isbn;
  final Value<String?> isbn13;
  final Value<String?> thumbnail;
  final Value<bool> read;
  final Value<DateTime?> readAt;
  final Value<bool> favorite;
  final Value<String?> memo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.idGoogle = const Value.absent(),
    this.category = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.published = const Value.absent(),
    this.description = const Value.absent(),
    this.isbn = const Value.absent(),
    this.isbn13 = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.read = const Value.absent(),
    this.readAt = const Value.absent(),
    this.favorite = const Value.absent(),
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BooksCompanion.insert({
    this.id = const Value.absent(),
    required String idGoogle,
    this.category = const Value.absent(),
    required String title,
    this.author = const Value.absent(),
    this.published = const Value.absent(),
    this.description = const Value.absent(),
    this.isbn = const Value.absent(),
    this.isbn13 = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.read = const Value.absent(),
    this.readAt = const Value.absent(),
    this.favorite = const Value.absent(),
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : idGoogle = Value(idGoogle),
        title = Value(title);
  static Insertable<Book> custom({
    Expression<int>? id,
    Expression<String>? idGoogle,
    Expression<int>? category,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? published,
    Expression<String>? description,
    Expression<String>? isbn,
    Expression<String>? isbn13,
    Expression<String>? thumbnail,
    Expression<bool>? read,
    Expression<DateTime>? readAt,
    Expression<bool>? favorite,
    Expression<String>? memo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idGoogle != null) 'id_google': idGoogle,
      if (category != null) 'category': category,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (published != null) 'published': published,
      if (description != null) 'description': description,
      if (isbn != null) 'isbn': isbn,
      if (isbn13 != null) 'isbn13': isbn13,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (read != null) 'read': read,
      if (readAt != null) 'read_at': readAt,
      if (favorite != null) 'favorite': favorite,
      if (memo != null) 'memo': memo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BooksCompanion copyWith(
      {Value<int>? id,
      Value<String>? idGoogle,
      Value<int?>? category,
      Value<String>? title,
      Value<String?>? author,
      Value<String?>? published,
      Value<String?>? description,
      Value<String?>? isbn,
      Value<String?>? isbn13,
      Value<String?>? thumbnail,
      Value<bool>? read,
      Value<DateTime?>? readAt,
      Value<bool>? favorite,
      Value<String?>? memo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return BooksCompanion(
      id: id ?? this.id,
      idGoogle: idGoogle ?? this.idGoogle,
      category: category ?? this.category,
      title: title ?? this.title,
      author: author ?? this.author,
      published: published ?? this.published,
      description: description ?? this.description,
      isbn: isbn ?? this.isbn,
      isbn13: isbn13 ?? this.isbn13,
      thumbnail: thumbnail ?? this.thumbnail,
      read: read ?? this.read,
      readAt: readAt ?? this.readAt,
      favorite: favorite ?? this.favorite,
      memo: memo ?? this.memo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idGoogle.present) {
      map['id_google'] = Variable<String>(idGoogle.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (published.present) {
      map['published'] = Variable<String>(published.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isbn.present) {
      map['isbn'] = Variable<String>(isbn.value);
    }
    if (isbn13.present) {
      map['isbn13'] = Variable<String>(isbn13.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    if (read.present) {
      map['read'] = Variable<bool>(read.value);
    }
    if (readAt.present) {
      map['read_at'] = Variable<DateTime>(readAt.value);
    }
    if (favorite.present) {
      map['favorite'] = Variable<bool>(favorite.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('idGoogle: $idGoogle, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('published: $published, ')
          ..write('description: $description, ')
          ..write('isbn: $isbn, ')
          ..write('isbn13: $isbn13, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('read: $read, ')
          ..write('readAt: $readAt, ')
          ..write('favorite: $favorite, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $GoalsReadTable extends GoalsRead
    with TableInfo<$GoalsReadTable, GoalRead> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsReadTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<int> goal = GeneratedColumn<int>(
      'goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _setDateMeta =
      const VerificationMeta('setDate');
  @override
  late final GeneratedColumn<DateTime> setDate = GeneratedColumn<DateTime>(
      'set_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, goal, setDate];
  @override
  String get aliasedName => _alias ?? 'goals_read';
  @override
  String get actualTableName => 'goals_read';
  @override
  VerificationContext validateIntegrity(Insertable<GoalRead> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('goal')) {
      context.handle(
          _goalMeta, goal.isAcceptableOrUnknown(data['goal']!, _goalMeta));
    }
    if (data.containsKey('set_date')) {
      context.handle(_setDateMeta,
          setDate.isAcceptableOrUnknown(data['set_date']!, _setDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {id},
      ];
  @override
  GoalRead map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalRead(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      goal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal'])!,
      setDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}set_date'])!,
    );
  }

  @override
  $GoalsReadTable createAlias(String alias) {
    return $GoalsReadTable(attachedDatabase, alias);
  }
}

class GoalRead extends DataClass implements Insertable<GoalRead> {
  final int id;
  final int goal;
  final DateTime setDate;
  const GoalRead({required this.id, required this.goal, required this.setDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['goal'] = Variable<int>(goal);
    map['set_date'] = Variable<DateTime>(setDate);
    return map;
  }

  GoalsReadCompanion toCompanion(bool nullToAbsent) {
    return GoalsReadCompanion(
      id: Value(id),
      goal: Value(goal),
      setDate: Value(setDate),
    );
  }

  factory GoalRead.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalRead(
      id: serializer.fromJson<int>(json['id']),
      goal: serializer.fromJson<int>(json['goal']),
      setDate: serializer.fromJson<DateTime>(json['setDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'goal': serializer.toJson<int>(goal),
      'setDate': serializer.toJson<DateTime>(setDate),
    };
  }

  GoalRead copyWith({int? id, int? goal, DateTime? setDate}) => GoalRead(
        id: id ?? this.id,
        goal: goal ?? this.goal,
        setDate: setDate ?? this.setDate,
      );
  @override
  String toString() {
    return (StringBuffer('GoalRead(')
          ..write('id: $id, ')
          ..write('goal: $goal, ')
          ..write('setDate: $setDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, goal, setDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalRead &&
          other.id == this.id &&
          other.goal == this.goal &&
          other.setDate == this.setDate);
}

class GoalsReadCompanion extends UpdateCompanion<GoalRead> {
  final Value<int> id;
  final Value<int> goal;
  final Value<DateTime> setDate;
  const GoalsReadCompanion({
    this.id = const Value.absent(),
    this.goal = const Value.absent(),
    this.setDate = const Value.absent(),
  });
  GoalsReadCompanion.insert({
    this.id = const Value.absent(),
    this.goal = const Value.absent(),
    this.setDate = const Value.absent(),
  });
  static Insertable<GoalRead> custom({
    Expression<int>? id,
    Expression<int>? goal,
    Expression<DateTime>? setDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goal != null) 'goal': goal,
      if (setDate != null) 'set_date': setDate,
    });
  }

  GoalsReadCompanion copyWith(
      {Value<int>? id, Value<int>? goal, Value<DateTime>? setDate}) {
    return GoalsReadCompanion(
      id: id ?? this.id,
      goal: goal ?? this.goal,
      setDate: setDate ?? this.setDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (goal.present) {
      map['goal'] = Variable<int>(goal.value);
    }
    if (setDate.present) {
      map['set_date'] = Variable<DateTime>(setDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsReadCompanion(')
          ..write('id: $id, ')
          ..write('goal: $goal, ')
          ..write('setDate: $setDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $HistoriesReadTable historiesRead = $HistoriesReadTable(this);
  late final $BooksTable books = $BooksTable(this);
  late final $GoalsReadTable goalsRead = $GoalsReadTable(this);
  late final HistoriesReadDao historiesReadDao =
      HistoriesReadDao(this as AppDatabase);
  late final BooksDao booksDao = BooksDao(this as AppDatabase);
  late final GoalsReadDao goalsReadDao = GoalsReadDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [historiesRead, books, goalsRead];
}
