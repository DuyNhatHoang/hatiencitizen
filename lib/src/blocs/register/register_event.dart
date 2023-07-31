part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterStarted extends RegisterEvent {
  final CreateUserRequest request;

  RegisterStarted(this.request);

  @override
  List<Object> get props => throw UnimplementedError();
}
