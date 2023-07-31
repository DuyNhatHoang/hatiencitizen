import 'package:dio/dio.dart';
import 'package:ha_tien_app/src/repositories/models/auth/login.dart';
import 'package:ha_tien_app/src/repositories/models/auth/otp_request.dart';
import 'package:ha_tien_app/src/repositories/models/auth/reset_pass_request.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/users/create_user_request.dart';
import 'package:ha_tien_app/src/repositories/models/users/update_user_request.dart';
import '../api_client.dart';
import '../base_model.dart';
import '../server_error.dart';
import 'view_models/login_request.dart';

class AuthRepo {
  Dio dio;
  ApiClient apiClient;

  AuthRepo() {
    dio = Dio();
    apiClient = ApiClient(dio);
  }

  AuthRepo.withToken(String accessToken) {
    dio = Dio();
    apiClient = ApiClient.withToken(dio, accessToken);
  }

  Future<BaseModel<Login>> login({LoginRequest loginRequest}) async {
    Login response;
    try {
      response = await apiClient.login(loginRequest);
      if(response.accessToken == null){
        return BaseModel()..setException(ServerError.withError(error: DioError(error: "Tài khoản mật khẩu không hợp lệ")));
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<void>> register({CreateUserRequest request}) async {
    try {
      await apiClient.postUsers(request);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = null;
  }

  Future<BaseModel<Session>> getUserInfo() async {
    Session response;
    try {
      response = await apiClient.getInfo();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<void>> updateUser(UpdateUserRequest request) async {
    try {
      await apiClient.updateUser(request);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = null;
  }

  Future<BaseModel<String>> forgotPassword(String username) async {
    String data;
    try {
      data = await apiClient.forgotPassword(username);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");//p
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = data;
  }
  
  Future<BaseModel<String>> sendOTPVerification(String phoneNumber) async {
    String data;
    try {
      data = await apiClient.sendOTPVerification(phoneNumber);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      print("ServerError.withError(error: error) ${ServerError.withError(error: error).getErrorCode()}");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = data;
  }

  Future<BaseModel<String>> vertifyOtfOfPhoneNumber(String phoneNumber, String otpCode) async {
    String data;
    try {
      data = await apiClient.vertifyOtfOfPhoneNumber(OtpRequest(otpCode: otpCode, phoneNumber: phoneNumber));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = data;
  }

  Future<BaseModel<String>> forgetPassSendOtp(String phoneNumber) async {
    String data;
    try {
      data = await apiClient.forgetPassSendOtp(phoneNumber);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      print("ServerError.withError(error: error) ${ServerError.withError(error: error).getErrorCode()}");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = data;
  }

  Future<BaseModel<String>> forgetPassVertifyPhone(String phoneNumber, String otpCode) async {
    String data;
    try {
      data = await apiClient.forgetPassVertifyOtp(OtpRequest(otpCode: otpCode, phoneNumber: phoneNumber));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = data;
  }

  Future<BaseModel<String>> forgotWithPhone(ResetPassRequest request) async {
    String data;
    try {
      data = await apiClient.resetPassWithPhone(request);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");//p
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = data;
  }

}
