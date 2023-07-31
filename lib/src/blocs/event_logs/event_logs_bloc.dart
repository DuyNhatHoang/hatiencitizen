import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/create_event_log_request.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log_type.dart';
import 'package:ha_tien_app/src/repositories/remote/event_logs/event_logs_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';

part 'event_logs_event.dart';

part 'event_logs_state.dart';

class EventLogsBloc extends Bloc<EventLogsEvent, EventLogsState> {
  final EventLogsRepo repo;

  EventLogsBloc(this.repo) : super(EventLogsInitial());

  @override
  Stream<EventLogsState> mapEventToState(
    EventLogsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetEventLogsByEventIdEvent) {
      yield GetEventLogsByEventIdInProgress();
      var result = await repo.getEventLogsByEventId(event.eventId);
      if (result.getException == null) {
        yield GetEventLogsByEventIdSuccess(result.data);
      } else {
        yield GetEventLogsByEventIdFailure(result.getException);
      }
    } else if (event is CreateEventLogEvent) {
      yield CreateEventLogInProgress();
      var result = await repo.createEventLog(event.request);
      if (result.getException == null) {
        yield CreateEventLogSuccess(result.data);
      } else {
        yield CreateEventLogFailure(result.getException);
      }
    } else if (event is GetEventLogType) {
      yield GetEventLogTypeInProgress();
      var result = await repo.getEventLogType();
      if (result.getException == null) {
        yield GetEventLogTypeSuccess(result.data);
      } else {
        yield GetEventLogTypeFailure(result.getException);
      }
    }
  }
}
