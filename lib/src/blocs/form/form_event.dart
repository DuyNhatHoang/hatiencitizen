part of 'form_bloc.dart';

@immutable
abstract class FormEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PostFormEvent extends FormEvent {
  final PostingFormData request;

  PostFormEvent(this.request);

  @override
  // TODO: implement props
  List<Object> get props => [request];
}

class GetFormEvent extends FormEvent {
  final String eventId;

  GetFormEvent(this.eventId);
  @override
  // TODO: implement props
  List<Object> get props => [eventId];
}
