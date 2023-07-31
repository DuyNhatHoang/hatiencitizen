import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/notifications/notification_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/models.dart';
import 'package:ha_tien_app/src/repositories/models/notification/notification.dart';
import 'package:ha_tien_app/src/repositories/models/notification/requests/get_notification_users_request.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/detail_notification/detail_notification_screen.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class NotificationView extends StatefulWidget {
  final SessionManager session;

  const NotificationView({Key key, this.session}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationView> {
  int _pageIndex = 1;
  int _pageSize = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NotificationBloc>(context).add(GetNotificationsEvent(
        GetNotificationUsesrRequest(
            pageIndex: _pageIndex, pageSize: _pageSize)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetNotificationsSuccess) {
            List<NotificationUser> data = state.data;
            if (data.length == 0) {
              return myEmptyListWidget();
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // _onTapDetailNotification(
                  //     "2b61ecc9-316d-4d45-4d25-08d898326d6e");
                  _onTapDetailNotification(data[index].notification.id);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context).title}: " + data[index].notification.title,
                          style: myTitleItemStyle(),
                        ),
                        Text("${AppLocalizations.of(context).description}: " + data[index].notification.description),
                        Text(
                          "${AppLocalizations.of(context).category}: " +
                              data[index].notification.category.description,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return LoadingIndicator();
        });
  }

  void _onTapDetailNotification(String notificationId) {
    Navigator.of(context).pushNamed(DetailNotificationScreen.routeName,
        arguments: notificationId);
  }
}
