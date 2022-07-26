// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_stock/Screens/login/components/background.dart';
import 'package:project_stock/components/rounded_button.dart';
import 'package:project_stock/constants.dart';

import '../../../components/already_have_account.dart';
import '../../../components/rounded_input_field.dart';

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
          Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SvgPicture.asset(
            "assets/icons/login.svg",
            height: size.height * 0.35,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (value) {},
            iconData: Icons.person,
            color: kprimaryLightColor,
            icon: Icon(null),
            booleanstate: false,
          ),
          RoundedInputField(
            hintText: "",
            booleanstate: true,
            color: kprimaryLightColor,
            onChanged: (value) {},
            iconData: Icons.lock,
            icon: Icon(
              Icons.visibility,
              color: kPrimaryColor,
            ),
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {},
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAccount(
            press: () {},
          )
        ],
      ),
    ));
  }
}
