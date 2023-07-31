part of 'users_bloc.dart';

@immutable
abstract class UsersState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialUsersState extends UsersState {}

class GetUsersInProgress extends UsersState {}

class GetUserSuccess extends UsersState {
  final List<Employee> data;

  GetUserSuccess(this.data);
  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class GetUserFailure extends UsersState {
  final ServerError error;

  GetUserFailure(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
