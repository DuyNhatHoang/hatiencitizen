import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final double width;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged, this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFieldContainer(
        child: TextField(
          onChanged: onChanged,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
