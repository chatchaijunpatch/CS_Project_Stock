import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_stock/Screens/stock/components/cust_react_tween.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';
import 'package:project_stock/storage/user.dart';

import '../../../Service/service.dart';

String _heroAddTodo = 'add-todo-hero';

class AddProductPopupCard extends StatefulWidget {
  AddProductPopupCard({Key? key}) : super(key: key);

  @override
  State<AddProductPopupCard> createState() => _AddProductPopupCardState();
}

UserProfile profile = UserProfile();

class _AddProductPopupCardState extends State<AddProductPopupCard> {
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    UserProfile resultable = await DatabaseService().CallProfile();
    setState(() {
      profile = resultable;
      // print(profile.username);
    });
  }

  var pathimg = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Center(
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
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Material(
                            // color: Colors.blue,
                            // elevation: 8,
                            // borderRadius: BorderRadius.circular(28),
                            // clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () async {
                                final results = await FilePicker.platform
                                    .pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowCompression: true,
                                        
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
                                  profile.product.filename = fileName;
                                  profile.product.filepath = path;
                                });
                                // storage.uploadFile(path,fileName).then((value) => print("Done"),);
                                // print(fileName);
                                // print(myStudent.storage.filePath+"/"+myStudent.storage.fileName);
                              },
                              child: Image.file(
                                File(pathimg),
                                width: 250,
                                height: 250,
                                errorBuilder: ((context, error, stackTrace) {
                                  // print(pathimg);
                                  return Image(
                                    image: AssetImage("assets/photo.png"),
                                    width: 250,
                                    height: 250,
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
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
                            validator: RequiredValidator(errorText: 'กรุณาใส่ชื่อสินค้า'),
                            onSaved: (String? productname) {
                              profile.product.productname = productname;
                            },
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
                            onSaved: (String? description) {
                              profile.product.description = description;
                            },
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
                            keyboardType: TextInputType.number,
                            validator: RequiredValidator(errorText: 'กรุณาใส่จำนวนสินค้า'),
                            onSaved: (String? stock) {
                              profile.product.stock = stock;
                            },
                          ),
                        ),
                        TextFieldContainer(
                          color: whitePrimaryColor,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'ราคาต้นทุน',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            validator: RequiredValidator(errorText: 'กรุณาระบุต้นทุน'),
                            cursorColor: Colors.white,
                            onSaved: (String? cost) {
                              profile.product.cost = cost;
                            },
                          ),
                        ),
                        TextFieldContainer(
                          color: whitePrimaryColor,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'ราคาขาย',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            validator: RequiredValidator(errorText: 'กรุณาระบุราคาขาย'),
                            cursorColor: Colors.white,
                            onSaved: (String? sell) {
                              profile.product.sell = sell;
                            },
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
                          onPressed: () async {
                            formkey.currentState?.save();
                            if (formkey.currentState?.validate() == true) {
                              formkey.currentState?.save();
                              // print("${profile.product.productname}");
                              // print("${profile.product.filename}");
                              DatabaseService().UploadProduct(profile);
                              formkey.currentState!.reset();
                              setState(() {
                                pathimg = "";
                              });
                            }
                          },
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
      ),
    );
  }
}
