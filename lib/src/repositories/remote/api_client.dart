import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/%20test_results/test_result.dart';
import 'package:ha_tien_app/src/repositories/models/Setting.dart';
import 'package:ha_tien_app/src/repositories/models/auth/login.dart';
import 'package:ha_tien_app/src/repositories/models/auth/otp_request.dart';
import 'package:ha_tien_app/src/repositories/models/auth/reset_pass_request.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/employees/employee.dart';
import 'package:ha_tien_app/src/repositories/models/employees/reset_password_request.dart';
import 'package:ha_tien_app/src/repositories/models/event_file/event_file.dart';
import 'package:ha_tien_app/src/repositories/models/event_file/gallery_response.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/create_event_log_request.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log_type.dart';
import 'package:ha_tien_app/src/repositories/models/event_status/event_status.dart';
import 'package:ha_tien_app/src/repositories/models/event_types/event_types.dart';
import 'package:ha_tien_app/src/repositories/models/events/employee_event.dart';
import 'package:ha_tien_app/src/repositories/models/events/exchange_event_to_employee_id.dart';
import 'package:ha_tien_app/src/repositories/models/events/invite_employee_request.dart';
import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/repositories/models/form/form_response_model.dart';
import 'package:ha_tien_app/src/repositories/models/models.dart';
import 'package:ha_tien_app/src/repositories/models/notification/requests/get_notification_users_request.dart';
import 'package:ha_tien_app/src/repositories/models/users/create_user_request.dart';
import 'package:ha_tien_app/src/repositories/models/users/update_user_request.dart';
import 'package:ha_tien_app/src/repositories/remote/events/view_models/create_event_request.dart';
import 'package:ha_tien_app/src/repositories/remote/events/view_models/get_events_request.dart';
import 'package:ha_tien_app/src/repositories/remote/form/vm/form_for_employee.dart';
import 'package:ha_tien_app/src/repositories/remote/form/vm/posting_form_data.dart';
import 'package:ha_tien_app/src/repositories/remote/view_models/paging_request.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auths/view_models/login_request.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Constants.url)
abstract class ApiClient {
  factory ApiClient(Dio dio) {
    return ApiClient.withToken(dio, null);
  }

  factory ApiClient.withToken(Dio dio, String accessToken) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options = BaseOptions(
        receiveTimeout: Constants.timeOut, connectTimeout: Constants.timeOut);
    dio.options.headers["Authorization"] = "Bearer $accessToken";
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print(
          "----------------------------------------------------------------------------------");
      print("${options.method} : ${options.path}");
      print(Map<String, dynamic>.from(options.headers));
      print(options.data);
      print("Queries: ${Map<String, dynamic>.from(options.queryParameters)}");
      print(
          "----------------------------------------------------------------------------------");
      SessionManager sessionManager =
          SessionManager(await SharedPreferences.getInstance());
      Session session = sessionManager?.getSession();
      if (session != null &&
          session.authorizeDate.isNotEmpty &&
          isExpiredToken(session)) {
        // We use a new Dio(to avoid dead lock) instance to request token.
        dio.interceptors.requestLock.lock();
        Dio tokenDio = Dio();
        (tokenDio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };
        tokenDio.options =
            dio.options; //Create a new instance to request the token.
        Response response = await tokenDio.post(Constants.url + auth + "login",
            data: LoginRequest(
                    username: session.userName, password: session.password)
                .toJson());

        session.accessToken = response.data['access_token'];
        sessionManager.createSession(session);
        options.headers["Authorization"] = "Bearer $accessToken";
        dio.interceptors.requestLock.unlock();
      }
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) async {
      showResponseConsole(response);
      return response; // continue
    }, onError: (DioError e) async {
      print("ERROR: ${e.response?.data}");
      return e; //continue
    }));
    return _ApiClient(dio, baseUrl: Constants.url);
  }

  static const String auth = "api/Auth/Employee/";
  static const String testResult = "api/Seach/SearchDetailReports";
  static const String users = "api/users/";
  static const String otp = "api/otp/";
  static const String events = "api/Events/";
  static const String eventsAdd = "api/EventsAd/";
  static const String eventTypes = "api/EventTypes/";
  static const String files = "Files/";
  static const String eventsLog = "api/EventsLog/";
  static const String eventLog = "api/EventLog/";
  static const String eventStatus = "api/EventStatus/";
  static const String employees = "api/Employees/";
  static const String notifications = "api/Notification/";
  static const String notificationUser = "api/notificationUser/";
  static const String frequentlyQuestion = "api/FrequentlyQuestion/";
  static const String eventForm = "api/EventForm/";
  static const String eventFormByEventId = "api/EventForm/Event/";
  static const String formForEmployees = "api/EmployeeForm";

  // Accounts
  @POST(auth + "Login")
  Future<Login> login(@Body() LoginRequest loginRequest);

  //Users
  @GET(users)
  Future<List<Employee>> getUsers();

  @PUT(users)
  Future<void> updateUser(@Body() UpdateUserRequest request);

  @GET(users + "info")
  Future<Session> getInfo();

  @POST(users)
  Future<String> postUsers(@Body() CreateUserRequest request);

