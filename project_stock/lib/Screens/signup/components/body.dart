import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_stock/Screens/login/components/background.dart';
import 'package:project_stock/Screens/login/login_screen.dart';
import 'package:project_stock/storage/user.dart';

import '../../../components/already_have_account.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_password_field.dart';
import '../../../components/rounded_input_field.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  // final formKey = GlobalKey<FormState>();
  const Body({
    Key? key,
  }) : super(key: key);

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
            Text("Welcome !",
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
            // RoundedInputField(
            //   hintText: "Username",
            //   validate: RequiredValidator(errorText: "กรุณาป้อน Username"),
            //   onChanged: (String? name) {
            //     profile.name = name!;
            //   },
            //   lefticon: Icon(
            //     Icons.person,
            //     color: brownSecondaryColor,
            //   ),
            //   color: brownPrimaryColor,
            //   righticon: Icon(null),
            //   textInputType: TextInputType.name,
            // ),
            RoundedInputField(
              validate: MultiValidator([
                RequiredValidator(errorText: "กรุณาป้อน Email"),
                EmailValidator(errorText: "รูปแบบ Email ไม่ถูกต้อง"),
              ]),
              hintText: "Email",
              onChanged: (String? email) {
                profile.email = email!;
              },
              lefticon: Icon(
                Icons.person,
                color: brownSecondaryColor,
              ),
              color: brownPrimaryColor,
              righticon: Icon(null),
              textInputType: TextInputType.emailAddress,
            ),

            PasswordField(
              validate: RequiredValidator(errorText: "กรุณาป้อน Password"),
              hintText: "Password",
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

            PasswordField(
              hintText: "Confirm Password",
              validate: RequiredValidator(errorText: "กรุณาป้อน Password"),
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
              text: "SIGN UP NOW",
              press: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  try {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: profile.email, password: profile.password)
                        .then((value) => {
                              formKey.currentState!.reset(),
                              Fluttertoast.showToast(
                                  msg: "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                  gravity: ToastGravity.CENTER),
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              })),
                            });
                  } on FirebaseAuthException catch (e) {
                    String message;
                    print(e.code);
                    if (e.code == "email-already-in-use") {
                      message = 'มีอีเมลนี้ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน';
                    } else if (e.code == 'weak-password') {
                      message = "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
                    } else {
                      message = e.message!;
                    }
                    Fluttertoast.showToast(
                        msg: message, gravity: ToastGravity.CENTER);

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
                      return (LoginScreen());
                    },
                  ),
                );
              },
              login: false,
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
