import 'package:flutter/material.dart';
import 'package:project_stock/Screens/Welcome/welcome_screen.dart';
import 'package:project_stock/constants.dart';
import 'package:project_stock/screens/login/login_screen.dart';
import 'package:project_stock/screens/splash/splaspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          ),
      home: SplashPage(duration:5,goToPage:WelcomeScreen()),
    );
  }
}
