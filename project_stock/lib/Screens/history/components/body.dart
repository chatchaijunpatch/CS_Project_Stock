import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_stock/Screens/history/components/history_add_product.dart';
import 'package:project_stock/Screens/history/components/history_payment_product.dart';

import 'history_eidt_product.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

final auth = FirebaseAuth.instance;

class _BodyState extends State<Body> {
  List text = ['การเพิ่มสินค้า', "การแก้ไขสินค้า", "การชำระสินค้า"];
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    index = 0;
    super.initState();
  }

  PageShow(int index) {
    if (index == 0) {
      return HistoryAddProduct();
    } else if (index == 1) {
      return HistoryEditProduct();
    } else if (index == 2) {
      return HistoryPayment();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // width: size.width * 0.7,
      // height: size.height * 0.5,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text(text[index]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      child: Text("การเพิ่มสินค้า")),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          index = 1;
                        });
                      },
                      child: Text("การแก้ไข")),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          index = 2;
                        });
                      },
                      child: Text("การชำระเงิน"))
                ],
              ),
              PageShow(index),
            ],
          ),
        ),
      ),
    );
  }
}
