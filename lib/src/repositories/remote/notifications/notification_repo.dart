import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/models.dart';
import 'package:ha_tien_app/src/repositories/models/notification/files.dart';
import 'package:ha_tien_app/src/repositories/models/notification/notification_response.dart';
import 'package:ha_tien_app/src/repositories/models/notification/requests/get_notification_users_request.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:path_provider/path_provider.dart';

import '../api_client.dart';
import '../base_model.dart';
import '../server_error.dart';

class NotificationRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  NotificationRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<List<NotificationUser>>> getNotificationUsers(
      GetNotificationUsesrRequest request) async {
    List<NotificationUser> response;
    try {
      response = await apiClient.getNotificationsUser(request: request);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<NotificationData>>> getNotificationById(
      String id) async {
    List<NotificationData> response;
    try {
      response = await apiClient.getNotifications(id: id);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<int>>> downloadFile(Files file) async {
    List<int> response;
    try {
      // var tempDir = await getApplicationDocumentsDirectory();
      var tempDir = await getApplicationDocumentsDirectory();

      String fullPath = tempDir.path + "/${file.fileName}";
      // make sure it exists
      download2(
          dio,
          "https://smarthatien.bakco.vn/api/Notification/File/${file.id}",
          fullPath);
      // response = await apiClient.downloadFile(id);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
