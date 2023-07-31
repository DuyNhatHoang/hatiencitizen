part of 'event_types_bloc.dart';

abstract class EventTypesState extends Equatable {
  const EventTypesState();
}

class EventTypesInitial extends EventTypesState {
  @override
  List<Object> get props => [];
}

class GetEventTypesInProgress extends EventTypesState {
  @override
  List<Object> get props => [];
}

class GetEventTypesSuccess extends EventTypesState {
  final List<EventType> data;

  GetEventTypesSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetEventTypesFailure extends EventTypesState {
  final ServerError error;

  GetEventTypesFailure(this.error);

  @override
  List<Object> get props => [];
}
