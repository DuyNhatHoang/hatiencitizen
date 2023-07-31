
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = Colors.black12,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.02),
        width: size.width * 0.5,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white  ),
          ),
        )
      ),
    );
  }
}
