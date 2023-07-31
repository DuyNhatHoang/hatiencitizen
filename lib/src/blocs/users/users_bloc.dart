import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';
import 'package:ha_tien_app/src/repositories/remote/users/user_repo.dart';
import 'package:meta/meta.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepo repo;

  UsersBloc(this.repo) : super(InitialUsersState());

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is GetUsersEvent) {
      yield GetUsersInProgress();
      var data = await repo.getUsers();
      if (data.getException == null) {
        print("lay thong tin user thanh cong ${data.data.length}");
        yield GetUserSuccess(data.data);
      } else {
        yield GetUserFailure(data.getException);
      }
    }
  }
}
