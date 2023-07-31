import 'package:dio/dio.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/event_status/event_status.dart';
import 'package:ha_tien_app/src/repositories/models/event_types/event_types.dart';
import 'package:ha_tien_app/src/repositories/remote/view_models/paging_request.dart';

import '../api_client.dart';
import '../base_model.dart';
import '../server_error.dart';

class EventStatusesRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  EventStatusesRepo() {
    dio = Dio();
    apiClient = ApiClient(dio);
  }

  EventStatusesRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<List<EventStatus>>> getEventStatuses(
      {PagingRequest pagingRequest, String searchValue}) async {
    List<EventStatus> response;
    try {
      response = await apiClient.getEventStatuses();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
