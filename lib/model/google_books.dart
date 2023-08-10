import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:libra_read/constant/constant.dart';
import 'package:libra_read/model/google_book.dart';
import 'package:sprintf/sprintf.dart';

class GoogleBooks {
  final int totalItems;
  final List items;

  GoogleBooks({
    required this.totalItems,
    required this.items,
  });

  factory GoogleBooks.fromJson(Map<String, dynamic> json) {
    List<GoogleBook> itemsToList(dynamic items) {
      List<GoogleBook> result = [];
      for (int i = 0; i < items.length; i++) {
        result.add(GoogleBook.fromJson(items[i]));
      }
      return result;
    }

    return GoogleBooks(
      totalItems: json['totalItems'],
      items: itemsToList(json['items']),
    );
  }

  static Future fetchBooksByISBN(String isbn) async {
    var url = sprintf('%s/volumes/q=isbn:%s', [ApiUrl.googleApiRoute, isbn]);
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return GoogleBooks.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to Load Google Book');
    }
  }

  static Future fetchBooksByKeyword(
    String keyword, {
    int startIndex = 0,
  }) async {
    var url = sprintf('%s/volumes?q=%s&startIndex=%d', [
      ApiUrl.googleApiRoute,
      keyword,
      startIndex,
    ]);
    // ignore: avoid_print
    print(url);
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return GoogleBooks.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to Load Google Book');
    }
  }
}
