part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();
}

class EventsInitial extends EventsState {
  @override
  List<Object> get props => [];
}

class GetEventsNewInProgress extends EventsState {
  @override
  List<Object> get props => [];
}

class GetEventsNewSuccess extends EventsState {
  final List<EventOfEmployee> data;

  GetEventsNewSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetEventsNewFailure extends EventsState {
  final error;

  GetEventsNewFailure(this.error);

  @override
  List<Object> get props => [];
}

class GetEventsInProgress extends EventsState {
  @override
  List<Object> get props => [];
}

class GetEventsSuccess extends EventsState {
  final List<UserEvent> data;

  GetEventsSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetEventsFailure extends EventsState {
  final error;

  GetEventsFailure(this.error);

  @override
  List<Object> get props => [];
}

class CreateEventInProgress extends EventsState {
  @override
  List<Object> get props => [];
}

class CreateEventSuccess extends EventsState {
  final EventLog data;

  CreateEventSuccess(this.data);

  @override
  List<Object> get props => [];
}

class CreateEventFailure extends EventsState {
  final ServerError error;

  CreateEventFailure(this.error);

  @override
  List<Object> get props => [];
}

class GetEventsPostedByUserInProgress extends EventsState {
  @override
  List<Object> get props => [];
}

class GetEventsPostedByUserSuccess extends EventsState {
  final List<UserEvent> data;

  GetEventsPostedByUserSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetEventsPostedByUserFailure extends EventsState {
  final ServerError error;

  GetEventsPostedByUserFailure(this.error);

  @override
  List<Object> get props => [];
}

class UpdateEventFilesInProgress extends EventsState {
  @override
  List<Object> get props => [];
}

class UpdateEventFilesSuccess extends EventsState {
  UpdateEventFilesSuccess();

  @override
  List<Object> get props => [];
}

class UpdateEventFilesFailure extends EventsState {
  final ServerError error;

  UpdateEventFilesFailure(this.error);

  @override
  List<Object> get props => [];
}

class GetEventFilesInProgress extends EventsState {
  @override
  List<Object> get props => [];
}

class GetEventFilesSuccess extends EventsState {
  final List<EventFiles> data;

  GetEventFilesSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetEventFilesFailure extends EventsState {
  final ServerError error;

  GetEventFilesFailure(this.error);

  @override
  List<Object> get props => [];
}

class GetEventsByStatusIdInProgress extends EventsState {
  @override
  List<Object> get props => [];
}

class GetEventsByStatusIdSuccess extends EventsState {
  final List<EventOfEmployee> data;

  GetEventsByStatusIdSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetEventsByStatusIdFailure extends EventsState {
  final ServerError error;

  GetEventsByStatusIdFailure(this.error);

  @override
  List<Object> get props => [];
}

class ExchangeEventToEmployeeIdInProgress extends EventsState {
  @override
  List<Object> get props => [];
}

class ExchangeEventToEmployeeIdSuccess extends EventsState {
  final EventLog data;

  ExchangeEventToEmployeeIdSuccess(this.data);

  @override
  List<Object> get props => [];
}

class ExchangeEventToEmployeeIdFailure extends EventsState {
  final ServerError error;

  ExchangeEventToEmployeeIdFailure(this.error);

  @override
  List<Object> get props => [];
}

class InviteEventToEmployeeIdInProgress extends EventsState {
  @override
  List<Object> get props => [];
}

class InviteEventToEmployeeIdSuccess extends EventsState {
  InviteEventToEmployeeIdSuccess();

  @override
  List<Object> get props => [];
}

class InviteEventToEmployeeIdFailure extends EventsState {
  final ServerError error;

  InviteEventToEmployeeIdFailure(this.error);

  @override
  List<Object> get props => [];
}

class GetGalleryFileLoading extends EventsState {

  GetGalleryFileLoading();

  @override
  List<Object> get props => [];
}

class GetGalleryFileLoaded extends EventsState {
  final GalleryResponse response;

  GetGalleryFileLoaded(this.response);

  @override
  List<Object> get props => [response];
}

class GetGalleryFileError extends EventsState {

  GetGalleryFileError();

  @override
  List<Object> get props => [];
}
