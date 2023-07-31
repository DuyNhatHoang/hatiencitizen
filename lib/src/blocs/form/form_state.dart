part of 'form_bloc.dart';

@immutable
abstract class FormPostState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialFormState extends FormPostState {}

class PostFormInProgress extends FormPostState {}

class PostFromSuccess extends FormPostState {}

class PostFromFailed extends FormPostState {
  final ServerError error;

  PostFromFailed(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class GetFormSuccess extends FormPostState {
  final List<FormResponse> formResponse;

  GetFormSuccess(this.formResponse);
}

class GetFormFailed extends FormPostState {
  final ServerError error;

  GetFormFailed(this.error);
  @override
// TODO: implement props
  List<Object> get props => [error];
}

class GetFormLoading extends FormPostState {}
