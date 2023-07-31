import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/models.dart';
import 'package:ha_tien_app/src/repositories/models/notification/files.dart';
import 'package:ha_tien_app/src/repositories/models/notification/notification_response.dart';
import 'package:ha_tien_app/src/repositories/models/notification/requests/get_notification_users_request.dart';
import 'package:ha_tien_app/src/repositories/remote/notifications/notification_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo repo;

  NotificationBloc(this.repo) : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event,) async* {
    if (event is GetNotificationsEvent) {
      yield GetNotificationsInProgress();
      var data = await repo.getNotificationUsers(event.request);
      if (data.getException == null) {
        yield GetNotificationsSuccess(data.data);
      } else {
        yield GetNotificationsFailure(data.getException);
      }
    } else if (event is GetNotificationByIdEvent) {
      yield GetNotificationByIdInProgress();
      var data = await repo.getNotificationById(event.id);
      if (data.getException == null) {
        yield GetNotificationByIdSuccess(data.data);
      } else {
        yield GetNotificationByIdFailure(data.getException);
      }
    }
    else if (event is DownloadNotificationFileEvent) {
      yield DownloadNotificationFileInProgress();
      var data = await repo.downloadFile(event.file);
      if (data.getException == null) {
        yield DownloadNotificationFileSuccess(data.data);
      } else {
        yield DownloadNotificationFileFailure(data.getException);
      }
    }
  }

}
