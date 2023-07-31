import 'package:dio/dio.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/frequently_question/frequently_question.dart';

import '../api_client.dart';
import '../base_model.dart';
import '../server_error.dart';

class FrequentlyQuestionRepo {
  Dio dio;
  ApiClient apiClient;
  SessionManager sessionManager;

  FrequentlyQuestionRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<List<FrequentlyQuestion>>>
      getFrequentlyQuestionByNotificationId(String id) async {
    List<FrequentlyQuestion> response;
    try {
      response = await apiClient.getFrequentlyQuestionByNotificationId(
          notificationId: id);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
