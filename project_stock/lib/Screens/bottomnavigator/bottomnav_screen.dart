import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_stock/Screens/bottomnavigator/components/body.dart';

class MainScreen extends StatelessWidget{
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
          return Scaffold(
            body: Body(),
          );
        }
        return Scaffold(
          body: Body(),
        );
      },
    );
  }
}