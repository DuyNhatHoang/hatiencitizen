import 'package:dio/dio.dart' hide Headers;
import 'package:ha_tien_app/src/utils/my_widget.dart';

class ServerError implements Exception {
  int _errorCode;
  String _errorMessage = "";

  ServerError.withError({DioError error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        _errorMessage = "Request was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.DEFAULT:
        _errorMessage = "Connection failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.RESPONSE:
        _errorCode = error.response.statusCode;
        _errorMessage =
            // "Received invalid status code: ${error.response.statusCode}";
            "Vấn đề: ${error.response.data}";
        break;
      case DioErrorType.SEND_TIMEOUT:
        _errorMessage = "Receive timeout in send request";
        break;
    }
    print("lỗi ${_errorMessage}");
    return _errorMessage;
  }
}
