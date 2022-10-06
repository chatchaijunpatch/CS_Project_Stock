import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_stock/Screens/payment/components/body.dart';

class PaymentScreen extends StatelessWidget {
  int? total;
  PaymentScreen({Key? key, this.total}) : super(key: key);
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("ERROR"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: Body(
              total: total,
            ),
          );
        }
        return Scaffold(
          body: Container(),
        );
      },
    );
  }
}
