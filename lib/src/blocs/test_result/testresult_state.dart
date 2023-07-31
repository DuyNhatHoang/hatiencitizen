import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/%20test_results/test_result.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';

abstract class TestResultState extends Equatable {
  const TestResultState();
}

class TestResultInitial extends TestResultState {
  @override
  List<Object> get props => [];
}

class GetTestResulLoading extends TestResultState {
  @override
  List<Object> get props => [];
}

class GetTestResulLoaded extends TestResultState {
  final TestResult data;

  GetTestResulLoaded(this.data);
  @override
  List<Object> get props => [data];
}


class GetTestResulLoadError extends TestResultState {
  final ServerError error;

  GetTestResulLoadError(this.error);
  @override
  List<Object> get props => [];
}

