import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/event_types/event_types.dart';
import 'package:ha_tien_app/src/repositories/remote/event_types/event_types_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';
import 'package:ha_tien_app/src/repositories/remote/view_models/paging_request.dart';

part 'event_types_event.dart';

part 'event_types_state.dart';

class EventTypesBloc extends Bloc<EventTypesEvent, EventTypesState> {
  final EventTypesRepo repo;

  EventTypesBloc(this.repo) : super(EventTypesInitial());

  @override
  Stream<EventTypesState> mapEventToState(
    EventTypesEvent event,
  ) async* {
    if (event is GetEventTypesEvent) {
      yield GetEventTypesInProgress();
      var result = await repo.getEventTypes(
          searchValue: event.searchValue, pagingRequest: event.pagingRequest);
      if (result.getException == null) {
        yield GetEventTypesSuccess(result.data);
      }else{
        yield GetEventTypesFailure(result.getException);
      }
    }
    // TODO: implement mapEventToState
  }
}
