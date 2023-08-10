import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:provider/provider.dart';

//
class TextEditingDialog extends StatefulWidget {
  const TextEditingDialog({
    Key? key,
    this.text,
    required this.keywordController,
    required this.onSetGoal,
  }) : super(key: key);
  final String? text;
  final TextEditingController keywordController;
  final dynamic onSetGoal;

  @override
  State<TextEditingDialog> createState() => TextEditingDialogState();
}

class TextEditingDialogState extends State<TextEditingDialog> {
  final focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    widget.keywordController.text = widget.text ?? '0';
    focusNode.addListener(
      () {
        // フォーカスが当たったときに文字列が選択された状態にする
        if (focusNode.hasFocus) {
          widget.keywordController.selection = TextSelection(
              baseOffset: 0,
              extentOffset: widget.keywordController.text.length);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      content: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 16.0,
          right: 16.0,
        ),
        child: TextFormField(
          keyboardType: TextInputType.number,
          autofocus: true, // ダイアログが開いたときに自動でフォーカスを当てる
          focusNode: focusNode,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: widget.keywordController,
          onFieldSubmitted: (_) {
            // エンターを押したときに実行される
            setGoal(int.parse(widget.keywordController.text));
          },
          decoration: const InputDecoration(
              labelText: '目標冊数',
              errorMaxLines: 2,
              contentPadding: EdgeInsets.all(4)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '目標冊数を入力してください。';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // 目標値設定
            setGoal(int.parse(widget.keywordController.text));
            Navigator.pop(context);
          },
          child: const Text('完了'),
        )
      ],
    );

    return dialog;
  }

  void setGoal(int? goal) {
    int tmpGaol = 0;
    if (goal != null) {
      tmpGaol = goal;
    }

    final database = Provider.of<AppDatabase>(context, listen: false);
    database.goalsReadDao.setGoal(tmpGaol);
    widget.onSetGoal();
  }
}
