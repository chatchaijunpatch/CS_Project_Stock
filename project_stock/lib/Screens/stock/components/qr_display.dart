import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_stock/Screens/stock/components/cust_react_tween.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';
import 'package:project_stock/storage/user.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../Service/service.dart';

String _heroAddTodo = 'add-todo-hero';

class QrProductDisply extends StatefulWidget {
  String? qrcode;
  QrProductDisply({Key? key, this.qrcode}) : super(key: key);
  @override
  State<QrProductDisply> createState() => _QrProductDisplyState();
}

UserProfile profile = UserProfile();

class _QrProductDisplyState extends State<QrProductDisply> {
  String? code;
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    code = widget.qrcode;
  }

  fetchDatabaseList() async {
    UserProfile resultable = await DatabaseService().CallProfile();
    setState(() {
      profile = resultable;

      // print(profile.username);
    });
  }

  final qrKey = GlobalKey();
  void takeScreenShot() async {
    PermissionStatus res;
    res = await Permission.storage.request();
    if (res.isGranted) {
      final boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // We can increse the size of QR using pixel ratio
      final image = await boundary.toImage(pixelRatio: 5.0);
      final byteData = await (image.toByteData(format: ImageByteFormat.png));
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        // getting directory of our phone
        final directory = (await getApplicationDocumentsDirectory()).path;
        final imgFile = File(
          '$directory/${DateTime.now()}${widget.qrcode}.png',
        );
        imgFile.writeAsBytes(pngBytes);
        GallerySaver.saveImage(imgFile.path).then((success) async {
          //In here you can show snackbar or do something in the backend at successfull download
        });
      }
    }
  }

  var pathimg = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, top: 150, right: 30, bottom: 100),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Material(
                          // color: Colors.blue,
                          // elevation: 8,
                          // borderRadius: BorderRadius.circular(28),
                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: RepaintBoundary(
                              key: qrKey,
                              child: QrImage(
                                data: code.toString(),
                                backgroundColor: Colors.white,
                              ))),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.2,
                    ),
                    FlatButton(
                      onPressed: takeScreenShot,
                      color: Colors.black,
                      child: const Text(
                        'บันทึกรูปภาพ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
