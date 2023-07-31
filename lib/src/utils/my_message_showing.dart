import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import 'my_colors.dart';

class MyMessageShowing{
  final BuildContext _context;

  MyMessageShowing(this._context);

  void _showMessage(context, String message) {
    if (!context.mounted) return;
    showFlash(
        context: context,
        duration: Duration(seconds: 3),
        builder: (_, controller) {
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            style: FlashStyle.grounded,
            child: FlashBar(
              icon: Icon(
                Icons.face,
                size: 36.0,
                color: Colors.black,
              ),
              message: Text(message),
            ),
          );
        });
  }

  void showCenterFlash({
    String text,
    FlashPosition position,
    FlashStyle style,
    Alignment alignment,
  }) {
    showFlash(
      context: _context,
      duration: Duration(seconds: 5),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.black87,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: kPrimaryColor,
          position: position,
          style: style,
          alignment: alignment,
          enableDrag: false,
          onTap: () => controller.dismiss(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultTextStyle(
              style: TextStyle(color: kWhiteColor),
              child: Text(
                text,
              ),
            ),
          ),
        );
      },
    ).then((_) {
      if (_ != null) {
        _showMessage(_context, _.toString());
      }
    });
  }
}