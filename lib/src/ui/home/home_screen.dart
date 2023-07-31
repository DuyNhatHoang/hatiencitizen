import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_logs/event_logs_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_statuses/event_status_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_types/event_types_bloc.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/blocs/login/login_bloc.dart';
import 'package:ha_tien_app/src/blocs/notifications/notification_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_logs/event_logs_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_statuses/event_statuses_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_types/event_types_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/notifications/notification_repo.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/home/components/ctn_view.dart';
import 'package:ha_tien_app/src/ui/home/components/dssc_view.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';

import 'components/tk_main_view.dart';
import 'main_home/main_home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
GlobalKey bottomBarKey = new GlobalKey(debugLabel: 'btm_app_bar');
class HomeScreen extends StatefulWidget {
  static const String routeName = "/HomeScreen";

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  BottomNavigationBadge badger = BottomNavigationBadge(
      backgroundColor: Colors.red,
      badgeShape: BottomNavigationBadgeShape.circle,
      textColor: Colors.white,
      position: BottomNavigationBadgePosition.topRight,
      textSize: 8);

  int dropdownSelected = 0;

  int _current = 0;

  SessionManager _session;
  Widget view;
  Size size;
  String titleText = "Chào ngày mới!";


  GlobalKey<HomeScreenState> _homeKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    size = MediaQuery.of(context).size;
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
          icon: Image.asset("assets/icons/home.png", width:25 ),
          label: AppLocalizations.of(context).homepage,
          activeIcon: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(25)
            ),
            child: Image.asset("assets/icons/home.png", height: 25, color: Colors.white,),
          )
      ),
      BottomNavigationBarItem(
        icon: Image.asset("assets/icons/icons8-list-view-64.png", height: 25, color: Colors.black,),
          label: AppLocalizations.of(context).postedEvent,
          activeIcon: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(25)
            ),
            child: Image.asset("assets/icons/icons8-list-view-64.png", height: 25, color: Colors.white,),
          )
      ),
      BottomNavigationBarItem(
        icon: Image.asset("assets/icons/icons8-list-view-64.png", height: 25, color: Colors.black,),
          label: AppLocalizations.of(context).received,
          activeIcon: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(25)
            ),
            child: Image.asset("assets/icons/icons8-list-view-64.png", height: 25, color: Colors.white,),
          )
      ),
      // BottomNavigationBarItem(
      //   icon: Image.asset("assets/icons/notification.jpg", height: 25),
      //   label: Constants.TB,
      // ),
      BottomNavigationBarItem(
        icon: Image.asset("assets/icons/person.jpg", height: 25),
          label: AppLocalizations.of(context).account,
          activeIcon: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(25)
            ),
            child: Image.asset("assets/icons/person.png", height: 25, color: Colors.white,),
          )
      )
    ];

    SizeConfig().init(context);
    return FutureBuilder<SessionManager>(
        future: loadSession(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _session = snapshot.data;
            var accessToken = _session?.getSession()?.accessToken;
            view = getPresentWidget();
            return Scaffold(
              body: SingleChildScrollView(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          EventsBloc(EventsRepo.withToken(accessToken)),
                    ),
                    BlocProvider(
                      create: (context) =>
                          EventTypesBloc(EventTypesRepo.withToken(accessToken)),
                    ),
                    BlocProvider(
                      create: (context) => EventStatusBloc(
                          EventStatusesRepo.withToken(accessToken)),
                    ),
                    BlocProvider(
                      create: (context) =>
                          EventLogsBloc(EventLogsRepo.withToken(accessToken)),
                    ),
                    BlocProvider(
                      create: (context) => NotificationBloc(
                          NotificationRepo.withToken(accessToken)),
                    ),
                    BlocProvider(
                        create: (context) =>
                        LoginBloc(AuthRepo.withToken(accessToken), null)
                          ..add(GetUserInfoEvent())),
                  ],
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.07,),
                        _current != 0 ? Text(titleText, style: TextStyle(fontSize: SizeConfig.screenWidth * 0.06, fontWeight: FontWeight.w600)) : Container(),
                        SizedBox(height: SizeConfig.screenHeight * 0.01,),
                        view
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _current,
                onTap: change,
                items: items,
                key: bottomBarKey,
                selectedItemColor: Colors.green,
                showSelectedLabels: true,
                selectedLabelStyle: TextStyle(
                  color: kPrimaryColor,
                ),
                unselectedItemColor: kBlackColor,
                showUnselectedLabels: true,
              ),
            );
          } else {
            return LoadingIndicator();
          }
        });
  }

  Widget getPresentWidget() {
    switch (_current) {
      case 0:
        if(DateTime.now().hour < 12){
          titleText = AppLocalizations.of(context).goodMorning;
        } else
        if(DateTime.now().hour <= 15){
          titleText = AppLocalizations.of(context).goodNoon;
        } else
        if(DateTime.now().hour <= 18){
          titleText = AppLocalizations.of(context).goodAfternoon;
        }else
        if(DateTime.now().hour <= 24){
          titleText = AppLocalizations.of(context).goodEvening;
        }
        return MainHomePage(session: _session,);
        // return BCSCView(
        //   session: _session,
        //   key: _homeKey,
        // );
        break;
      case 1:
        titleText = AppLocalizations.of(context).waiting;
        return CTNView(
          session: _session,
        );

      case 2:
        titleText = AppLocalizations.of(context).work;
        return DSSCView(session: _session,);
        break;
      case 3:
        titleText = AppLocalizations.of(context).account;
        return TKMainView(
          session: _session,
        );
        break;
    }
    return null;
  }

  void change(int index) {
    setState(() {
      _current = index;
    });
  }
}
