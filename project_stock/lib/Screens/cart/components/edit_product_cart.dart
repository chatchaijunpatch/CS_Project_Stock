import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

class EditProductCartPopupCard extends StatefulWidget {
  final Cartproduct;
  const EditProductCartPopupCard({Key? key, this.Cartproduct})
      : super(key: key);

  @override
  State<EditProductCartPopupCard> createState() =>
      _EditProductCartPopupCardState();
}

class _EditProductCartPopupCardState extends State<EditProductCartPopupCard> {
  final formkey = GlobalKey<FormState>();
  int backup = 0;
  int amount = 0;
  dynamic product;
  @override
  void initState() {
    product = widget.Cartproduct;
    setState(() {
      amount = int.parse(product['amount']);
      backup = amount;
    });
    // ignore: prefer_interpolation_to_compose_strings
    super.initState();
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
                      onPressed: () {
                        formkey.currentState?.save();
                        if (formkey.currentState?.validate() == true) {
                          if (amount <=
                                  int.parse(
                                      product["product"]['stock'].toString()) &&
                              amount >= 1) {
                            formkey.currentState?.save();
                            backup = amount;
                            DatabaseService()
                                .UpdateAmountProduct(product["cartid"], amount)
                                .then((value) {
                              Fluttertoast.showToast(
                                      msg:
                                          "สินค้า ${product['product']['product_name']} จำนวนเป็น ${amount.toString()} เรียบร้อย",
                                      gravity: ToastGravity.CENTER)
                                  .then((value) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) {
                                    return MainScreen(
                                      index: 1,
                                    );
                                  },
                                ));
                              });
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "จำนวนของในตะกร้ามากกว่าจำนวนในคลัง หรือ น้อยกว่า 1"),
                              ),
                            );
                            setState(() {
                              amount = backup;
                            });
                          }
                        }
                      },
                      color: Colors.black,
                      child: const Text(
                        'ยืนยันการแก้ไข',
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
