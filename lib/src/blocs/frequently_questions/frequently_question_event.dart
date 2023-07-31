part of 'frequently_question_bloc.dart';

abstract class FrequentlyQuestionEvent extends Equatable {
  const FrequentlyQuestionEvent();
}

class GetFrequentlyQuestionsByNotificationIdEvent extends FrequentlyQuestionEvent {
  final String notificationId;

  GetFrequentlyQuestionsByNotificationIdEvent(this.notificationId);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
