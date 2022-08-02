// ignore_for_file: sort_child_properties_last, unused_label, use_function_type_syntax_for_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';

var obscureText = false;

class PasswordField extends StatefulWidget {
  final String hintText;
  final bool booleanstate;
  final Color color;
  final Icon lefticon;
  final Icon righticon;
  final ValueChanged<String> onChanged;
  const PasswordField({
    Key? key,
    required this.hintText,
    required this.color,
    required this.onChanged,
    required this.righticon,
    required this.booleanstate,
    required this.lefticon,
  }) : super(key: key);
  @override
  _PasswordField createState() => _PasswordField();
  @override
  void initState() {
    obscureText = booleanstate;
  }
}

class _PasswordField extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: obscureText, //เป็นรูปแบบ password visible
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.lefticon,
          border: InputBorder.none,
          suffixIcon: GestureDetector(
              // child: widget.righticon,
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: obscureText
                  ? const Icon(
                      Icons.visibility_off,
                      color: brownSecondaryColor,
                    )
                  : widget.righticon),
        ),
      ),
      color: widget.color,
    );
  }
}
