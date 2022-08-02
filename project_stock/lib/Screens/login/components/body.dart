// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_stock/Screens/login/components/background.dart';
import 'package:project_stock/components/rounded_button.dart';
import 'package:project_stock/constants.dart';

import '../../../components/already_have_account.dart';
import '../../../components/rounded_password_field.dart';
import '../../../components/rounded_input_field.dart';
import '../../signup/signup_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.25,
          ),
          Text(
            "STOCKIE",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "LEMON",
                color: whitePrimaryColor,
                fontSize: 50),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: size.height * 0.2,
          ),
          // SvgPicture.asset(
          //   "assets/icons/login.svg",
          //   height: size.height * 0.35,
          // ),
          Text("LOG IN",
              // ignore: prefer_const_constructors
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "LEMONMILK",
                  color: browntext,
                  fontSize: 30),
              textAlign: TextAlign.center),

          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputField(
            hintText: "Email or Username",
            onChanged: (value) {},
            lefticon: Icon(
              Icons.person,
              color: brownSecondaryColor,
            ),
            color: brownPrimaryColor,
            righticon: Icon(null),
          ),
         PasswordField(
            hintText: "Password",
            booleanstate: true,
            color: brownPrimaryColor,
            onChanged: (value) {},
            lefticon: Icon(
              Icons.lock,
              color: brownSecondaryColor,
            ),
            righticon: Icon(
              Icons.visibility,
              color: brownSecondaryColor,
            ),
          ),
          RoundedButton(
            text: "LOG IN NOW",
            press: () {},
            color: brownSecondaryColor,
            fontSize: 20,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAccount(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return (SignUpScreen());
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
        ],
      ),
    ));
  }
}
