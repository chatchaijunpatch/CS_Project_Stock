// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final Icon lefticon;
  final Icon righticon;
  final Color color;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.color,
    required this.onChanged,
    required this.lefticon,
    required this.righticon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: lefticon,
            hintText: hintText,
            suffixIcon: righticon,
            border: InputBorder.none),
      ),
      color: color,
    );
  }
}
