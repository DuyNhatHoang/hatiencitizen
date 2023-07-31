import 'package:dio/dio.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';
import 'package:ha_tien_app/src/repositories/remote/base_model.dart';

import '../api_client.dart';
import '../server_error.dart';

class UserRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  UserRepo() {
    dio = Dio();
    apiClient = ApiClient(dio);
  }

  UserRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<List<Employee>>> getUsers() async {
    List<Employee> response;
    try {
      response = await apiClient.getUsers();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
