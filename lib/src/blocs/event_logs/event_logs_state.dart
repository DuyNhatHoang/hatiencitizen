part of 'event_logs_bloc.dart';

abstract class EventLogsState extends Equatable {
  const EventLogsState();
}

class EventLogsInitial extends EventLogsState {
  @override
  List<Object> get props => [];
}

class GetEventLogsByEventIdInProgress extends EventLogsState {
  @override
  List<Object> get props => [];
}

class GetEventLogsByEventIdSuccess extends EventLogsState {
  final List<EventLog> data;

  GetEventLogsByEventIdSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetEventLogsByEventIdFailure extends EventLogsState {
  final ServerError error;

  GetEventLogsByEventIdFailure(this.error);

  @override
  List<Object> get props => [];
}

class CreateEventLogInProgress extends EventLogsState {
  @override
  List<Object> get props => [];
}

class CreateEventLogSuccess extends EventLogsState {
  final EventLog data;

  CreateEventLogSuccess(this.data);

  @override
  List<Object> get props => [];
}

class CreateEventLogFailure extends EventLogsState {
  final ServerError error;

  CreateEventLogFailure(this.error);

  @override
  List<Object> get props => [];
}

class GetEventLogTypeInProgress extends EventLogsState {
  @override
  List<Object> get props => [];
}

class GetEventLogTypeSuccess extends EventLogsState {
  final List<EventLogType> data;

  GetEventLogTypeSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetEventLogTypeFailure extends EventLogsState {
  final ServerError error;

  GetEventLogTypeFailure(this.error);

  @override
  List<Object> get props => [];
}
