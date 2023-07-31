import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_logs/event_logs_bloc.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/arguments/form_to_detail_argument.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/events/employee_event.dart';
import 'package:ha_tien_app/src/repositories/models/events/my_user_event_distance.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/ui/detail_event/detail_event_screen.dart';
import 'package:ha_tien_app/src/ui/home/dssc/detail_employee_event_screen.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'event_item.dart';

class DSSCView extends StatefulWidget {
  final SessionManager session;

  const DSSCView({Key key, this.session}) : super(key: key);
  @override
  _DSSCViewState createState() => _DSSCViewState();
}

class _DSSCViewState extends State<DSSCView> {
  int cupertinoTabBarValue = 0;

  int cupertinoTabBarValueGetter() => cupertinoTabBarValue;
  List<EventOfEmployee> data = List<EventOfEmployee>();
  List<MyUserEventDistance> distanceEventList = List<MyUserEventDistance>();

  Location location;
  LocationData currentLocation;

  @override
  void initState() {
    super.initState();
    location = new Location();
    BlocProvider.of<EventsBloc>(context)
        .add(GetEventByStatusIdEvent(7, widget.session.getSession().id));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: SizeConfig.screenHeight * 0.8,
      width: SizeConfig.screenWidth,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.screenWidth * 0.02, horizontal: SizeConfig.screenWidth * 0.04),
                    decoration: BoxDecoration(
                        color: cupertinoTabBarValue == 0 ?  Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      AppLocalizations.of(context).processWait,
                      style:  TextStyle(
                        color: cupertinoTabBarValue == 0 ?  Colors.white : Colors.black,
                        fontSize: SizeConfig.screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                        fontFamily: "SFProRounded",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      cupertinoTabBarValue = 0;
                      _fetchData(0);
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.screenWidth * 0.02, horizontal: SizeConfig.screenWidth * 0.04),
                    decoration: BoxDecoration(
                        color: cupertinoTabBarValue == 1 ?  Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      AppLocalizations.of(context).processing,
                      style:  TextStyle(
                        color: cupertinoTabBarValue == 1 ?  Colors.white : Colors.black,
                        fontSize: SizeConfig.screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                        fontFamily: "SFProRounded",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      cupertinoTabBarValue = 1;
                      _fetchData(1);
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.screenWidth * 0.02),
                    decoration: BoxDecoration(
                        color: cupertinoTabBarValue == 2 ?  Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      AppLocalizations.of(context).doneRequest,
                      style:  TextStyle(
                        color: cupertinoTabBarValue == 2 ?  Colors.white : Colors.black,
                        fontSize: SizeConfig.screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                        fontFamily: "SFProRounded",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      cupertinoTabBarValue = 2;
                      _fetchData(2);
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.screenWidth * 0.02, horizontal: SizeConfig.screenWidth * 0.02),
                    decoration: BoxDecoration(
                        color: cupertinoTabBarValue == 3 ?  Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      "${ AppLocalizations.of(context).done}  ",
                      style:  TextStyle(
                        color: cupertinoTabBarValue == 3 ?  Colors.white : Colors.black,
                        fontSize: SizeConfig.screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                        fontFamily: "SFProRounded",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      cupertinoTabBarValue = 3;
                      _fetchData(3);
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints.expand(height: 20.0),
          ),
          Expanded(
            child: BlocConsumer<EventsBloc, EventsState>(
                listener: (context, state) {
                  if (state is GetEventsByStatusIdFailure) {
                    showSnackBar(context, state.error.getErrorMessage());
                  }
                }, builder: (context, state) {
              if (state is GetEventsByStatusIdFailure) {
                return Center(
                  child: Text( AppLocalizations.of(context).error),
                );
              } else if (state is GetEventsByStatusIdSuccess) {
                data = state.data;
                if (data.length == 0) {
                  return Center(
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).nodata,
                          style: TextStyle(fontSize: 25),
                        ),
                      ));
                }
                return BlocConsumer<EventLogsBloc, EventLogsState>(
                    listener: (context, state) {
                      if (state is GetEventLogsByEventIdSuccess) {
                        Navigator.of(context).pushNamed(
                            DetailEventScreen.routeName,
                            arguments: state.data.first);
                      } else if (state is GetEventLogsByEventIdFailure) {
                        showSnackBar(context, state.error.getErrorMessage());
                      }
                    }, builder: (context, state) {
                  {
                    return  MediaQuery.removePadding(context: context,
                        removeTop: true,
                        child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _onTapEventItem(context, data[index]),
                          child: EventItem(
                            event: UserEvent.fromJson(data[index].toJson()),
                            index: index,
                          ),
                        );
                      },
                    ));
                  }
                });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
          ),
        ],
      ),
    );
  }

  _onTapEventItem(context, EventOfEmployee item) async {
    await Navigator.of(context).pushNamed(DetailEmployeeEventScreen.routeName,
        arguments: FormToDetailArgument(Constants.dsscForm, item));
    setState(() {
      BlocProvider.of<EventsBloc>(context)
          .add(GetEventByStatusIdEvent(getStatusId(cupertinoTabBarValue), widget.session.getSession().id));
    });
  }

  _fetchData(int index) {
      BlocProvider.of<EventsBloc>(context)
          .add(GetEventByStatusIdEvent(getStatusId(index), widget.session.getSession().id));
  }

  int getStatusId(int index) {
    switch (index) {
      case 0:
        return 7;
      case 1:
        return 1;
      case 2:
        return 10;
      case 3:
        return 3;
    }
  }

  Future<bool> initLocation() async {
    currentLocation = await location.getLocation();
    filterDataWithDistance();
    location.onLocationChanged().listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      filterDataWithDistance();
    });
    return true;
  }

  void filterDataWithDistance() {
    if (!mounted) return;
    data.forEach((element) {
      MyUserEventDistance item = MyUserEventDistance.fromJson(element.toJson());
      var source = LatLng(currentLocation.latitude, currentLocation.longitude);
      var des = LatLng(
          double.parse(element.latitude), double.parse(element.longitude));
      var distanceBetweenPoints =
          SphericalUtil.computeDistanceBetween(source, des);
      var kmDistance = (distanceBetweenPoints / 1000).floor();
      // print(
      //     "$kmDistance - ${currentLocation.latitude}, ${currentLocation.longitude} - ${double.parse(element.latitude)}, ${double.parse(element.longitude)}");
      item.distance = kmDistance;
      distanceEventList.add(item);
    });
  }
}
