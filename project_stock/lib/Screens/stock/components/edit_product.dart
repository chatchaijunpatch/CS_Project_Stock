import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_stock/Screens/stock/components/cust_react_tween.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';
import 'package:project_stock/storage/user.dart';

import '../../../Service/service.dart';
import '../../bottomnavigator/bottomnav_screen.dart';

String _heroAddTodo = 'add-todo-hero';

class EditProductDataPopupCard extends StatefulWidget {
  final dynamic product;
  const EditProductDataPopupCard({Key? key, this.product}) : super(key: key);

  @override
  State<EditProductDataPopupCard> createState() =>
      _EditProductDataPopupCardState();
}

UserProfile profile = UserProfile();

class _EditProductDataPopupCardState extends State<EditProductDataPopupCard> {
  final current = FirebaseAuth.instance.currentUser;
  dynamic p;
  late final String nname;
  late final UserProfile old;
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    p = widget.product!;
    nname = widget.product!['file_name'].toString();
    old = new UserProfile();
    old.product.cost = widget.product!['cost'].toString();
    old.product.description = widget.product!['description'].toString();
    old.product.filename = widget.product!['file_name'].toString();
    old.product.filepath = widget.product!['file_path'].toString();
    old.product.productid = widget.product!['product_id'].toString();
    old.product.productname = widget.product!['product_name'].toString();
    old.product.qrcode = widget.product!['qrcode'].toString();
    old.product.sell = widget.product!['sell'].toString();
    old.product.stock = widget.product!['stock'].toString();
    super.initState();
    fetchDatabaseList();
  }

  changeImage(String name) async {
    String change = await DatabaseService().getImage(name);
    setState(() {
      p['file_name'] = change;
    });
    Image.network(
      p['file_name'],
      height: 200,
      width: 200,
    );
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
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, top: 150, right: 30, bottom: 100),
        child: Hero(
          tag: "EDIT",
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
                              errorBuilder: (context, error, stackTrace) {
                                return Image.file(
                                  File(p['file_path']),
                                  width: 250,
                                  height: 250,
                                  errorBuilder: ((context, error, stackTrace) {
                                    changeImage(p['file_name']);
                                    return Image.network(
                                      p['file_name'].toString(),
                                      width: 250,
                                      height: 250,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      Text(
                        "สร้างรายการสินค้า",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "LEMONMILKBOLD"),
                      ),
                      TextFieldContainer(
                        color: blueTextColor,
                        child: TextFormField(
                          controller: new TextEditingController.fromValue(
                              TextEditingValue(
                                  text: p['product_name'].toString(),
                                  selection: new TextSelection.collapsed(
                                    offset: p['product_name'].toString().length,
                                  ))),
                          decoration: InputDecoration(
                            hintText: 'ชื่อสินค้า',
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.black,
                          validator: RequiredValidator(
                              errorText: 'กรุณาใส่ชื่อสินค้า'),
                          onSaved: (String? productname) {
                            if (productname == null) {
                              profile.product.productname =
                                  p['product_name'].toString();
                            } else {
                              profile.product.productname = productname;
                            }
                          },
                        ),
                      ),
                      TextFieldContainer(
                        color: blueTextColor,
                        child: TextFormField(
                          controller: new TextEditingController.fromValue(
                              TextEditingValue(
                                  text: p['description'].toString(),
                                  selection: new TextSelection.collapsed(
                                    offset: p['description'].toString().length,
                                  ))),
                          decoration: InputDecoration(
                            hintText: 'คำอธิบาย',
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          cursorColor: Colors.black,
                          onSaved: (String? description) {
                            if (description == null) {
                              profile.product.description =
                                  p['description'].toString();
                            } else {
                              profile.product.description = description;
                            }
                          },
                        ),
                      ),
                      TextFieldContainer(
                        color: blueTextColor,
                        child: TextFormField(
                          controller: new TextEditingController.fromValue(
                              TextEditingValue(
                                  text: p['stock'].toString(),
                                  selection: new TextSelection.collapsed(
                                    offset: p['stock'].toString().length,
                                  ))),
                          decoration: InputDecoration(
                            hintText: 'จำนวน',
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          validator: RequiredValidator(
                              errorText: 'กรุณาใส่จำนวนสินค้า'),
                          onSaved: (String? stock) {
                            if (stock == null) {
                              profile.product.stock = p['stock'].toString();
                            } else {
                              profile.product.stock = stock;
                            }
                          },
                        ),
                      ),
                      TextFieldContainer(
                        color: blueTextColor,
                        child: TextFormField(
                          controller: new TextEditingController.fromValue(
                              TextEditingValue(
                                  text: p['cost'].toString(),
                                  selection: new TextSelection.collapsed(
                                    offset: p['cost'].toString().length,
                                  ))),
                          decoration: InputDecoration(
                            hintText: 'ราคาต้นทุน',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          validator:
                              RequiredValidator(errorText: 'กรุณาระบุต้นทุน'),
                          cursorColor: Colors.black,
                          onSaved: (String? cost) {
                            if (cost == null) {
                              profile.product.cost = p['cost'];
                            } else {
                              profile.product.cost = cost;
                            }
                          },
                        ),
                      ),
                      TextFieldContainer(
                        color: blueTextColor,
                        child: TextFormField(
                          controller: new TextEditingController.fromValue(
                              TextEditingValue(
                                  text: p['sell'].toString(),
                                  selection: new TextSelection.collapsed(
                                    offset: p['sell'].toString().length,
                                  ))),
                          decoration: InputDecoration(
                            hintText: 'ราคาขาย',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          validator:
                              RequiredValidator(errorText: 'กรุณาระบุราคาขาย'),
                          cursorColor: Colors.black,
                          onSaved: (String? sell) {
                            if (sell == null) {
                              profile.product.sell = p['sell'];
                            } else {
                              profile.product.sell = sell;
                            }
                          },
                        ),
                      ),

                      // const Divider(
                      //   color: Colors.black,
                      //   thickness: 0.2,
                      // ),
                      // const TextField(
                      //   decoration: InputDecoration(
                      //     hintText: 'Write a note',
                      //     border: InputBorder.none,
                      //   ),
                      //   cursorColor: Colors.black,
                      //   maxLines: 6,
                      // ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.2,
                      ),
                      FlatButton(
                        onPressed: () async {
                          formkey.currentState?.save();
                          if (formkey.currentState?.validate() == true) {
                            formkey.currentState?.save();
                            if (profile.product.filename == null) {
                              profile.product.filename = nname;
                              profile.product.filepath =
                                  p['file_path'].toString();
                            }
                            profile.product.productid =
                                p['product_id'].toString();
                            profile.product.qrcode = p['qrcode'].toString();
                            profile.userid = current!.uid;

                            DatabaseService()
                                .UpdateProduct(profile, old)
                                .then((value) {
                              Fluttertoast.showToast(
                                      msg: "สินค้าถูกแก้ไขเรียบร้อย",
                                      gravity: ToastGravity.CENTER)
                                  .then((value) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) {
                                    return MainScreen(
                                      index: 0,
                                    );
                                  },
                                ));
                              });
                            });
                            formkey.currentState!.reset();
                            setState(() {
                              p['file_path'] =
                                  profile.product.filepath.toString();
                              p['file_name'] =
                                  profile.product.filename.toString();
                              p['sell'] = profile.product.sell.toString();
                              p['cost'] = profile.product.cost.toString();
                              p['stock'] = profile.product.stock.toString();
                              p['description'] =
                                  profile.product.description.toString();
                              p['product_name'] =
                                  profile.product.productname.toString();
                              pathimg = "";
                            });
                          }
                        },
                        color: Colors.black,
                        child: const Text(
                          'แก้ไขสินค้า',
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
      ),
    );
  }
}
