import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/users/create_user_request.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepo repo;
  RegisterBloc(this.repo) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is RegisterStarted){
      yield RegisterInProgress();
      var data = await repo.register(request: event.request);
      if(data.getException == null){
        yield RegisterSuccess();
      }else {
        yield RegisterFailure(data.getException);
      }
    }
  }
}
