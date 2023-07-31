import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_logs/event_logs_bloc.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/eventlog_info.dart';
import 'package:ha_tien_app/src/repositories/remote/event_logs/event_logs_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/ui/detail_event/components/image_slider_component.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DetailEventLogsScreen extends StatefulWidget {
  final EventLog eventLog;
  final Session session;

  const DetailEventLogsScreen({Key key, this.eventLog, this.session})
      : super(key: key);
  @override
  _DetailEventLogsScreenState createState() => _DetailEventLogsScreenState();
}

class _DetailEventLogsScreenState extends State<DetailEventLogsScreen> {
  @override
  Widget build(BuildContext context) {
    String eventLogInfo = "";
    try{
      EventLogInformation temp = EventLogInformation.fromJson(jsonDecode(widget.eventLog.information));
      eventLogInfo = temp.decription;
    }catch(e){
      eventLogInfo = widget.eventLog.information;
    }
    return Scaffold(
        appBar: buildMyAppBar(title: AppLocalizations.of(context).detailed),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => EventLogsBloc(
                    EventLogsRepo.withToken(widget.session.accessToken))
                  ..add(GetEventLogsByEventIdEvent(widget.eventLog.event.id))),
            BlocProvider(
                create: (context) => EventsBloc(
                    EventsRepo.withToken(widget.session.accessToken))),
          ],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "${widget.eventLog.eventLogType.description}",
                      style: TextStyle(
                          fontSize: Constants.mediumFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      convertDateTimeToVN(widget.eventLog.dateTime),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${AppLocalizations.of(context).content}: ",
                            style: TextStyle(color: kBlackColor),
                          ),
                          TextSpan(
                            text: eventLogInfo,
                            style: myTitleItemStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "${AppLocalizations.of(context).posted}: " +
                          "${widget.eventLog.taskMaster != null ? widget.eventLog.taskMaster.fullName : widget.eventLog.user.fullName}",
                    ),
                  ),
                  ImageSliderComponent(
                    eventLogList: [widget.eventLog],
                    // eventLogId: "0e77e030-5d79-4b12-a773-08d892dcc975",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
