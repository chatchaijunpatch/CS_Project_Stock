import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_stock/Screens/bottomnavigator/bottomnav_screen.dart';
import 'package:project_stock/Screens/cart/cart_screen.dart';
import 'package:project_stock/Screens/cart/components/display_cart.dart';
import 'package:project_stock/Screens/stock/components/cust_react_tween.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';
import 'package:project_stock/storage/cart.dart';
import 'package:project_stock/storage/user.dart';

import '../../../Service/service.dart';
import '../../../storage/product.dart';

class AddAmountProductToCart extends StatefulWidget {
  final Cartproduct;
  const AddAmountProductToCart({Key? key, this.Cartproduct}) : super(key: key);

  @override
  State<AddAmountProductToCart> createState() => _AddAmountProductToCartState();
}

class _AddAmountProductToCartState extends State<AddAmountProductToCart> {
  UserProfile profile = UserProfile();

  final formkey = GlobalKey<FormState>();
  int amount = 0;
  dynamic product;
  @override
  void initState() {
    product = widget.Cartproduct;
    setState(() {
      amount = 1;
    });
    // ignore: prefer_interpolation_to_compose_strings
    super.initState();
  }

  Future<void> addToCart(dynamic product, int amount) async {
    final current = FirebaseAuth.instance.currentUser;

    Product? p = Product();
    p.qrcode = product!['product']['qrcode'].toString();
    p.description = product!['product']['description'].toString();
    p.cost = product!['product']['cost'].toString();
    p.filename = product!['product']['file_name'].toString();
    p.filepath = product!['product']['file_path'].toString();
    p.productname = product!['product']['product_name'].toString();
    p.sell = product!['product']['sell'].toString();
    p.stock = product!['product']['stock'].toString();
    p.productid = product!['product']['product_id'].toString();
    profile.cart.product = p;
    profile.userid = current!.uid;
    profile.cart.amount = amount.toString();
    await DatabaseService().UploadCart(profile);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 200, right: 10, bottom: 200),
        child: Container(
          width: 500,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "minus",
                              onPressed: () {
                                setState(() {
                                  amount--;
                                });
                              },
                              child: new Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white,
                            ),
                            Expanded(
                              child: TextFieldContainer(
                                color: Colors.white,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 60),
                                  controller:
                                      new TextEditingController.fromValue(
                                          TextEditingValue(
                                              text: amount.toString(),
                                              selection:
                                                  new TextSelection.collapsed(
                                                      offset: amount
                                                          .toString()
                                                          .length))),
                                  decoration: InputDecoration(
                                      // border: OutlineInputBorder(),
                                      ),
                                  onChanged: (String? a) {
                                    setState(() {
                                      if (a != null) {
                                        amount = int.parse(a);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            // Text('${amount}', style: new TextStyle(fontSize: 60.0)),
                            FloatingActionButton(
                              heroTag: "add",
                              onPressed: () {
                                setState(() {
                                  amount++;
                                });
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        formkey.currentState?.save();
                        if (formkey.currentState?.validate() == true) {
                          if (amount <=
                                  int.parse(
                                      product["product"]['stock'].toString()) &&
                              amount >= 1) {
                            formkey.currentState?.save();
                            await addToCart(product, amount).then((value) {
                              Fluttertoast.showToast(
                                  msg:
                                      "เพิ่มสินค้า ${product['product']['product_name']} จำนวนเป็น ${amount.toString()} เรียบร้อย",
                                  gravity: ToastGravity.CENTER);
                              //     .then((value) {
                              //   Navigator.of(context)
                              //       .pushReplacement(MaterialPageRoute(
                              //     builder: (context) {
                              //       return MainScreen(
                              //         index: 0,
                              //       );
                              //     },
                              //   ));
                              // });
                            });
                            // DatabaseService()
                            //     .UpdateAmountProduct(product["cartid"], amount)
                            //     .then((value) {
                            //   Fluttertoast.showToast(
                            //           msg:
                            //               "สินค้า ${product['product']['product_name']} จำนวนเป็น ${amount.toString()} เรียบร้อย",
                            //           gravity: ToastGravity.CENTER)
                            //       .then((value) {
                            //     Navigator.of(context)
                            //         .pushReplacement(MaterialPageRoute(
                            //       builder: (context) {
                            //         return MainScreen(
                            //           index: 1,
                            //         );
                            //       },
                            //     ));
                            //   });
                            // });
                          } else if (amount >
                              int.parse(
                                  product['product']['stock'].toString())) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "จำนวนในการเลือกสินค้ามากกว่าจำนวนในคลัง"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "จำนวนในการเพิ่มสู่ตะกร้าต้องไม่ติดลบหรือศูนย์"),
                              ),
                            );
                          }
                        }
                      },
                      color: Colors.black,
                      child: const Text(
                        'เพิ่มเข้าตะกร้า',
                        style: TextStyle(color: Colors.white),
                      ),
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
