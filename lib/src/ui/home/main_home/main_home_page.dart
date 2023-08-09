import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_logs/event_logs_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_statuses/event_status_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_types/event_types_bloc.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/blocs/login/login_bloc.dart';
import 'package:ha_tien_app/src/blocs/notifications/notification_bloc.dart';
import 'package:ha_tien_app/src/blocs/setting/bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_logs/event_logs_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_statuses/event_statuses_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_types/event_types_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/notifications/notification_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/setting/settingrepo.dart';
import 'package:ha_tien_app/src/ui/home/components/bcsc_view.dart';
import 'package:ha_tien_app/src/ui/home/notification/notifi_page.dart';
import 'package:ha_tien_app/src/ui/home/notification/notification_view.dart';
import 'package:ha_tien_app/src/ui/map/goong_map_api/request/geocoding.dart';
import 'package:ha_tien_app/src/ui/map/mapbox_search.dart';
import 'package:ha_tien_app/src/ui/medican/test_result/phone_number_check.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:ha_tien_app/src/app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
class MainHomePage extends StatefulWidget {
  final SessionManager session;

  const MainHomePage({Key key, this.session}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  String titleText = "Chào ngày mới!";
  BuildContext _settingContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  String getTitle(){
    if (DateTime.now().hour < 12) {
      titleText = AppLocalizations.of(context).goodMorning;
    } else if (DateTime.now().hour <= 15) {
      titleText = AppLocalizations.of(context).goodNoon;
    } else if (DateTime.now().hour <= 18) {
      titleText = AppLocalizations.of(context).goodAfternoon;
    } else if (DateTime.now().hour <= 24) {
      titleText = AppLocalizations.of(context).goodEvening;
    }
    return titleText;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EventsBloc(
                EventsRepo.withToken(widget.session.getSession().accessToken)),
          ),
          BlocProvider(
            create: (context) => EventTypesBloc(EventTypesRepo.withToken(
                widget.session.getSession().accessToken)),
          ),
          BlocProvider(
            create: (context) => EventStatusBloc(EventStatusesRepo.withToken(
                widget.session.getSession().accessToken)),
          ),
          BlocProvider(
            create: (context) => EventLogsBloc(EventLogsRepo.withToken(
                widget.session.getSession().accessToken)),
          ),
          BlocProvider(
            create: (context) => NotificationBloc(NotificationRepo.withToken(
                widget.session.getSession().accessToken)),
          ),
          BlocProvider(
            create: (context) => SettingBloc(SettingRepo.withToken(
                widget.session.getSession().accessToken)),
          ),
          BlocProvider(
              create: (context) => LoginBloc(
                  AuthRepo.withToken(widget.session.getSession().accessToken),
                  null)
                ..add(GetUserInfoEvent())),
        ],
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getTitle(),
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.06,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      Text(
                        " ${widget.session.getSession().fullName}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: SizeConfig.screenWidth * 0.055),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/global.png",
                        color: Colors.black,
                        width: 30,
                      ),
                      DropDown(
                        items: ["  Tiếng Việt", "  English"],

                        hint: prefs.get("language") == "en"
                            ? Text("  " + "English")
                            : Text("  " + "Tiếng Việt"),
                        onChanged: (s) {
                          // appKey.currentState.setLocale(Locale(s == "  Tiếng Việt" ? "vi" : "en"));
                          MyApp.of(context).setLocale(Locale(s == "  Tiếng Việt" ? "vi" : "en"));
                          prefs.setString(
                              "language", s == "  Tiếng Việt" ? "vi" : "en");
                        },
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationPage(
                            session: widget.session,
                          )));
                    },
                    child: cardItem(AppLocalizations.of(context).menuInfo,
                        "assets/icons/thongtin-thongbao.png"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BCSCView(
                            session: widget.session,
                          )));
                    },
                    child: cardItem(AppLocalizations.of(context).menuRequest,
                        "assets/icons/phananh-kiennghi.png"),
                  )
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                " ${AppLocalizations.of(context).otherService}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: SizeConfig.screenWidth * 0.05),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocConsumer<SettingBloc, SettingState>(builder: (c,s) {
                    _settingContext = c;
                    return  InkWell(
                      onTap: () {
                        BlocProvider.of<SettingBloc>(_settingContext).add(GetSettingE("hotline"));
                      },
                      child: cardItem(AppLocalizations.of(context).urgentCall, "assets/icons/emergency_call.png",
                          bgColor: 0xFFF8F8F8, textColor: Colors.black),
                    );
                  }, listener: (context, state){
                    _settingContext = context;
                    if(state is Success){
                    }
                  }),
                  BlocBuilder<SettingBloc, SettingState>(builder: (c,s) {
                    if(s is Success){
                      if (s.value == "off") {
                        return Container(  width: SizeConfig.screenWidth * 0.4, );
                      }
                      return  InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            // MaterialPageRoute(builder: (context) => MedicanPage(session: widget.session, phoneNumber: "0946706143", ))
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PhoneNumberCheck(session: widget.session)));
                        },
                        child: cardItem(AppLocalizations.of(context).medical, "assets/icons/yte.png",
                            bgColor: 0xFFF8F8F8, textColor: Colors.black),
                      );
                    }

                    if(s is SettingInitial){
                      BlocProvider.of<SettingBloc>(c).add(GetSettingE("show-test-func"));
                      return Container();
                    } else {
                      return Container();
                    }
                  }),

                ],
              ),

            ],
          ),
        ));
  }

  Widget cardItem(String title, String assets,
      {int bgColor = 0xFF388E3C,
      Color textColor = Colors.white,
      int bsColor = 0x59111111}) {
    return Container(
      width: SizeConfig.screenWidth * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      decoration: BoxDecoration(
          color: Color(bgColor),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color(bsColor), offset: Offset(1, -2), blurRadius: 5),
            BoxShadow(
                color: Color(bsColor), offset: Offset(-1, 2), blurRadius: 5)
          ]),
      child: Column(
        children: [
          Image.asset(
            assets,
            height: SizeConfig.screenHeight * 0.08,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: textColor,
                fontSize: SizeConfig.screenWidth * 0.035),
          )
        ],
      ),
    );
  }
}
