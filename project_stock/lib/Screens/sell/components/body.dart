import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:project_stock/components/barcode_scanner.dart';
import 'package:project_stock/components/hero_dialog_route.dart';
import 'package:project_stock/components/scan_qr.dart';
// import 'package:qrscan/qrscan.dart' as scanner;

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  String? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Text("Heedex"),
          Text(result ?? "Not have value"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cameras = await availableCameras();
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) {
            return QrCodeScanner(
              camera: cameras.first,
            );
          })));
        },
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Colors.red,
      ),
    );
  }

  // startScan() async {
  //   String? cameraResult = await scanner.scan();
  //   setState(() {
  //     result = cameraResult;
  //   });
  // }
}
