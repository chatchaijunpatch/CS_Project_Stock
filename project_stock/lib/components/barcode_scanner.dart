import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_stock/components/shapespainter.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanner extends StatefulWidget {
  final CameraDescription camera;
  const QrCodeScanner({Key? key, required this.camera}) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  late CameraController _controller;
  Barcode? result;

  QRViewController? controller;
  late Future<void> _initializeControllerFuture;
  @override
  void initState() {
    super.initState();
    checkRequest();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.resumeCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Stack(
    //     alignment: Alignment.center,
    //     children: [
    //       buildQrView(context),
    //     ],
    //   ),
    // );
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      QRView(
                        key: qrkey,
                        onQRViewCreated: onQRViewCreated,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left:50, top: 150, right: 50, bottom: 200),
                        child: Center(
                          child: CustomPaint(
                            painter: PainterOne(),
                            size: Size(size.height, size.width),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: (result != null)
                        ? Text(
                            'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                        : Text('Scan a code'),
                  ),
                )
              ],
            ),
          );

          // Expanded(
          //   flex: 5,
          //   child: QRView(
          //     key: qrkey,
          //     onQRViewCreated: onQRViewCreated,
          //     // overlay: QrScannerOverlayShape(
          //     //   borderRadius: 10,
          //     //   borderLength: 20,
          //     //   borderWidth: 10,
          //     //   cutOutSize: MediaQuery.of(context).size.width * 0.8,
          //     // ),
          //   ),
          // ),
          // Center(
          //   child: Expanded(
          //       flex: 1,
          //       child: CustomPaint(
          //         painter: PainterOne(),
          //         size: Size(size.height, size.width),
          //       )),
          // ),

        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrkey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  checkRequest() async {
    // PermissionStatus camerass = await Permission.camera.request();
    // if (camerass == PermissionStatus.granted) {
    //   print("Hee");
    //   await availableCameras();
    //   _controller = CameraController(
    //       // Get a specific camera from the list of available cameras.
    //       widget.camera,
    //       // Define the resolution to use.
    //       ResolutionPreset.medium,
    //       imageFormatGroup: ImageFormatGroup.yuv420);
    //   // _initializeControllerFuture = _controller.initialize();
    // }
    // await availableCameras();
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    // // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }
}
