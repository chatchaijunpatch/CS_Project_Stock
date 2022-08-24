// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final Icon lefticon;
  final Icon righticon;
  final TextInputType textInputType;
  final Color color;
  final Function(String?) onChanged;
  final String? Function(String?)? validate ;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.color,
    required this.onChanged,
    required this.lefticon,
    required this.righticon, required this.textInputType, required this.validate ,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: validate,
        onSaved: onChanged,
        keyboardType: textInputType,
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
