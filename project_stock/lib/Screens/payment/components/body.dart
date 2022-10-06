import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_stock/Screens/payment/components/cash_payment.dart';
import 'package:project_stock/Screens/payment/components/payment_scb.dart';

import '../../../components/hero_dialog_route.dart';
import '../../stock/components/cust_react_tween.dart';

class Body extends StatefulWidget {
  int? total;
  Body({Key? key, this.total}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

final auth = FirebaseAuth.instance;

class _BodyState extends State<Body> {
  int? total;
  @override
  void initState() {
    // TODO: implement initState
    total = widget.total;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding:
          const EdgeInsets.only(left: 30, top: 150, right: 30, bottom: 100),
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: "payment_hero",
        child: Row(
          children: [
            Expanded(
              child: Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                color: Colors.white,
                child: ButtonTheme(
                  minWidth: 150.0,
                  height: 150.0,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          HeroDialogRoute(builder: (context) {
                        return CashPayment(
                          total: total,
                        );
                      }));
                    },
                    child: Text("ชำระเงินสด"),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                color: Colors.white,
                child: ButtonTheme(
                  minWidth: 150.0,
                  height: 150.0,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return OnlinePaymentDisplay();
                      }));
                    },
                    child: Text("ชำระด้วย QR"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
