import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/event_status/event_status.dart';
import 'package:ha_tien_app/src/repositories/remote/event_statuses/event_statuses_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';

part 'event_status_event.dart';
part 'event_status_state.dart';

class EventStatusBloc extends Bloc<EventStatusEvent, EventStatusState> {
  final EventStatusesRepo repo;
  EventStatusBloc(this.repo) : super(EventStatusInitial());

  @override
  Stream<EventStatusState> mapEventToState(
    EventStatusEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetEventStatusEvent) {
      yield GetEventStatusInProgress();
      var result = await repo.getEventStatuses();
      if (result.getException == null) {
        yield GetEventStatusSuccess(result.data);
      }else{
        yield GetEventStatusFailure(result.getException);
      }
    }
  }
}
