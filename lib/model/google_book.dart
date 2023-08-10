class GoogleBook {
  final String id;
  final String title;
  final List<dynamic> authors;
  final String published;
  final String description;
  final String isbn;
  final String isbn13;
  final String thumbnail;

  // ignore: constant_identifier_names
  static const String ISBN_10 = 'ISBN_10';
  // ignore: constant_identifier_names
  static const String ISBN_13 = 'ISBN_13';

  GoogleBook({
    required this.id,
    required this.title,
    required this.authors,
    required this.published,
    required this.description,
    required this.isbn,
    required this.isbn13,
    required this.thumbnail,
  });

  factory GoogleBook.fromJson(Map<String, dynamic> json) {
    var volumeInfo = json['volumeInfo'];

    String isbn = '';
    String isbn13 = '';
    var identifiers = volumeInfo['industryIdentifiers'];
    if (identifiers != null) {
      for (int i = 0; i < identifiers.length; i++) {
        switch (identifiers[i]['type']) {
          case ISBN_10:
            isbn = identifiers[i]['identifier'];
            break;
          case ISBN_13:
            isbn13 = identifiers[i]['identifier'];
            break;
        }
      }
    }

    var imageLinks = volumeInfo['imageLinks'] ?? {};

    return GoogleBook(
      id: json['id'],
      title: volumeInfo['title'] ?? '',
      authors: volumeInfo['authors'] ?? [],
      published: volumeInfo['publishedDate'] ?? '',
      description: volumeInfo['description'] ?? '',
      isbn: isbn.toString(),
      isbn13: isbn13.toString(),
      thumbnail: imageLinks.containsKey('smallThumbnail')
          ? imageLinks['smallThumbnail']
          : '',
    );
  }
}
