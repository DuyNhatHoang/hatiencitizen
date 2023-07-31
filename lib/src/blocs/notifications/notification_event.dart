part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class GetNotificationsEvent extends NotificationEvent {
  final GetNotificationUsesrRequest request;

  GetNotificationsEvent(this.request);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetNotificationByIdEvent extends NotificationEvent {
  final String id;

  GetNotificationByIdEvent(this.id);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DownloadNotificationFileEvent extends NotificationEvent {
  final Files file;

  DownloadNotificationFileEvent(this.file);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
