import 'package:flutter/material.dart';

import '../constants.dart';

class AlreadyHaveAccount extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAccount({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          login ? "Don't have an Account ? " : "Already have an Account ? ",
          style: TextStyle(color: browntext),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign UP" : "Sign IN",
            style: TextStyle(color: browntext, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
