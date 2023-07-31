import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_message_showing.dart';

import 'my_colors.dart';

AppBar buildMyAppBar(
    {title, automaticallyImplyLeading = true, leading, actions, centerTitle}) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    title: Text(
      title,
      style: TextStyle(
        color: kWhiteColor,
      ),
    ),
    automaticallyImplyLeading: automaticallyImplyLeading,
    leading: leading,
    actions: actions,
    centerTitle: centerTitle,
    iconTheme: IconThemeData(
      color: kWhiteColor,
    ),
  );
}

TextStyle myTitleItemStyle() {
  return TextStyle(
    fontSize: Constants.normalFontSize,
    color: kBlackColor,
    fontWeight: FontWeight.bold,
  );
}

TextStyle myHintItemStyle() {
  return TextStyle(
    fontSize: Constants.smallFontSize,
    color: kGrayColor,
  );
}

showSnackBar(BuildContext context, String text) {
  MyMessageShowing(context)
      .showCenterFlash(text: text, alignment: Alignment.center);
}

Widget myEmptyListWidget() {
  return Center(
    child: Text("Trống"),
  );
}


