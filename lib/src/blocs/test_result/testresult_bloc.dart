import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ha_tien_app/src/repositories/remote/test_result_repo/test_repo_repo.dart';

import 'bloc.dart';

class TestResultBloc extends Bloc<TestResultEvent, TestResultState> {
  final TestResultRepo repo;


  TestResultBloc(this.repo) : super(TestResultInitial());

  @override
  Stream<TestResultState> mapEventToState(
    TestResultEvent event,
  ) async* {
    if (event is GetTestResultE) {
      yield GetTestResulLoading();
      var result = await repo.getTestResult(event.phoneNumber);
      if(result.getException != null){
        yield GetTestResulLoadError(result.getException);
      }  else{
        yield GetTestResulLoaded(result.data);
      }
    }
  }
}

