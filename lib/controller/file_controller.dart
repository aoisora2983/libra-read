import 'dart:async';
import 'dart:io'; // 追加
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileController {
  // get local path
  static Future get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 画像をドキュメントへ保存する。
  static Future saveLocalImage(XFile image) async {
    final path = await localPath;
    final imagePath = '$path/image.png';
    File imageFile = File(imagePath);
    // カメラで撮影した画像は撮影時用の一時的フォルダパスに保存されるため、その画像をドキュメントへ保存し直す。
    var savedFile = await imageFile.writeAsBytes(await image.readAsBytes());

    return savedFile; // file object
  }

  // ドキュメントの画像を取得する。
  static Future loadLocalImage() async {
    final path = await localPath;
    final imagePath = '$path/image.png';
    return File(imagePath);
  }
}
