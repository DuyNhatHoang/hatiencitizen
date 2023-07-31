import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';

import 'bloc.dart';

class ForgetPassBloc extends Bloc<ForgetPassEvent, ForgetPassState> {
  final AuthRepo authRepo;
  ForgetPassBloc({this.authRepo}) : super(ForgetPassInitial());

  @override
  ForgetPassState get initialState => ForgetPassInitial();

  @override
  Stream<ForgetPassState> mapEventToState(
    ForgetPassEvent event,
  ) async* {
    if(event is SendOTPE){
      yield ForgetPassSendOtdLoading();
      var result = await authRepo.forgetPassSendOtp(event.phoneNumber);
      if(result.getException != null){
        ServerError error =  result.getException;
        yield ForgetPassSendOtpError(error.getErrorMessage());
      }  else{
        yield ForgetPassSendOtpLoaded();
      }
    } else
    if(event is VertifyOtpE){
      yield ForgetPassVertifyOtpLoading();
      var result = await authRepo.forgetPassVertifyPhone(event.phoneNumber, event.otp);
      if(result.getException != null){
        ServerError error =  result.getException;
        yield ForgetPassVertifyOtpError(error.getErrorMessage());
      }  else{
        yield ForgetPassVertifyOtpLoaded(result.data);
      }
    } else
    if(event is ResetPassE){
      yield ForgetPassResetPassLoading();
      var result = await authRepo.forgotWithPhone(event.request);
      if(result.getException != null){
        ServerError error =  result.getException;
        yield ForgetPassResetPassError(error.getErrorMessage());
      }  else{
        yield ForgetPassResetPassLoaded();
      }
    }
  }
}
