part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LogInStarted extends LoginEvent {
  final LoginRequest request;

  LogInStarted(this.request);

  @override
  List<Object> get props => throw UnimplementedError();
}

class GetUserInfoEvent extends LoginEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class UpdateUserEvent extends LoginEvent {
  final UpdateUserRequest request;

  UpdateUserEvent(this.request);

  @override
  List<Object> get props => throw UnimplementedError();
}

class ForgotPass extends LoginEvent {
  final String username;

  ForgotPass({this.username});
  @override
  List<Object> get props => [username];
}
