import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/blocs/auth/auth_bloc.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/users/update_user_request.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/view_models/login_request.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo repo;
  final AuthBloc authBloc;

  LoginBloc(this.repo, this.authBloc) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LogInStarted) {
      yield LoginInProgress();
      var data = await repo.login(loginRequest: event.request);
      if (data.getException == null) {
        var session = Session.fromLogin(data.data);
        session.password = event.request.password;
        session.authorizeDate = DateTime.now().toString();
        authBloc.add(AuthLoggedIn(session));
        yield LoginSuccess();
      } else {
        yield LoginFailure(data.getException);
      }
    } else if (event is GetUserInfoEvent) {
      yield GetUserInfoInProgress();
      var data = await repo.getUserInfo();
      if (data.getException == null) {
        yield GetUserInfoSuccess(data.data);
      } else {
        yield GetUserInfoFailure(data.getException);
      }
    } else if (event is UpdateUserEvent) {
      yield UpdateUserInProgress();
      var data = await repo.updateUser(event.request);
      if (data.getException == null) {
        yield UpdateUserSuccess();
      } else {
        yield UpdateUserFailure(data.getException);
      }
    } else if(event is ForgotPass){
      yield ForgotPassInProgress();
      var data = await repo.forgotPassword(event.username);
      if(data.getException != null){
        yield ForgotPassFailure(data.getException);
      }  else{
        yield ForgotPassSuccess(data.data);
      }
    }
  }
}
