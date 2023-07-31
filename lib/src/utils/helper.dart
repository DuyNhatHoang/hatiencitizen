// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class Helper {
  DateTime currentBackPressTime;

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }
  static Future<dynamic> getFilesInDirectory(String path) async {
    var files = io.Directory(path).listSync();
    print(files);
    // return rootBundle.(path).then(convert.jsonDecode);
  }

  static String toUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

}
