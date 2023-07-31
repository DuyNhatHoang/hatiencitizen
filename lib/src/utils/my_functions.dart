import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/ui/base/dialog/button/big_button.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

Future<File> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return new File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

bool isExpiredToken(Session session) {
  var time = DateTime.parse(session.authorizeDate);
  var expiresIn = session.expiresIn;
  // var expiresIn = 10;
  var expiresInDay = Duration(seconds: expiresIn);
  var expires = time.add(expiresInDay);
  if (DateTime.now().compareTo(expires) > 0) {
    return true;
  } else
    return false;
}

void showOverWeightDialog(BuildContext context){
  showDialog<void>(
    context: context,
    // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Dung lượng video tải lên không quá 40MB',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        content: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.34,
          child: Column(
            children: [
              Image.asset(
                "assets/illustration/failed_inslutration.png",
                height: SizeConfig.screenHeight * 0.2,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              BigButton(
                title: "Trở lại",
                ontap: (){
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
            ],
          ),
        ),
      );
    },
  );
}


String convertDateTimeToVN(String dateTime) {
  try {
    var converted = DateTime.parse(dateTime);
    return "Ngày ${converted.day}-${converted.month}-${converted.year} lúc ${converted.hour}:${converted.minute} ";
  } catch (e) {
    return "";
  }
}

String convertDateTime(String dateTime) {
  try {
    var converted = DateTime.parse(dateTime);
    return "${converted.hour}:${converted.minute} ${converted.day}-${converted.month}-${converted.year}";
  } catch (e) {
    print("convertDateTimeToVN e ${e}");
    return "";
  }
}

String convertDistanceVN(int kmDistance) {
  return "$kmDistance km";
}

String getWardFromAddress(String address, String street) {
  List<String> arr = address.split(',');
  int indexOfStreet = arr.indexWhere((element) => element.contains(street));
  String ward = arr[indexOfStreet + 1];
  return ward.substring(1);
}

Future<SessionManager> loadSession() async {
  return SessionManager(await SharedPreferences.getInstance());
}

Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
    BuildContext context, String assetName, Color color) async {
  String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
  //Draws string representation of svg to DrawableRoot
  DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, svgString);
  ui.Picture picture = svgDrawableRoot.toPicture(
      size: Size(Constants.widthOfMarker, Constants.heightOfMarker),
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
  // colorFilter: ColorFilter.mode(color, BlendMode.modulate));
  // ui.Image image = await picture.toImage(26, 37);
  ui.Image image = await picture.toImage(
      Constants.widthOfMarker.toInt(), Constants.heightOfMarker.toInt());

  ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
}

showResponseConsole(Response response) {
  if (response.data is Map<dynamic, dynamic>) {
    var data = Map<String, dynamic>.from(response.data);
    print(data);
  } else if (response.data is List<dynamic>) {
    var data = List.from(response.data);
    // print("RESPONSE: $data");
  }
}

double getKeyboardHeight(double height) {
  return height * 2.0 / 5;
}

Future download2(Dio dio, String url, String savePath) async {
  try {
    dio.download(
      url,
      savePath,
      onReceiveProgress: (rcv, total) {
        // print(
        //     'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');
        //
        // setState(() {
        //   progress = ((rcv / total) * 100).toStringAsFixed(0);
        // });
        //
        // if (progress == '100') {
        //   setState(() {
        //     isDownloaded = true;
        //   });
        // } else if (double.parse(progress) < 100) {}
      },
      deleteOnError: true,
    ).then((_) {
      // setState(() {
      //   if (progress == '100') {
      //     isDownloaded = true;
      //   }
      //
      //   downloading = false;
      // });
    });
  } catch (e) {
    print(e);
  }
}

bool validateEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
