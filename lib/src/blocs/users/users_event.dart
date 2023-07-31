part of 'users_bloc.dart';

@immutable
abstract class UsersEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetUsersEvent extends UsersEvent{
}
