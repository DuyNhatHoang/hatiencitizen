import 'dart:io';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/my_message_showing.dart';

import 'my_colors.dart';

class MyConnection {
  final BuildContext _context;
  MyMessageShowing _messageShowing;

  MyConnection(this._context) {
    _messageShowing = MyMessageShowing(_context);
  }

  Future<bool> _isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  Future<bool> checkConnection() async {
    var connected = await _isConnected();
    if (!connected) {
      _messageShowing.showCenterFlash(
          text: "Không có kết nối mạng", alignment: Alignment.center);
      return false;
    }
    return true;
  }
}
