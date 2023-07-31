part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
}

class GetEventsNewEvent extends EventsEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetEventsEvent extends EventsEvent {
  final PagingRequest pagingRequest;
  final GetEventsRequest getEventsRequest;

  GetEventsEvent({this.pagingRequest, this.getEventsRequest});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CreateEventEvent extends EventsEvent {
  final CreateEventRequest request;

  CreateEventEvent(this.request);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetEventsPostedByUserEvent extends EventsEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UpdateEventFilesEvent extends EventsEvent {
  final String eventLogId;
  final List<String> data;

  UpdateEventFilesEvent(this.eventLogId, this.data);

  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}


class GetEventFilesEvent extends EventsEvent {
  final String eventLogId;

  GetEventFilesEvent(this.eventLogId);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetEventByStatusIdEvent extends EventsEvent {
  final int statusId;
  final String searchValue;

  GetEventByStatusIdEvent(this.statusId, this.searchValue);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ExchangeEventToEmployeeId extends EventsEvent {
  final ExchangeEventToEmployeeIdRequest request;

  ExchangeEventToEmployeeId(this.request);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InviteEmployeeEvent extends EventsEvent {
  final InviteEmployeeRequest request;

  InviteEmployeeEvent({this.request});

  @override
  // TODO: implement props
  List<Object> get props => [request];
}

class GetGalleryFiles extends EventsEvent {
  final String username;

  GetGalleryFiles({this.username});

  @override
  // TODO: implement props
  List<Object> get props => [username];
}

