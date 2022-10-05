import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_stock/Service/payment.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

class OnlinePaymentDisplay extends StatefulWidget {
  OnlinePaymentDisplay({Key? key}) : super(key: key);

  @override
  State<OnlinePaymentDisplay> createState() => _OnlinePaymentDisplayState();
}

final auth = FirebaseAuth.instance;

class _OnlinePaymentDisplayState extends State<OnlinePaymentDisplay> {
  var uuid = Uuid();
  String? token;
  @override
  void initState() {
    postPayment();
    super.initState();
  }

  postPayment() async {
    dynamic access =
        await accessToken(uuid.v4().toString()).then((value) async {
      await generateMaemaneePaymentQRcode(
              uuid.v4().toString(), value.toString())
          .then((code) {
        setState(() {
          token = code;
        });
      });
    });
  }

  displayQR() {
    if (token != null) {
      return Image.memory(base64Decode(token.toString()));
    } else {
      Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            alignment: Alignment.center,
            // child: Text(token.toString()),
            child: displayQR()));
  }
}
