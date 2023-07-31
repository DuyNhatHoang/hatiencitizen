import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/event_file/event_file.dart';
import 'package:ha_tien_app/src/repositories/models/event_file/gallery_response.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/events/employee_event.dart';
import 'package:ha_tien_app/src/repositories/models/events/exchange_event_to_employee_id.dart';
import 'package:ha_tien_app/src/repositories/models/events/invite_employee_request.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/events/view_models/create_event_request.dart';
import 'package:ha_tien_app/src/repositories/remote/events/view_models/get_events_request.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';
import 'package:ha_tien_app/src/repositories/remote/view_models/paging_request.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventsRepo repo;

  EventsBloc(this.repo) : super(EventsInitial());

  @override
  Stream<EventsState> mapEventToState(
    EventsEvent event,
  ) async* {
    if (event is GetEventsNewEvent) {
      yield GetEventsNewInProgress();
      var data = await repo.getEventsNew();
      if (data.getException == null) {
        yield GetEventsNewSuccess(data.data);
      } else {
        yield GetEventsNewFailure(data.getException);
      }
    } else if (event is GetEventsEvent) {
      yield GetEventsInProgress();
      var data = await repo.getEvents(
          pagingRequest: event.pagingRequest,
          getEventsRequest: event.getEventsRequest);
      if (data.getException == null) {
        yield GetEventsSuccess(data.data);
      } else {
        yield GetEventsFailure(data.getException);
      }
    } else if (event is CreateEventEvent) {
      yield CreateEventInProgress();
      var data = await repo.createEvent(event.request);
      if (data.getException == null) {
        yield CreateEventSuccess(data.data);
      } else {
        yield CreateEventFailure(data.getException);
      }
    } else if (event is GetEventsPostedByUserEvent) {
      yield GetEventsPostedByUserInProgress();
      var data = await repo.getEventsPostedByUser();
      if (data.getException == null) {
        yield GetEventsPostedByUserSuccess(data.data);
      } else {
        yield GetEventsPostedByUserFailure(data.getException);
      }
    } else if (event is UpdateEventFilesEvent) {
      yield UpdateEventFilesInProgress();
      var data = await repo.updateFiles(event.eventLogId, event.data);
      if (data.getException == null) {
        yield UpdateEventFilesSuccess();
      } else {
        yield UpdateEventFilesFailure(data.getException);
      }
    } else if (event is GetEventFilesEvent) {
      yield GetEventFilesInProgress();
      var data = await repo.getEventFiles(event.eventLogId);
      if (data.getException == null) {
        yield GetEventFilesSuccess(data.data);
      } else {
        yield GetEventFilesFailure(data.getException);
      }
    } else if (event is GetEventByStatusIdEvent) {
      yield GetEventsByStatusIdInProgress();
      var data = await repo.getEventsByStatusId(event.statusId, event.searchValue);
      if (data.getException == null) {
        yield GetEventsByStatusIdSuccess(data.data);
      } else {
        yield GetEventsByStatusIdFailure(data.getException);
      }
    } else if (event is ExchangeEventToEmployeeId) {
      yield ExchangeEventToEmployeeIdInProgress();
      var data = await repo.exchangeEventToEmployeeId(event.request);
      if (data.getException == null) {
        yield ExchangeEventToEmployeeIdSuccess(data.data);
      } else {
        yield ExchangeEventToEmployeeIdFailure(data.getException);
      }
    } else if (event is InviteEmployeeEvent) {
      yield InviteEventToEmployeeIdInProgress();
      var data = await repo.inviteEmployeeToEvent(event.request);
      if (data.getException == null) {
        yield InviteEventToEmployeeIdSuccess();
      } else {
        yield InviteEventToEmployeeIdFailure(data.getException);
      }
    }  else if (event is GetGalleryFiles) {
      yield GetGalleryFileLoading();
      var data = await repo.getGalleryFiles(event.username);
      if (data.getException == null) {
        yield GetGalleryFileLoaded(data.data);
      } else {
        yield GetGalleryFileError();
      }
    }
  }
}