//  Events
  @GET(events + "GetEventsNew/")
  Future<List<EventOfEmployee>> getEventsNew();

  @GET(events)
  Future<List<UserEvent>> getEvents(
      {@Queries() PagingRequest pagingRequest,
      @Queries() GetEventsRequest getEventsRequest});

  @GET(events + "PostedByUser")
  Future<List<UserEvent>> getEventsPostedByUser();

  @GET(events + "Events")
  Future<List<EventOfEmployee>> getEventsByStatusId(
      @Query('eventStatus') int id,   @Query('searchValue') String searchValue);

  @GET(events + "RelatedUsers/")
  Future<RelatedUserResponse> getRelatedUser(@Query('eventId') String eventId);

  @POST(events)
  Future<EventLog> createEvent(@Body() CreateEventRequest request);

  @POST(events + "Coordinator")
  Future<EventLog> exchangeEventForUserId(
      @Body() ExchangeEventToEmployeeIdRequest request);

  @POST(eventsAdd + "SetEventToUser")
  Future<bool> inviteUserToEvent(@Body() InviteEmployeeRequest request);

  // EventType
  @GET(eventTypes)
  Future<List<EventType>> getEventTypes(
      {@Queries() PagingRequest pagingRequest,
      @Query("searchValue") String searchValue});

  // @PUT('{eventLogId}/' + files)
  // @MultiPart()
  // Future<List<UpdatedFile>> updateEventFiles(
  //     @Path() eventLogId, @Part() List<File> files);
  @GET('{eventLogId}/' + files)
  Future<List<EventFiles>> getEventFiles(@Path() String eventLogId);

// EventsLog
  @GET(eventsLog + "GetByEventId")
  Future<List<EventLog>> getEventsLogsByEventId(
      @Query("eventId") String eventId);

  @POST(eventLog)
  Future<EventLog> createEventLog(@Body() CreateEventLogRequest request);

  @GET(eventLog + "eventLogType")
  Future<List<EventLogType>> getEventLogType();

  // EventStatus
  @GET(eventStatus)
  Future<List<EventStatus>> getEventStatuses();

  // Employees
  @GET(employees)
  Future<List<Employee>> getEmployees();

  @PUT(employees + "ResetPassword")
  Future<void> resetPassword(@Body() ResetPasswordRequest request);

  // Notifications
  @GET(notifications)
  Future<List<NotificationData>> getNotifications({@Query('id') String id});

  // Notification/File
  @GET(notifications + "File/{id}")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadFile(@Path() String id);

  // NotificationUser
  @GET(notificationUser + "Filter")
  Future<List<NotificationUser>> getNotificationsUser(
      {@Queries() GetNotificationUsesrRequest request});

  // FrequentlyQuestion
  @GET(frequentlyQuestion + "GetByNotificationId")
  Future<List<FrequentlyQuestion>> getFrequentlyQuestionByNotificationId(
      {@Query('notificationId') String notificationId});
  // form
  @POST(eventForm)
  Future<bool> postEventForm(@Body() PostingFormData request);

  @POST(formForEmployees)
  Future<bool> formForEmployee(@Body() FormForEmployeeRequest request);

  @GET(eventFormByEventId + "id")
  Future<List<FormResponse>> getEventFormByEventId(@Query("id") String eventId);

  @PUT(users + "ForgotPassword")
  Future<String> forgotPassword(@Query("username") String username);

  @POST(users + "SendOTPVerification")
  Future<String> sendOTPVerification(@Body() String phoneNumber);

  @POST(users + "VerifyOTPOfPhoneNumber")
  Future<String> vertifyOtfOfPhoneNumber(@Body() OtpRequest otpRequest);

  @GET(testResult + "phoneNumber")
  Future<TestResult> getTestResult(@Query("phoneNumber") String phoneNumber);

  @POST(otp + "Sendotp")
  Future<String> forgetPassSendOtp(@Body() String phonenumber);

  @POST(otp + "VerifyOTPOfPhoneNumber")
  Future<String> forgetPassVertifyOtp(@Body() OtpRequest otpRequest);

  @POST(users + "ResetPasswordWithPhone")
  Future<String> resetPassWithPhone(@Body() ResetPassRequest request);

  Future<GalleryResponse> getUserGallery(String username);

  Future<void> postEventFiles(String eventLogId,  List<String> data);
  @GET("api/Setting/Key/hotline")
  Future<Setting> getSetting(String key);
  @GET("api/Setting")
  Future<List<Setting>> getSettings(String groupId);
}
