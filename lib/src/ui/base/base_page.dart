import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/get_otp/get_otp.dart';

class BaseSubPage extends StatelessWidget {
  final String title;
  final Function onBack;
  final Widget child;
  final IconData suportIcon;
  final Function suportTap;
  final Widget botNar;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  const BaseSubPage({Key key, this.title, this.onBack, this.child, this.botNar, this.suportIcon = null, this.suportTap, this.floatingActionButtonLocation, this.floatingActionButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: botNar,
      body: Container(
          width: size.width,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onBack,
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        size: size.width * 0.06,
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold),
                    ),
                    suportIcon != null ? GestureDetector(
                      onTap: suportTap,
                      child: Icon(
                        suportIcon,
                        size: size.width * 0.06,
                      ),
                    ) :
                    Text("  ")
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: SingleChildScrollView(
                   child: child,
                ),
              )
            ],
          ),
        ),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
    );
  }
}
