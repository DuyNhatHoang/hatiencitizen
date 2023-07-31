part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class GetEmployeesEvent extends EmployeeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ResetPasswordEvent extends EmployeeEvent {
  final ResetPasswordRequest request;

  ResetPasswordEvent(this.request);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
