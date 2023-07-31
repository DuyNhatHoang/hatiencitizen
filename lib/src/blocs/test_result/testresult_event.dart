import 'package:equatable/equatable.dart';

abstract class TestResultEvent extends Equatable {
  const TestResultEvent();
}


class GetTestResultE extends TestResultEvent {
  final String phoneNumber;

  GetTestResultE(this.phoneNumber);
  @override
  List<Object> get props => [phoneNumber];
}
