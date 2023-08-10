
import 'package:flutter/material.dart';
import 'package:libra_read/constant/constant.dart';
import 'package:libra_read/controller/file_controller.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

// 本を検索・登録するダイアログ
class ImageUploadDialog extends StatefulWidget {
  const ImageUploadDialog({super.key, required this.setImageFile});

  final dynamic setImageFile;

  @override
  State<ImageUploadDialog> createState() => ImageUploadDialogState();
}

class ImageUploadDialogState extends State<ImageUploadDialog> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return SimpleDialog(
      title: const Text('画像の登録方法を選んでください。'),
      children: [
        const Divider(
          height: 1,
        ),
        SimpleDialogOption(
          child: const ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(
              Icons.camera_alt,
            ),
            title: Text('カメラで撮影'),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          onPressed: () {
            appState.setSecondaryCurrentPage(SecondaryPage.pageSearchByBarCode);
            getAndSaveImageFromDevice(ImageSource.camera, context);
          },
        ),
        const Divider(
          height: 1,
        ),
        SimpleDialogOption(
          child: const ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(
              Icons.library_add,
            ),
            title: Text('ライブラリから選択'),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          onPressed: () {
            appState.setSecondaryCurrentPage(SecondaryPage.pageSearchByInput);
            getAndSaveImageFromDevice(ImageSource.gallery, context);
          },
        ),
      ],
    );
  }

// カメラまたはライブラリから画像を取得
  void getAndSaveImageFromDevice(ImageSource source, context) async {
    // 撮影/選択したFileが返ってくる
    var imageFile = await ImagePicker().pickImage(source: source);
    // 撮影せずに閉じた場合はnullになる
    if (imageFile == null) {
      return;
    }

    var savedFile = await FileController.saveLocalImage(imageFile); //追加

    widget.setImageFile(savedFile);

    Navigator.pop(context);
  }
}
