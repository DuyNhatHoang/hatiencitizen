import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/Setting.dart';
import 'package:ha_tien_app/src/repositories/models/models.dart';
import 'package:ha_tien_app/src/repositories/models/notification/files.dart';
import 'package:ha_tien_app/src/repositories/models/notification/notification_response.dart';
import 'package:ha_tien_app/src/repositories/models/notification/requests/get_notification_users_request.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:path_provider/path_provider.dart';

import '../api_client.dart';
import '../base_model.dart';
import '../server_error.dart';

class SettingRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  SettingRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<Setting>> getSetting(
      String request) async {
    Setting response;
    try {
      response = await apiClient.getSetting(request);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

}
