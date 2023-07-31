import 'package:dio/dio.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/create_event_log_request.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log_type.dart';
import 'package:ha_tien_app/src/repositories/models/event_types/event_types.dart';
import 'package:ha_tien_app/src/repositories/remote/view_models/paging_request.dart';

import '../api_client.dart';
import '../base_model.dart';
import '../server_error.dart';

class EventLogsRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  EventLogsRepo() {
    dio = Dio();
    apiClient = ApiClient(dio);
  }

  EventLogsRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<List<EventLog>>> getEventLogsByEventId(
      String eventId) async {
    List<EventLog> response;
    try {
      response = await apiClient.getEventsLogsByEventId(eventId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<EventLog>> createEventLog(
      CreateEventLogRequest request) async {
    EventLog response;
    try {
      response = await apiClient.createEventLog(request);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<EventLogType>>> getEventLogType() async {
    List<EventLogType> response;
    try {
      response = await apiClient.getEventLogType();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
