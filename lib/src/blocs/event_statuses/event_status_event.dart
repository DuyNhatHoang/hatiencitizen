part of 'event_status_bloc.dart';

abstract class EventStatusEvent extends Equatable {
  const EventStatusEvent();
}

class GetEventStatusEvent extends EventStatusEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
