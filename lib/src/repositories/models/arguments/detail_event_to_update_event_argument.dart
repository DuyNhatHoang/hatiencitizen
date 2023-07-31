import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';

class DetailEventToUpdateEventArgument {
  final SessionManager session;
  final UserEvent event;

  final int statusId;

  DetailEventToUpdateEventArgument(this.session, this.event, this.statusId);
}
