import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_stock/Screens/Welcome/welcome_screen.dart';
import 'package:project_stock/Screens/stock/components/display_product.dart';
import 'package:project_stock/Screens/stock/stock_screen.dart';
import 'package:project_stock/constants.dart';
import 'package:project_stock/screens/login/login_screen.dart';
import 'package:project_stock/screens/splash/splaspage.dart';

import 'Screens/bottomnavigator/bottomnav_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "CS-PROJECT",
    options: FirebaseOptions(
        apiKey:
            "AAAAqCvF0Vc:APA91bGM7fe0ZAGZ2t8aFA4z2dLzSo7vQG5SLMmw8eY8pUJU_wdEgDUSYCzkPno3C05U_6hltCK46XPG8ls8n14GG-0w6aYxUIb2bll2wqR3JZGPDoaZCdXk-1gmQpxzQUc84a5nVsEF",
        appId: "1:722288890199:android:33ea29f9b3fe9bccd42e12",
        messagingSenderId: "722288890199",
        projectId: "cs-project-8aa15",
        storageBucket: "gs://cs-project-8aa15.appspot.com/"),
  );
  // await FirebaseAppCheck.instance.
  await FirebaseAppCheck.instance.getToken();
  await FirebaseAppCheck.instance.activate();
  // await FirebaseAppCheck.instance.activate();

  runApp(MyApp());
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
              // home: DisplayProduct(),
              // home: MainScreen(),
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
