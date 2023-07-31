part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthInProgress extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthFailure extends AuthState {
  @override
  List<Object> get props => [];
}

class OTPSuccess extends AuthState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OTPLoading extends AuthState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OTPError extends AuthState{
  final ServerError error;

  OTPError(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}


class VertifyOTPSuccess extends AuthState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class VertifyOTPLoading extends AuthState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class VertifyOTPError extends AuthState{
  final ServerError error;

  VertifyOTPError(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}