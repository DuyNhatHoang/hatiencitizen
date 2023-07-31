import 'package:dio/dio.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/event_types/event_types.dart';
import 'package:ha_tien_app/src/repositories/remote/view_models/paging_request.dart';

import '../api_client.dart';
import '../base_model.dart';
import '../server_error.dart';

class EventTypesRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  EventTypesRepo() {
    dio = Dio();
    apiClient = ApiClient(dio);
  }

  EventTypesRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<List<EventType>>> getEventTypes(
      {PagingRequest pagingRequest, String searchValue}) async {
    List<EventType> response;
    try {
      response = await apiClient.getEventTypes(
          pagingRequest: pagingRequest, searchValue: searchValue);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
