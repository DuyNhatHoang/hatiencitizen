part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthStarted extends AuthEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AuthLoggedIn extends AuthEvent {
  final Session session;

  AuthLoggedIn(this.session);

  @override
  List<Object> get props => [session];
}

class AuthLoggedOut extends AuthEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SendOTPE extends AuthEvent {
  final String phoneNumber;

  SendOTPE(this.phoneNumber);
  @override
  List<Object> get props => [phoneNumber];
}

class VertifyOTP extends AuthEvent {
  final String phoneNumber;
  final String otpCode;

  VertifyOTP(this.phoneNumber, this.otpCode);
  @override
  List<Object> get props => [phoneNumber, otpCode];
}
