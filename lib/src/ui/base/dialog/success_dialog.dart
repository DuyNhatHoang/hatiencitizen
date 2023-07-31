

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';

import 'button/big_button.dart';

void showAppSuccesDialog(BuildContext context, {String title = "", Function mainTap, Function subTap,
String mainTitle = "", String subTitle = "" , barrierDismissible = true}) {
  showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Center(
          child: Text(
            '${title}',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        content: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.4,
          child: Column(
            children: [
              Image.asset(
                "assets/illustration/success_inslustration.png",
                height: SizeConfig.screenHeight * 0.2,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              BigButton(
                title: mainTitle,
                ontap: mainTap,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              InkWell(
                onTap: () {
                  subTap();
                },
                child: Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

