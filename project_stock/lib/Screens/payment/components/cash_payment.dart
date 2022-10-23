import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_stock/Service/service.dart';
import 'package:project_stock/components/text_field_container.dart';

import '../../bottomnavigator/bottomnav_screen.dart';
import '../../stock/components/cust_react_tween.dart';

class CashPayment extends StatefulWidget {
  int? total;
  CashPayment({Key? key, this.total}) : super(key: key);

  @override
  State<CashPayment> createState() => _CashPaymentState();
}

final auth = FirebaseAuth.instance;
int cash = 0;

class _CashPaymentState extends State<CashPayment> {
  int? total;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    total = widget.total;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: formKey,
      child: Center(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 30, top: 150, right: 30, bottom: 100),
        child: Hero(
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          tag: "cash_hero",
          child: Center(
              child: Container(
            width: size.width * 0.7,
            height: size.height * 0.5,
            padding: EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              elevation: 10,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text('ราคาสินค้าทั้งหมด',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0)),
                    Text('฿ ' + total.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0)),
                    TextFieldContainer(
                        // ignore: sort_child_properties_last
                        child: TextFormField(
                          // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                          onSaved: (String? c) {
                            cash = int.parse(c.toString());
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'จำนวนเงินที่รับมา',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        color: Colors.transparent),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: () {
                        formKey.currentState?.save();
                        if (formKey.currentState!.validate()) {
                          DatabaseService()
                              .UploadHistory(null, "payment")
                              .then((value) {
                            Fluttertoast.showToast(
                                    msg: "ทอนทั้งหมด" +
                                        (cash - total!.toInt()).toString(),
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
                        }
                      },
                      child: Text("ยืนยันการชำระเงิน"),
                      color: Colors.red,
                    )
                    // ButtonBar(
                    //   children: <Widget>[
                    //     RaisedButton(
                    //       child: const Text('Play'),
                    //       onPressed: () {/* ... */},
                    //     ),
                    //     RaisedButton(
                    //       child: const Text('Pause'),
                    //       onPressed: () {/* ... */},
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          )),
        ),
      )),
    );
  }
}
