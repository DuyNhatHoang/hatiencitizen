import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child:
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
        ),
      ),
    );
  }
}
