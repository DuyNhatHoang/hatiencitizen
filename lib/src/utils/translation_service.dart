// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper.dart';


class TranslationService {
  SharedPreferences prefs;
  static final languages = [
    'vi',
    'en',
  ];
  List<Map<String, String>> langs =  List<Map<String, String>>();
  Future<TranslationService> init() async{
    languages.forEach((lang) async {
      var _file = await Helper.getJsonFile('assets/locales/$lang.json');
      langs.add(Map<String, String>.from(_file));
    });
    prefs = await SharedPreferences.getInstance();
    return this;
  }
}
