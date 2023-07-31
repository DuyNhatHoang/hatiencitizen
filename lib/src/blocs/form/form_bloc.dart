import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/form/form_response_model.dart';
import 'package:ha_tien_app/src/repositories/remote/form/form_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/form/vm/posting_form_data.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';
import 'package:meta/meta.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormPostState> {
  final FormRepo repo;

  FormBloc(this.repo) : super(InitialFormState());

  @override
  Stream<FormPostState> mapEventToState(FormEvent event) async* {
    if (event is PostFormEvent) {
      yield PostFormInProgress();
      var data = await repo.postForm(event.request);
      if (data.getException == null) {
        print("post form thành công ${data.data}");
        yield PostFromSuccess();
      } else {
        print("post form that bai ${data.getException}");
        yield PostFromFailed(data.getException);
      }
    } else if (event is GetFormEvent) {
      yield GetFormLoading();
      var data = await repo.getForm(event.eventId);
      if (data.getException == null) {
        print("get form thành công ${data.data}");
        yield GetFormSuccess(data.data);
      } else {
        print("post form that bai ${data.getException}");
        yield GetFormFailed(data.getException);
      }
    }
  }
}
