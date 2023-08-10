import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:libra_read/view/components/image_upload_dialog.dart';
import 'package:provider/provider.dart';

/// 本の入力画面
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  File? imageFile;

  final TextEditingController titleController =
      TextEditingController(text: ''); // タイトル
  final TextEditingController authorController =
      TextEditingController(text: ''); // 著者
  final TextEditingController publishedController =
      TextEditingController(text: ''); // 出版年
  final TextEditingController isbnController =
      TextEditingController(text: ''); // ISBN
  final TextEditingController descriptionController =
      TextEditingController(text: ''); // 概要
  final TextEditingController memoController =
      TextEditingController(text: ''); // メモ

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              // thumbnail
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ImageUploadDialog(
                          setImageFile: setImageFile,
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    height: 120,
                    child: getThumbnail(), // カメラと画像UP機能
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DataTable(
                  columnSpacing: 20,
                  headingRowHeight: 0,
                  dataRowMaxHeight: double.infinity,
                  columns: [
                    const DataColumn(
                      label: SizedBox(
                        width: 60,
                        child: Text(''),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: MediaQuery.of(context).size.width - 90,
                        child: const Text(''),
                      ),
                    ),
                  ],
                  rows: [
                    createRow('タイトル', titleController, true),
                    createRow('著者', authorController, true),
                    createRow('出版年', publishedController, false),
                    createRow('ISBN', isbnController, false),
                    createRow('概要', descriptionController, true),
                    createRow('メモ', memoController, true),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.lock();
                  try {
                    onPressedRegister(
                      context,
                    );
                    Navigator.of(context).pop();
                    appState.unlock();
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('エラー'),
                          content: const Text('登録できませんでした。'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('登録する'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.backspace_outlined),
                label: const Text('戻る'),
              )
            ],
          ),
        )
      ],
    );
  }

  DataRow createRow(
      String label, TextEditingController controller, bool isMultiLine) {
    return DataRow(
      cells: [
        DataCell(Text(label)),
        DataCell(
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 145,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                controller: controller,
                keyboardType:
                    isMultiLine ? TextInputType.multiline : TextInputType.text,
                maxLines: null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onPressedRegister(
    context,
  ) async {
    // データバリデーション
    String errorMessage = "";
    // タイトル入力チェック
    if (titleController.text.isEmpty) {
      errorMessage += "タイトルは必須入力項目です。\n";
    }
    // ISBNの形式が正しいか
    if (isbnController.text.isNotEmpty) {
      RegExp exp = RegExp(r'^[0-9-]{9-16}[0-9X]');
      // ISBNと-と数字だけで構成されているか
      if (!exp.hasMatch(isbnController.text)) {
        errorMessage += "ISBNの形式が誤っています。\nハイフンと数字以外が入っています。";
      } else {
        // ISBNと-を抜いた桁数が10桁か13桁になっているか
        String tmpIsbn = isbnController.text;
        tmpIsbn.replaceAll('-', '');
        if (tmpIsbn.length != 10 && tmpIsbn.length != 13) {
          errorMessage = "ISBNの形式が誤っています。";
        }
      }
    }

    if (errorMessage.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('エラー'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              )
            ],
          );
        },
      );
    } else {
      try {
        register(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('登録完了'),
              content: const Text('登録しました。'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                )
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('エラー'),
              content: const Text('登録できませんでした。'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                )
              ],
            );
          },
        );
      }
    }
  }

  void register(context) async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    await database.into(database.booksDao.books).insert(
          BooksCompanion.insert(
            idGoogle: 'LOCAL',
            title: titleController.text,
            author: Value(authorController.text),
            published: Value(publishedController.text),
            description: Value(descriptionController.text),
            isbn: Value(isbnController.text),
            memo: Value(memoController.text),
            thumbnail: Value(imageFile?.path),
          ),
        );
  }

  void setImageFile(File imageFile) {
    setState(() {
      this.imageFile = imageFile;
    });
  }

  Widget getThumbnail() {
    if (imageFile == null) {
      return Image.asset('assets/images/no_image.jpg');
    } else {
      return Image.memory(imageFile!.readAsBytesSync());
    }
  }
}
