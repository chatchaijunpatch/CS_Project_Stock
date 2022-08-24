// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_stock/Screens/Welcome/components/background.dart';
import 'package:project_stock/Screens/login/login_screen.dart';
import 'package:project_stock/constants.dart';

import '../../../components/rounded_button.dart';
import '../../../storage/user.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProfile profile = UserProfile();
    final formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size; // This size provide us total height and width of our screen
    return Background(
      child:Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(
                height: size.height * 0.1,
              ),
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
              
              // SvgPicture.asset(
              //   "assets/icons/chat.svg",
              //   height: size.height * 0.45,
              // ),
              SizedBox(
                height: size.height * 0.4,
              ),
              RoundedButton(
                  text: "Get Started",
                  color: brownSecondaryColor,
                  textColor: whitePrimaryColor,
                  press: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  }),
              // RoundedButton(
              //   text: "SIGN UP",
              //   press: () {},
              //   color: kprimaryLightColor,
              //   textColor: Colors.black,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
