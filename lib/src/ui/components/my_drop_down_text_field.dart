import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';

class MyActionTextField extends StatelessWidget {
  final onTap;

  final onChanged;

  final labelText;

  final suffixIcon;

  final prefixIcon;

  final controller;

  const MyActionTextField(
      {Key key,
        this.onTap,
        this.onChanged,
        this.labelText,
        this.suffixIcon,
        this.prefixIcon,
        this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        color: Colors.white,
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: controller,
          enabled: false,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.black, fontSize: SizeConfig.screenWidth * 0.04),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.black, )),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.black,)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.black,)),
            hintText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
      // child: FormBuilderTextField(
      //   controller: controller,
      //   readOnly: true,
      //   decoration: InputDecoration(
      //     labelText: labelText,
      //     suffixIcon: suffixIcon ??
      //         Icon(Icons.keyboard_arrow_down, color: kPrimaryColor),
      //     prefixIcon: prefixIcon,
      //   ),
      //   onChanged: onChanged,
      //   attribute: null,
      // ),
    );
  }
}
