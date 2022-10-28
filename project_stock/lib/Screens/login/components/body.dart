// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_stock/Screens/login/components/background.dart';
import 'package:project_stock/Screens/stock/stock_screen.dart';
import 'package:project_stock/components/rounded_button.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';

import '../../../components/already_have_account.dart';
import '../../../components/rounded_password_field.dart';
import '../../../components/rounded_input_field.dart';
import '../../../storage/user.dart';
import '../../bottomnavigator/bottomnav_screen.dart';
import '../../signup/signup_screen.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    UserProfile profile = UserProfile();
    final formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Form(
      key: formKey,
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
              validate: MultiValidator([
                RequiredValidator(errorText: "กรุณาป้อน Email"),
                EmailValidator(errorText: "รูปแบบ Email ไม่ถูกต้อง")
              ]),
              hintText: "Email",
              onChanged: (String? email) {
                profile.email = email!;
              },
              textInputType: TextInputType.emailAddress,
              lefticon: Icon(
                Icons.person,
                color: brownSecondaryColor,
              ),
              color: brownPrimaryColor,
              righticon: Icon(null),
            ),

            new PasswordField(
              hintText: "Password",
              validate: RequiredValidator(errorText: "กรุณาป้อน Password"),
              booleanstate: true,
              color: brownPrimaryColor,
              onChanged: (String? password) {
                profile.password = password!;
              },
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
              press: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  try {
                    print(profile.email);
                    print(profile.password);

                    await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: profile.email.toString(),
                            password: profile.password.toString())
                        .then((value) {
                      formKey.currentState!.reset();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MainScreen();
                      }));
                    });
                  } on FirebaseAuthException catch (e) {
                    Fluttertoast.showToast(
                        msg: e.message!, gravity: ToastGravity.CENTER);

                    print(e.message);
                  }
                }
              },
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
      ),
    ));
  }
}
