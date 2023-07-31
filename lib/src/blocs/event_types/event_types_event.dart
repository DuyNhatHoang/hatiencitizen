part of 'event_types_bloc.dart';

abstract class EventTypesEvent extends Equatable {
  const EventTypesEvent();
}

class GetEventTypesEvent extends EventTypesEvent {
  final PagingRequest pagingRequest;
  final String searchValue;

  GetEventTypesEvent({this.pagingRequest, this.searchValue});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
