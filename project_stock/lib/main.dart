import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_stock/Screens/Welcome/welcome_screen.dart';
import 'package:project_stock/Screens/stock/stock_screen.dart';
import 'package:project_stock/constants.dart';
import 'package:project_stock/screens/login/login_screen.dart';
import 'package:project_stock/screens/splash/splaspage.dart';

import 'Screens/bottomnavigator/bottomnav_screen.dart';

void main() {
  runApp(const MyApp());
}

Widget screen(FirebaseAuth auth) {
  if (auth.currentUser != null) {
    return MainScreen();
  } else {
    return WelcomeScreen();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> firebase = Firebase.initializeApp();
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
            final auth = FirebaseAuth.instance;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(),
              home: SplashPage(duration: 5, goToPage: screen(auth)),
              // home: LoginScreen(),
              // home: MainScreen(),
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
