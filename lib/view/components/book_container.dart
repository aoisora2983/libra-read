import 'dart:io';

import 'package:flutter/material.dart';
import 'package:libra_read/constant/constant.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/view/page/history_book_detail.dart';
import 'package:libra_read/view/secondary.dart';

class BookContainer extends StatelessWidget {
  const BookContainer({super.key, required this.book, required this.reload});

  final Book book;
  final dynamic reload;

  @override
  Widget build(BuildContext context) {
    // 画面幅が400pxまでは2列となるよう伸縮し、それ以降は固定幅(200px)でwrapさせる
    double maxContentWidth = MediaQuery.of(context).size.width / 2.5;
    if (maxContentWidth > 110) {
      maxContentWidth = 110;
    }

    return InkWell(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return SecondaryView(
                pageIndex: SecondaryPage.pageHistoryBookDetail,
                page: HistoryBookDetail(book: book));
          }),
        );
        reload();
      },
      child: SizedBox(
        width: maxContentWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: existsThumbnail(book.thumbnail ?? ''),
              ),
              Text(
                book.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget existsThumbnail(String thumbnail) {
    if (thumbnail.isNotEmpty) {
      RegExp exp = RegExp(r'https?://.*');
      if (exp.hasMatch(thumbnail)) {
        return SizedBox(
          height: 120,
          child: Image.network(thumbnail),
        );
      } else {
        return SizedBox(
          height: 120,
          child: Image.file(File(thumbnail)),
        );
      }
    } else {
      return SizedBox(
        height: 100,
        child: Image.asset(
          'assets/images/no_image.jpg',
        ),
      );
    }
  }

  void onPressedEdit() {}

  void onPressedMemo() {}
}
