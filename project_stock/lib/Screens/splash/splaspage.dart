import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_stock/Screens/stock/stock_screen.dart';
import 'package:project_stock/screens/splash/components/body.dart';

class SplashPage extends StatelessWidget {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  int duration = 0;
  Widget goToPage;
  SplashPage({required this.duration, required this.goToPage});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: this.duration), () {
      Navigator.push(
            context, MaterialPageRoute(builder: (context) => this.goToPage));
      // if (FirebaseAuth.instance.currentUser != null) {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => StockPage()));
      // }
      // else{
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => this.goToPage));
      // }
    });
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Body(),
    );
  }
}
