part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}
class RegisterSuccess extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterFailure extends RegisterState {
  final ServerError error;

  RegisterFailure(this.error);
  @override
  List<Object> get props => [];
}

class RegisterInProgress extends RegisterState {
  @override
  List<Object> get props => [];
}
