import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';

class BigButton extends StatefulWidget {
  final String title;
  final Function ontap;
  const BigButton({Key key, this.title, this.ontap}) : super(key: key);

  @override
  _BigButtonState createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.ontap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
        decoration: BoxDecoration(
            color: Colors.blue.shade600,
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03)
        ),
        child: Center(
          child: Text(widget.title , style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.width * 0.04
          ),),
        ),
      ),
    );
  }
}
