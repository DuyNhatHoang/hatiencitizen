part of 'frequently_question_bloc.dart';

abstract class FrequentlyQuestionState extends Equatable {
  const FrequentlyQuestionState();
}

class FrequentlyQuestionInitial extends FrequentlyQuestionState {
  @override
  List<Object> get props => [];
}

class GetFrequentlyQuestionByNotificationIdIdInProgress
    extends FrequentlyQuestionState {
  @override
  List<Object> get props => [];
}

class GetFrequentlyQuestionByNotificationIdIdSuccess
    extends FrequentlyQuestionState {
  final List<FrequentlyQuestion> data;

  GetFrequentlyQuestionByNotificationIdIdSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetFrequentlyQuestionByNotificationIdIdFailure
    extends FrequentlyQuestionState {
  final ServerError error;

  GetFrequentlyQuestionByNotificationIdIdFailure(this.error);

  @override
  List<Object> get props => [];
}
