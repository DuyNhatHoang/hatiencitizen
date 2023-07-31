part of 'event_logs_bloc.dart';

abstract class EventLogsEvent extends Equatable {
  const EventLogsEvent();
}

class GetEventLogsByEventIdEvent extends EventLogsEvent {
  final String eventId;

  GetEventLogsByEventIdEvent(this.eventId);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CreateEventLogEvent extends EventLogsEvent {
  final CreateEventLogRequest request;

  CreateEventLogEvent(this.request);

  @override
  List<Object> get props => throw UnimplementedError();
}

class GetEventLogType extends EventLogsEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
