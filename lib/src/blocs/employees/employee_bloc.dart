import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/employees/reset_password_request.dart';
import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';
import 'package:ha_tien_app/src/repositories/remote/employees/employees_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeesBloc extends Bloc<EmployeeEvent, EmployeesState> {
  final EmployeesRepo repo;

  EmployeesBloc(this.repo) : super(EmployeeInitial());

  @override
  Stream<EmployeesState> mapEventToState(
    EmployeeEvent event,
  ) async* {
    if (event is GetEmployeesEvent) {
      yield GetEmployeesInProgress();
      var data = await repo.getEmployees();
      if (data.getException == null) {
        yield GetEmployeesSuccess(data.data);
      } else {
        yield GetEmployeesFailure(data.getException);
      }
    } else if (event is ResetPasswordEvent) {
      yield ResetPasswordInProgress();
      var data = await repo.resetPassword(event.request);
      if (data.getException == null) {
        yield ResetPasswordSuccess();
      } else {
        yield ResetPasswordFailure(data.getException);
      }
    }
  }
}
