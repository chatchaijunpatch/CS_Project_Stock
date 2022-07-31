// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:project_stock/Screens/welcome/components/background.dart';
import 'package:project_stock/constants.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
     Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               Text(
                "STOCKIE",
                style: TextStyle(fontWeight: FontWeight.bold,
                fontFamily: "LEMON",
                color: browntext,
                fontSize: 50),
              ),
                 SizedBox(
                height: size.height * 0.07,
              ),
              // ignore: prefer_const_constructors
              Text(
                "Be your easy store\n to manage your product",
                // ignore: prefer_const_constructors
                style: TextStyle(fontWeight: FontWeight.bold,
                 fontFamily: "LEMONMILK",color: brownSecondaryColor),
                textAlign: TextAlign.center
              ),
          ],
        ),
      ),
    ); }
}
