import 'package:dio/dio.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/employees/reset_password_request.dart';
import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';

import '../api_client.dart';
import '../base_model.dart';
import '../server_error.dart';

class EmployeesRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  EventsRepo() {
    dio = Dio();
    apiClient = ApiClient(dio);
  }

  EmployeesRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<List<Employee>>> getEmployees() async {
    List<Employee> response;
    try {
      response = await apiClient.getEmployees();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<void>> resetPassword(ResetPasswordRequest request) async {
    try {
      await apiClient.resetPassword(request);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = null;
  }
}
