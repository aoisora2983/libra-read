import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libra_read/constant/constant.dart';
import 'package:libra_read/provider/app_state.dart';
import 'package:libra_read/view/page/barcode_read.dart';
import 'package:libra_read/view/page/register.dart';
import 'package:libra_read/view/page/search_by_input.dart';
import 'package:libra_read/view/secondary.dart';
import 'package:provider/provider.dart';

// 本を検索・登録するダイアログ
class RegisterBookDialog extends StatefulWidget {
  const RegisterBookDialog({super.key});

  @override
  State<RegisterBookDialog> createState() => RegisterBookDialogState();
}

class RegisterBookDialogState extends State<RegisterBookDialog> {
  String readData = "";
  String typeData = "";

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return SimpleDialog(
      title: const Text('本を登録する方法を選んでください。'),
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
            title: Text('バーコード読み込み'),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          onPressed: () {
            appState.setSecondaryCurrentPage(SecondaryPage.pageSearchByBarCode);
            openBarcodeReader(context);
          },
        ),
        const Divider(
          height: 1,
        ),
        SimpleDialogOption(
          child: const ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(
              Icons.search,
            ),
            title: Text('タイトルや作者から探す'),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          onPressed: () {
            appState.setSecondaryCurrentPage(SecondaryPage.pageSearchByInput);
            openSearchByInput(context);
          },
        ),
        const Divider(
          height: 1,
        ),
        SimpleDialogOption(
          child: const ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(
              Icons.edit,
            ),
            title: Text('タイトルや作者を入力する'),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          onPressed: () {
            appState.setSecondaryCurrentPage(SecondaryPage.pageRegisterBook);
            openRegister(context);
          },
        )
      ],
    );
  }

  void openRegister(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const SecondaryView(
          pageIndex: SecondaryPage.pageRegisterBook,
          page: Register(),
        );
      }),
    );
  }

  void openSearchByInput(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const SecondaryView(
          pageIndex: SecondaryPage.pageSearchByInput,
          page: SearchByInputView(),
        );
      }),
    );
  }

  void openBarcodeReader(context) async {
    await scan();
    print(readData);
    print(typeData);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const SecondaryView(
          pageIndex: SecondaryPage.pageSearchByBarCode,
          page: BarcodeRead(),
        );
      }),
    );
  }

  Future scan() async {
    try {
      var scan = await BarcodeScanner.scan();
      setState(() => {
            readData = scan.rawContent,
            typeData = scan.format.name,
          });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          readData = 'Camera permissions are not valid.';
        });
      } else {
        setState(() => readData = 'Unexplained error : $e');
      }
    } on FormatException {
      setState(() => readData =
          'Failed to read (I used the back button before starting the scan).');
    } catch (e) {
      setState(() => readData = 'Unknown error : $e');
    }
  }
}
