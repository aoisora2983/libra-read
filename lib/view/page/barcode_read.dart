import 'package:flutter/material.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/services.dart';

/// バーコード読み取りページ
class BarcodeRead extends StatefulWidget {
  const BarcodeRead({super.key});

  @override
  State<BarcodeRead> createState() => BarcodeReadState();
}

class BarcodeReadState extends State<BarcodeRead> {
  String readData = "";
  String typeData = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: scan(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return const Placeholder();
      },
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
