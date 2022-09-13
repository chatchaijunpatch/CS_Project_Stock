// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// import '../Screens/stock/components/cust_react_tween.dart';

// class ScanQR extends StatefulWidget {
//   ScanQR({Key? key}) : super(key: key);

//   @override
//   State<ScanQR> createState() => _ScanQRState();
// }

// class _ScanQRState extends State<ScanQR> {
//   // String _heroAddTodo = 'add-todo-hero';

//   // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   // Barcode? barcode;
//   // QRViewController? controller;
//   // @override
//   // void dispose() {
//   //   controller?.dispose();
//   //   super.dispose();
//   // }

//   // @override
//   // void reassemble() {
//   //   super.reassemble();
//   //   if (Platform.isAndroid) {
//   //     controller!.pauseCamera();
//   //   } else if (Platform.isIOS) {
//   //     controller!.resumeCamera();
//   //   }
//   // }

//   // void readQr() async {
//   //   if (barcode != null) {
//   //     controller!.pauseCamera();
//   //     controller!.dispose();
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // readQr();
//     return SafeArea(
//         child: Padding(
//       padding: EdgeInsets.only(left: 0, top: 120, right: 0, bottom: 80),
//       child: Hero(
//         tag: _heroAddTodo,
//         createRectTween: (begin, end) {
//           return CustomRectTween(begin: begin!, end: end!);
//         },
//         child: Material(
//           color: Colors.white,
//           elevation: 2,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Expanded(child: buildQrView(context)),
//                 // Positioned(
//                 //   bottom: 10,
//                 //   child: buildResult(),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ));

//   }

//   Widget buildResult() {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(8)),
//       child: Text(
//         barcode != null ? 'Result : ${barcode!.code}' : "Scan a code!",
//         maxLines: 3,
//       ),
//     );
//   }

//   Widget buildQrView(BuildContext context) {
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: onQRViewCreated,
//     );
//   }

//   void onQRViewCreated(QRViewController controller) {
//     setState(() => this.controller = controller);
//     controller.scannedDataStream.listen((scanData) {
//       setState(() => barcode = scanData);
//     });
//   }
// }
