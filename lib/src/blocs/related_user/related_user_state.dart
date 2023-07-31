part of 'related_user_bloc.dart';

@immutable
abstract class GetRelatedState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialRelatedUserState extends GetRelatedState {}

class GetRelatedUserLoading extends GetRelatedState {
  @override
  List<Object> get props => [];
}

class GetRelatedUserSuccess extends GetRelatedState {
  final RelatedUserResponse response;
  GetRelatedUserSuccess(this.response);

  @override
  List<Object> get props => [];
}

class GetRelatedUserFailure extends GetRelatedState {
  final ServerError error;

  GetRelatedUserFailure(this.error);

  @override
  List<Object> get props => [];
}
