import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_logs/event_logs_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/eventlog_info.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/repositories/remote/event_logs/event_logs_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/home/dssc/detail_eventlogs_screen.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HistoryEventPage extends StatefulWidget {
  final UserEvent event;
  final SessionManager sessionManager;

  const HistoryEventPage({Key key, this.event, this.sessionManager})
      : super(key: key);

  @override
  _HistoryEventPageState createState() => _HistoryEventPageState();
}

class _HistoryEventPageState extends State<HistoryEventPage> {
  List<TimelineModel> timeLineList;
  List<EventLog> eventLogList;
  Size size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // initTimeLineData();
    return BaseSubPage(
      title: AppLocalizations.of(context).eventHistory,
      onBack: (){
        Navigator.of(context).pop();
      },
      child: SingleChildScrollView(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => EventLogsBloc(EventLogsRepo.withToken(
                      widget.sessionManager.getSession().accessToken))
                    ..add(GetEventLogsByEventIdEvent(widget.event.id))),
            ],
            child: Stack(
              children: [
                BlocBuilder<EventLogsBloc, EventLogsState>(
                  builder: (context, state) {
                    if (state is GetEventLogsByEventIdSuccess) {
                      eventLogList = state.data;
                      initTimeLineData(eventLogList);
                      return Timeline.builder(
                        shrinkWrap: true,
                        itemCount: timeLineList.length,
                        itemBuilder: (context, index) => timeLineList[index],
                        position: TimelinePosition.Left,
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          )),
    );
  }

  void initTimeLineData(List<EventLog> eventLogList) {
    timeLineList = List<TimelineModel>();
    eventLogList.forEach((element) {
      String eventLogInfo = "";
      try{
        EventLogInformation temp = EventLogInformation.fromJson(jsonDecode(element.information));
        eventLogInfo = temp.decription;
      }catch(e){
        eventLogInfo = element.information;
      }
      print("initTimeLineData ${element.information}");
      timeLineList.add(TimelineModel(
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailEventLogsScreen(
                  session: widget.sessionManager.getSession(),
                  eventLog: element,
                )));
          },
          child: Container(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${element.taskMaster != null ? element.taskMaster.fullName : element.user.fullName}",
                      style: TextStyle(
                          fontSize: SizeConfig.screenWidth * 0.05,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01,),
                    Text(convertDateTimeToVN(element.dateTime),
                        style: TextStyle(
                          fontSize: SizeConfig.screenWidth * 0.03,
                          color: kGrayColor,
                        )),
                    SizedBox(height: SizeConfig.screenHeight * 0.01,),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text("${element.eventLogType.description}",style: TextStyle(
                          fontSize: SizeConfig.screenWidth * 0.035,
                          color: Colors.green
                      )),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01,),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text("${AppLocalizations.of(context).content}: ${eventLogInfo}",style: TextStyle(
                          fontSize: SizeConfig.screenWidth * 0.035
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        iconBackground: Constants.statusColors[element.status],
        icon: Icon(
          Icons.access_time_sharp,
          color: kWhiteColor,
          size: SizeConfig.screenWidth * 0.2,

        ),
      ));
    });
  }

  Widget daytime() {
    return Container(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("04-02-2021"),
          SizedBox(
            height: 5,
          ),
          Text("20:20:10"),
        ],
      ),
    );
  }
}
