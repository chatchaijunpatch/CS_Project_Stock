import 'package:flutter/material.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final bool booleanstate;
  final Color color;
  final Icon icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.iconData,
    required this.color,
    required this.onChanged,
    required this.icon,
    required this.booleanstate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: booleanstate,
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(
              iconData,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            suffixIcon: icon,
            border: InputBorder.none),
      ),
    );
  }
}
