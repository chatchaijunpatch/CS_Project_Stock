// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_stock/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  const TextFieldContainer({

    required this.child,
    Key? key, required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
