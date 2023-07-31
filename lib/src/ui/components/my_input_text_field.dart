import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';

class MyInputTextField extends StatelessWidget {
  final onChanged;

  final labelText;

  final suffixIcon;

  final prefixIcon;

  final controller;

  final int line;

  const MyInputTextField(
      {Key key,
        this.onChanged,
        this.labelText,
        this.suffixIcon,
        this.prefixIcon,
        this.controller, this.line = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: line,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey)),
            hintText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon),
      ),
    );
  }
}
