import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_stock/Screens/stock/components/cust_react_tween.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';

String _heroAddTodo = 'add-todo-hero';

class AddProductPopupCard extends StatefulWidget {
  AddProductPopupCard({Key? key}) : super(key: key);

  @override
  State<AddProductPopupCard> createState() => _AddProductPopupCardState();
}

class _AddProductPopupCardState extends State<AddProductPopupCard> {
  var pathimg = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
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
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                          child: ElevatedButton(
                        onPressed: () async {
                          final results = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['png', 'jpg']);
                          if (results == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("No file select"),
                              ),
                            );
                            return null;
                          }
                          final path = results.files.single.path!;
                          final fileName = results.files.single.name;
                          // myStudent.storage.fileName = fileName;
                          // myStudent.storage.filePath = path;
                          //  myStudent.storage.filePath = path;

                          setState(() {
                            pathimg = path;
                          });
                          // storage.uploadFile(path,fileName).then((value) => print("Done"),);
                          // print(fileName);
                          // print(myStudent.storage.filePath+"/"+myStudent.storage.fileName);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent
                        ),
                        child: Image.file(
                          File(pathimg),
                          width: 200,
                          height: 200,
                          errorBuilder: ((context, error, stackTrace) {
                            print(pathimg);
                            return Image(
                              image: AssetImage("assets/photo.png"),
                              width: 200,
                              height: 200,
                            );
                          }),
                        ),
                      )),
                      // Center(
                      //   child: Image.file(File(pathimg),
                      //       width: 200, height: 200, errorBuilder: (
                      //     context,
                      //     error,
                      //     stackTrace,
                      //   ) {
                      //     return Image(
                      //       image: AssetImage('assets/photo.png'),
                      //       width: 200,
                      //       height: 200,
                      //     );
                      //   }),
                      // ),
                      Text(
                        "สร้างรายการสินค้า",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "LEMONMILKBOLD"),
                      ),
                      TextFieldContainer(
                        color: whitePrimaryColor,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'ชื่อสินค้า',
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.white,
                        ),
                      ),
                      TextFieldContainer(
                        color: whitePrimaryColor,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'คำอธิบาย',
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.white,
                        ),
                      ),
                      TextFieldContainer(
                        color: whitePrimaryColor,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'จำนวน',
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.white,
                        ),
                      ),

                      // const Divider(
                      //   color: Colors.white,
                      //   thickness: 0.2,
                      // ),
                      // const TextField(
                      //   decoration: InputDecoration(
                      //     hintText: 'Write a note',
                      //     border: InputBorder.none,
                      //   ),
                      //   cursorColor: Colors.white,
                      //   maxLines: 6,
                      // ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
