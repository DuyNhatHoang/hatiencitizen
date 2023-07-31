import 'package:dio/dio.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/form/form_response_model.dart';
import 'package:ha_tien_app/src/repositories/remote/api_client.dart';
import 'package:ha_tien_app/src/repositories/remote/base_model.dart';
import 'package:ha_tien_app/src/repositories/remote/form/vm/form_for_employee.dart';
import 'package:ha_tien_app/src/repositories/remote/form/vm/posting_form_data.dart';

import '../server_error.dart';

class FormRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  FormRepo() {
    dio = Dio();
    apiClient = ApiClient(dio);
  }

  FormRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<bool>> postForm(PostingFormData postingFormData) async {
    bool response;
    try {
      response = await apiClient.postEventForm(postingFormData);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<FormResponse>>> getForm(String id) async {
    List<FormResponse> response;
    try {
      response = await apiClient.getEventFormByEventId(id);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<bool>> formForEmployees(
      FormForEmployeeRequest forEmployeeRequest) async {
    bool response;
    try {
      response = await apiClient.formForEmployee(forEmployeeRequest);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
