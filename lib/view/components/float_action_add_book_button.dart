import 'package:flutter/material.dart';
import 'package:libra_read/view/components/register_book_dialog.dart';

/// 登録ダイアログ表示ボタン
class FloatingActionAddBookButton extends StatelessWidget {
  const FloatingActionAddBookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const RegisterBookDialog();
          },
        );
      },
      tooltip: "本を登録する",
      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
