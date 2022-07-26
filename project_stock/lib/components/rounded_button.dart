import 'package:flutter/material.dart';
import 'package:project_stock/constants.dart';
class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback  press;
  final Color color, textColor;
  final double fontSize;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white, this.fontSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width-200 * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          color: color,
          onPressed: press,
          // ignore: prefer_const_constructors
          child: Text(
            text,
            style: TextStyle(color: textColor,fontFamily: "LEMONMILK",fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
