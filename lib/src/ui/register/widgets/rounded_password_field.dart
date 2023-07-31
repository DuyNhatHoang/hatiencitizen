import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'components/text_field_container.dart';


class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final double width;
  final String title;
  const RoundedPasswordField({
    Key key,
    this.onChanged, this.width, this.title,
  }) : super(key: key);
  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
   var myController = TextEditingController();
   bool isVisible = true;

   void changeVisibility(){
     setState(() {
       isVisible = !isVisible;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: TextFieldContainer(
        child: TextField(
          obscureText: isVisible,
          onChanged: widget.onChanged,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: widget.title,
            fillColor: Colors.lightBlue,
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Icon(
                    isVisible? Icons.visibility: Icons.visibility_off,
                    color: kPrimaryColor,
                  ),
                  onTap: () => {
                    changeVisibility()
                  },
                )
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
