import 'package:flutter/material.dart';
import 'package:project_stock/screens/splash/components/body.dart';
class SplashPage extends StatelessWidget {
  int duration = 0;
  Widget goToPage;
  SplashPage({required this.duration,required this.goToPage});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: this.duration),(){
      Navigator.push(context, MaterialPageRoute(builder:  (context)=>this.goToPage));
    });
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Body(),
    ); }
}
