part of 'event_status_bloc.dart';

abstract class EventStatusState extends Equatable {
  const EventStatusState();
}

class EventStatusInitial extends EventStatusState {
  @override
  List<Object> get props => [];
}

class GetEventStatusInProgress extends EventStatusState {
  @override
  List<Object> get props => [];
}

class GetEventStatusSuccess extends EventStatusState {
  final List<EventStatus> data;

  GetEventStatusSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetEventStatusFailure extends EventStatusState {
  final ServerError error;

  GetEventStatusFailure(this.error);

  @override
  List<Object> get props => [];
}
