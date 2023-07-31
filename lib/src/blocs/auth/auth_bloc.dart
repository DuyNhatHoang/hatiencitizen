import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/auth/login.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/view_models/login_request.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo repo;
  AuthBloc({this.repo}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    SessionManager sessionManager =
    SessionManager(await SharedPreferences.getInstance());
    if (event is AuthStarted) {
      yield AuthInProgress();
      Session session = sessionManager.getSession();
      if (session != null && session.authorizeDate != null) {
        if (isExpiredToken(session)) {
          SessionManager sessionManager =
          SessionManager(await SharedPreferences.getInstance());
          sessionManager.removeSession();
          yield AuthFailure();
        } else yield AuthSuccess();
      } else
        yield AuthFailure();
    } else if (event is AuthLoggedIn) {
      await sessionManager.createSession(event.session);
      yield AuthSuccess();
    } else if (event is SendOTPE) {
      yield OTPLoading();
      var result = await repo.sendOTPVerification(event.phoneNumber);
      if(result.getException != null){
        yield OTPError(result.getException);
      }  else{
        yield OTPSuccess();
      }
    } else if (event is VertifyOTP) {
      yield VertifyOTPLoading();
      var result = await repo.vertifyOtfOfPhoneNumber(event.phoneNumber, event.otpCode);
      if(result.getException != null){
        yield VertifyOTPError(result.getException);
      }  else{
        yield VertifyOTPSuccess();
      }
    }
  }
}
