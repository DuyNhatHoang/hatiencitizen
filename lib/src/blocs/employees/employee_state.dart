part of 'employee_bloc.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();
}

class EmployeeInitial extends EmployeesState {
  @override
  List<Object> get props => [];
}

class GetEmployeesInProgress extends EmployeesState {
  @override
  List<Object> get props => [];
}

class GetEmployeesSuccess extends EmployeesState {
  final List<Employee> data;

  GetEmployeesSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetEmployeesFailure extends EmployeesState {
  final ServerError error;

  GetEmployeesFailure(this.error);

  @override
  List<Object> get props => [];
}

class ResetPasswordInProgress extends EmployeesState {
  @override
  List<Object> get props => [];
}

class ResetPasswordSuccess extends EmployeesState {
  @override
  List<Object> get props => [];
}

class ResetPasswordFailure extends EmployeesState {
  final ServerError error;

  ResetPasswordFailure(this.error);

  @override
  List<Object> get props => [];
}
