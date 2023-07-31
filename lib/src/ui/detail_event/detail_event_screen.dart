//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  © Cosmos Software | Ali Yigit Bireroglu                                                                                                          /
//  All material used in the making of this code, project, program, application, software et cetera (the "Intellectual Property")                    /
//  belongs completely and solely to Ali Yigit Bireroglu. This includes but is not limited to the source code, the multimedia and                    /
//  other asset files.                                                                                                                               /
//  If you were granted this Intellectual Property for personal use, you are obligated to include this copyright text at all times.                  /
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/detail_event/components/image_slider_component.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DetailEventScreen extends StatefulWidget {
  static const String routeName = "/DetailEventScreen";
  final EventLog item;

  const DetailEventScreen({Key key, this.item}) : super(key: key);

  @override
  _DetailEventScreenState createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<SessionManager>(
        future: loadSession(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider(
              create: (context) => EventsBloc(
                  EventsRepo.withToken(snapshot.data.getSession().accessToken)),
              child: Scaffold(

                appBar: buildMyAppBar(
                  title: AppLocalizations.of(context).detailed,
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageSliderComponent(
                        eventLogList: [widget.item],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.item.event.eventTypeName ?? "Trống",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Constants.largeFontSize),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Constants.statusColors[widget.item.status],
                          ),
                          child: Text(
                            Constants.statuses[widget.item.status] ?? "Trống",
                            style: TextStyle(color: kWhiteColor),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          convertDateTimeToVN(widget.item.dateTime),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "${AppLocalizations.of(context).at}: ${widget.item.event.address ?? "Trống"}",
                          style: TextStyle(fontSize: Constants.mediumFontSize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "${AppLocalizations.of(context).content}: ${widget.item.event.decription}",
                          style: TextStyle(fontSize: Constants.mediumFontSize),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else
            return LoadingIndicator();
        });
  }
}
