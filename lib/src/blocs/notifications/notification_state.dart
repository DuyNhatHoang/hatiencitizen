part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class GetNotificationsInProgress extends NotificationState {
  @override
  List<Object> get props => [];
}

class GetNotificationsSuccess extends NotificationState {
  final List<NotificationUser> data;

  GetNotificationsSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetNotificationsFailure extends NotificationState {
  final error;

  GetNotificationsFailure(this.error);

  @override
  List<Object> get props => [];
}

class GetNotificationByIdInProgress extends NotificationState {
  @override
  List<Object> get props => [];
}

class GetNotificationByIdSuccess extends NotificationState {
  final List<NotificationData> data;

  GetNotificationByIdSuccess(this.data);

  @override
  List<Object> get props => [];
}

class GetNotificationByIdFailure extends NotificationState {
  final ServerError error;

  GetNotificationByIdFailure(this.error);

  @override
  List<Object> get props => [];
}

class DownloadNotificationFileInProgress extends NotificationState {
  @override
  List<Object> get props => [];
}

class DownloadNotificationFileSuccess extends NotificationState {
  final List<int> data;

  DownloadNotificationFileSuccess(this.data);

  @override
  List<Object> get props => [];
}

class DownloadNotificationFileFailure extends NotificationState {
  final ServerError error;

  DownloadNotificationFileFailure(this.error);

  @override
  List<Object> get props => [];
}
