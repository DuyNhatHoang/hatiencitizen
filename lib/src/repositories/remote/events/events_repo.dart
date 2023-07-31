import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/event_file/event_file.dart';
import 'package:ha_tien_app/src/repositories/models/event_file/gallery_response.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/events/employee_event.dart';
import 'package:ha_tien_app/src/repositories/models/events/exchange_event_to_employee_id.dart';
import 'package:ha_tien_app/src/repositories/models/events/invite_employee_request.dart';
import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';
import 'package:ha_tien_app/src/repositories/models/events/updated_file.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/repositories/remote/events/view_models/get_events_request.dart';
import 'package:ha_tien_app/src/repositories/remote/view_models/paging_request.dart';

import '../api_client.dart';
import '../base_model.dart';
import '../server_error.dart';
import 'view_models/create_event_request.dart';

class EventsRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  EventsRepo() {
    dio = Dio();
    apiClient = ApiClient(dio);
  }

  EventsRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<List<EventOfEmployee>>> getEventsNew() async {
    List<EventOfEmployee> response;
    try {
      response = await apiClient.getEventsNew();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<GalleryResponse>> getGalleryFiles(String userName) async {
    GalleryResponse galleryResponse;
    try {
      galleryResponse = await apiClient.getUserGallery(userName);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = galleryResponse;
  }

  Future<BaseModel<List<UserEvent>>> getEvents(
      {GetEventsRequest getEventsRequest, PagingRequest pagingRequest}) async {
    List<UserEvent> response;
    try {
      response = await apiClient.getEvents(
          pagingRequest: pagingRequest, getEventsRequest: getEventsRequest);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<EventLog>> createEvent(CreateEventRequest request) async {
    EventLog response;
    try {
      response = await apiClient.createEvent(request);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<UserEvent>>> getEventsPostedByUser() async {
    List<UserEvent> response;
    try {
      response = await apiClient.getEventsPostedByUser();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<void>> updateFiles(
      String eventLogId, List<String> files) async {
    Response response;
    try {
      print("updateFiles ${files.length}");
      dio.clear();
      await apiClient.postEventFiles(eventLogId, files);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = null;
  }
  Future<BaseModel<List<EventFiles>>> getEventFiles(String eventLogId) async {
    List<EventFiles> response;
    try {
      response = await apiClient.getEventFiles(eventLogId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<EventOfEmployee>>> getEventsByStatusId(
      int statusId, String searchValue) async {
    List<EventOfEmployee> response;
    try {
      response = await apiClient.getEventsByStatusId(statusId, searchValue);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<EventLog>> exchangeEventToEmployeeId(
      ExchangeEventToEmployeeIdRequest request) async {
    EventLog response;
    try {
      response = await apiClient.exchangeEventForUserId(request);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<bool>> inviteEmployeeToEvent(
      InviteEmployeeRequest request) async {
    bool response;
    try {
      response = await apiClient.inviteUserToEvent(request);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<RelatedUserResponse>> getRelateUserEvent(String id) async {
    RelatedUserResponse response;
    try {
      response = await apiClient.getRelatedUser(id);
      print("getRelateUserEvent repo ${response.owner}");
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
