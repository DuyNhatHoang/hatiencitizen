part of 'related_user_bloc.dart';

@immutable
abstract class RelatedUserEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetRelateEvent extends RelatedUserEvent {
  final String request;

  GetRelateEvent({this.request});

  @override
  // TODO: implement props
  List<Object> get props => [request];
}
