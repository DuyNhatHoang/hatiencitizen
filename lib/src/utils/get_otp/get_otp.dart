import 'package:flutter/services.dart';


Future<String> getMessage() async {
  var platform = MethodChannel('bakco.hatien.otp');
  try {
    final String result = await platform.invokeMethod('receiveMessage');
    print('receiveMessage $result');
    return result;
  } on PlatformException catch (e) {
    print("Failed to receiveMessage: '${e.message}'.");
  }
  return "";
}