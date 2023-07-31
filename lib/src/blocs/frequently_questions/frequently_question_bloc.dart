import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/blocs/notifications/notification_bloc.dart';
import 'package:ha_tien_app/src/repositories/models/models.dart';
import 'package:ha_tien_app/src/repositories/remote/frequently_questions/frequently_question_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';

part 'frequently_question_event.dart';

part 'frequently_question_state.dart';

class FrequentlyQuestionBloc
    extends Bloc<FrequentlyQuestionEvent, FrequentlyQuestionState> {
  final FrequentlyQuestionRepo repo;

  FrequentlyQuestionBloc(this.repo) : super(FrequentlyQuestionInitial());

  @override
  Stream<FrequentlyQuestionState> mapEventToState(
    FrequentlyQuestionEvent event,
  ) async* {
    if (event is GetFrequentlyQuestionsByNotificationIdEvent) {
      yield GetFrequentlyQuestionByNotificationIdIdInProgress();
      var data = await repo
          .getFrequentlyQuestionByNotificationId(event.notificationId);
      if (data.getException == null) {
        yield GetFrequentlyQuestionByNotificationIdIdSuccess(data.data);
      } else {
        yield GetFrequentlyQuestionByNotificationIdIdFailure(data.getException);
      }
    }
  }
}
