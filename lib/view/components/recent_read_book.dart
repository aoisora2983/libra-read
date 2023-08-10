import 'package:flutter/material.dart';

class RecentReadBook extends StatelessWidget {
  const RecentReadBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // 丸枠書影
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Theme.of(context).hintColor),
            ),
          ),
          Expanded(
            // 書籍情報枠
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(right: 40),
              child: Table(
                children: const [
                  TableRow(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TITLE",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Author",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DescriptionDescriptioDescriptionDescriptioDescriptionDescriptioDescriptionDescriptioDescriptionDescriptioDescriptionDescriptioDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
