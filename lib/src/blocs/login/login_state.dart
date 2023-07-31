part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  final ServerError error;

  LoginFailure(this.error);
  @override
  List<Object> get props => [];
}

class LoginInProgress extends LoginState {
  @override
  List<Object> get props => [];
}

class GetUserInfoSuccess extends LoginState {
  final Session data;

  GetUserInfoSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetUserInfoFailure extends LoginState {
  final ServerError error;

  GetUserInfoFailure(this.error);

  @override
  List<Object> get props => [];
}

class GetUserInfoInProgress extends LoginState {
  @override
  List<Object> get props => [];
}

class UpdateUserSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class UpdateUserFailure extends LoginState {
  final ServerError error;

  UpdateUserFailure(this.error);

  @override
  List<Object> get props => [];
}

class UpdateUserInProgress extends LoginState {
  @override
  List<Object> get props => [];
}

class ForgotPassSuccess extends LoginState {
  final String data;

  ForgotPassSuccess(this.data);
  @override
  List<Object> get props => [data];
}

class ForgotPassInProgress extends LoginState {
  @override
  List<Object> get props => [];
}

class ForgotPassFailure extends LoginState {
  final ServerError data;

  ForgotPassFailure(this.data);
  @override
  List<Object> get props => [data];
}
