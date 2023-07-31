import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/%20test_results/test_result.dart';
import 'package:ha_tien_app/src/repositories/models/models.dart';
import 'package:ha_tien_app/src/repositories/models/notification/files.dart';
import 'package:ha_tien_app/src/repositories/models/notification/notification_response.dart';
import 'package:ha_tien_app/src/repositories/models/notification/requests/get_notification_users_request.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:path_provider/path_provider.dart';

import '../api_client.dart';
import '../base_model.dart';
import '../server_error.dart';
import 'package:dio/dio.dart' hide Headers;
class TestResultRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  TestResultRepo() {
    dio = Dio();
    apiClient = ApiClient(dio);
  }

  TestResultRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<TestResult>> getTestResult(String phoneNumber) async {
    TestResult response;
    try {
      response = await apiClient.getTestResult(phoneNumber);
    } catch (e) {
      print("Exception occurredx: $e");
      return BaseModel()..setException(ServerError.withError(error: DioError()));
    }
    return BaseModel()..data = response;
  }

}
