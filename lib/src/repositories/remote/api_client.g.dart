// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://smarthatien.bakco.vn/';
  }

  final Dio _dio;

  String baseUrl;
  String otpUrl = "https://user-management.bakco.vn/";

  @override
  Future<Login> login(loginRequest) async {
    ArgumentError.checkNotNull(loginRequest, 'loginRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(loginRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'api/auth/customer/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Login.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<Employee>> getUsers() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('api/Users/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = EmployeeSwagger.fromJson(_result.data);
    return value.data;
  }

  @override
  Future<void> updateUser(request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    await _dio.request<void>('api/users/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  Future<Session> getInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('api/users/info',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Session.fromJson(_result.data);

    return value;
  }

  @override
  Future<String> postUsers(request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<String>('api/users/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<List<EventOfEmployee>> getEventsNew() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      "pageIndex":  1,
      "pageSize":  10000,
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        'api/Events/GetEventsNew/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => EventOfEmployee.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<UserEvent>> getEvents({pagingRequest, getEventsRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(pagingRequest?.toJson() ?? <String, dynamic>{});
    queryParameters.addAll(getEventsRequest?.toJson() ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('api/Events/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => UserEvent.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<UserEvent>> getEventsPostedByUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('api/Events/PostedByUser',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => UserEvent.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<EventOfEmployee>> getEventsByStatusId(id, searchValue) async {
    ArgumentError.checkNotNull(id, 'status');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'status': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('api/Events/',
        queryParameters: {'status': id, 'searchValue': searchValue},
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => EventOfEmployee.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<EventLog> createEvent(request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('api/Events/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EventLog.fromJson(_result.data);
    return value;
  }

  @override
  Future<EventLog> exchangeEventForUserId(request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'api/Events/Coordinator',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EventLog.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<EventType>> getEventTypes({pagingRequest, searchValue}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'searchValue': searchValue};
    queryParameters.addAll(pagingRequest?.toJson() ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('api/EventTypes/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => EventType.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<EventFiles>> getEventFiles(eventLogId) async {
    ArgumentError.checkNotNull(eventLogId, 'eventLogId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('$eventLogId/Files/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => EventFiles.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<EventLog>> getEventsLogsByEventId(eventId) async {
    ArgumentError.checkNotNull(eventId, 'eventId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'eventId': eventId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        'api/EventsLog/GetByEventId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => EventLog.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<EventLog> createEventLog(request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('api/EventLog/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EventLog.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<EventLogType>> getEventLogType() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        'api/EventLog/eventLogType',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => EventLogType.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<EventStatus>> getEventStatuses() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('api/EventStatus/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => EventStatus.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Employee>> getEmployees() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      "pageIndex":  1,
      "pageSize":  10000,
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('api/Employees/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = EmployeeSwagger.fromJson(_result.data);
    return value.data;
  }

  @override
  Future<void> resetPassword(request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    await _dio.request<void>('https://smarthatien.bakco.vn/api/Users/Password',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  Future<List<NotificationData>> getNotifications({id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('api/Notification/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map(
            (dynamic i) => NotificationData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<int>> downloadFile(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        'api/Notification/File/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl,
            responseType: ResponseType.bytes),
        data: _data);
    final value = _result.data.cast<int>();
    return value;
  }

  @override
  Future<List<NotificationUser>> getNotificationsUser({request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request?.toJson() ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        'api/notificationUser/Filter',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map(
            (dynamic i) => NotificationUser.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<FrequentlyQuestion>> getFrequentlyQuestionByNotificationId(
      {notificationId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'notificationId': notificationId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        'api/FrequentlyQuestion/GetByNotificationId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            FrequentlyQuestion.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<bool> postEventForm(PostingFormData request) async {
    ArgumentError.checkNotNull(request, "request");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((key, value) => value == null);
    final _result = await _dio.request<String>('api/EventForm/',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    if (_result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> formForEmployee(FormForEmployeeRequest request) async {
    ArgumentError.checkNotNull(request, "request");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((key, value) => value == null);
    final _result = await _dio.request<String>('api/EmployeeForm/',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    if (_result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> inviteUserToEvent(InviteEmployeeRequest request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'api/EventsAd/SetEventToUser',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return _result.statusCode == 200;
  }

  @override
  Future<RelatedUserResponse> getRelatedUser(String eventId) async {
    ArgumentError.checkNotNull(eventId, 'eventId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'eventId': eventId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
      'api/Events/RelatedUsers/${eventId}',
      options: RequestOptions(
          method: 'GET',
          headers: <String, dynamic>{},
          extra: _extra,
          baseUrl: baseUrl),
    );
    var value = RelatedUserResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<FormResponse>> getEventFormByEventId(String eventId) async {
    ArgumentError.checkNotNull(eventId, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': eventId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
      'api/EventForm/Event/${eventId}',
      options: RequestOptions(
          method: 'GET',
          headers: <String, dynamic>{},
          extra: _extra,
          baseUrl: baseUrl),
    );
    var value = _result.data
        .map((dynamic i) => FormResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<String> forgotPassword(String username) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final data = await _dio.request<String>('api/Users/ForgotPassword?username=${username}&roleName=Customer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return data.data;
  }

  @override
  Future<String> sendOTPVerification(String phoneNumber) async {
    ArgumentError.checkNotNull(phoneNumber, "phoneNumber");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = phoneNumber;
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data ?? <String, dynamic>{});
    _data.removeWhere((key, value) => value == null);
    final _result = await _dio.request<String>('api/Users/SendOTPVerification?phoneNumber=${phoneNumber}',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return _result.data;
  }

  @override
  Future<String> vertifyOtfOfPhoneNumber(OtpRequest otpRequest) async {
    ArgumentError.checkNotNull(otpRequest, "otpRequest");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(otpRequest.toJson() ?? <String, dynamic>{});
    _data.removeWhere((key, value) => value == null);
    final _result = await _dio.request<String>('api/Users/VerifyOTPOfPhoneNumber',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return _result.data;
  }

  @override
  Future<TestResult> getTestResult(String phoneNumber) async {
    ArgumentError.checkNotNull(phoneNumber, "phoneNumber");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = phoneNumber;
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data ?? <String, dynamic>{});
    _data.removeWhere((key, value) => value == null);
    final _result = await _dio.request<String>('api/Seach/SearchDetailReports',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    List<dynamic> json = jsonDecode(_result.data);
    print("123123213 ${_result.data}");
    print("123123213 ${json.first}");
    var value = json
        .map((dynamic i) => TestResultData.fromJson(i as Map<String, dynamic>))
        .toList();
    print("asdasd ${value.length}");
    TestResult testResult = TestResult();
    testResult.data = value;
    return testResult;
  }

  @override
  Future<String> forgetPassSendOtp(String phoneNumber) async {
    ArgumentError.checkNotNull(phoneNumber, "phoneNumber");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = phoneNumber;
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data ?? <String, dynamic>{});
    _data.removeWhere((key, value) => value == null);
    final _result = await _dio.request<String>('api/Otp/SendOTP?phoneNumber=${phoneNumber}',
    options: RequestOptions(
    method: 'POST',
    headers: <String, dynamic>{},
    extra: _extra,
    baseUrl: baseUrl),
    data: _data);
    print("1222222222 ${_result.data}");
    return _result.data;
  }

  @override
  Future<String> forgetPassVertifyOtp(OtpRequest otpRequest) async {
    ArgumentError.checkNotNull(otpRequest, "otpRequest");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(otpRequest.toJson() ?? <String, dynamic>{});
    _data.removeWhere((key, value) => value == null);
    final _result = await _dio.request<String>('api/Otp/VerifyOTPOfPhoneNumber',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return _result.data;
  }

  @override
  Future<String> resetPassWithPhone(ResetPassRequest request) async {
    ArgumentError.checkNotNull(request, "otpRequest");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson() ?? <String, dynamic>{});
    _data.removeWhere((key, value) => value == null);
    final _result = await _dio.request<String>('api/Users/ResetPasswordWithPhone',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return _result.data;
  }

  @override
  Future<GalleryResponse> getUserGallery(String username) async {
    final _result = await _dio.request<String>(
      username,
      options: RequestOptions(
          method: 'GET',
          headers: <String, dynamic>{},
          baseUrl: baseUrl),
    );
    var value = GalleryResponse.fromJson(jsonDecode(
        "{\"files\":${_result.data}}"
    ));
    return value;
  }

  @override
  Future<void> postEventFiles(String eventLogId, List<String> data) async {
    const _extra = <String, dynamic>{};
    final _result = await _dio.request(
      'https://smarthatien.bakco.vn/${eventLogId}/LinkFile',
      data: data.toString(),
      options: RequestOptions(
          method: 'PUT',
          baseUrl: baseUrl),
    );
    return;
  }

  @override
  Future<Setting> getSetting(String key) async {
    final _result = await _dio.request<String>(
      'api/Setting/Key/${key}',
      options: RequestOptions(
          method: 'GET',
          headers: <String, dynamic>{},
          baseUrl: baseUrl),
    );
    var value = Setting.fromJson(jsonDecode(
        _result.data
    ));
    return value;
  }

  @override
  Future<List<Setting>> getSettings(String groupId) async {
    final _result = await _dio.request<List<dynamic>>(
      'api/Setting?groupId=${groupId}',
      options: RequestOptions(
          method: 'GET',
          headers: <String, dynamic>{},
          baseUrl: baseUrl),
    );
    var value = _result.data
        .map((dynamic i) =>
        Setting.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
