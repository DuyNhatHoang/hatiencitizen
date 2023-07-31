import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/notifications/notification_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/models.dart';
import 'package:ha_tien_app/src/repositories/models/notification/notification.dart';
import 'package:ha_tien_app/src/repositories/models/notification/requests/get_notification_users_request.dart';
import 'package:ha_tien_app/src/repositories/remote/notifications/notification_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/detail_notification/detail_notification_screen.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class NotificationPage extends StatefulWidget {
  final SessionManager session;

  const NotificationPage({Key key, this.session}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationPage> {
  int _pageIndex = 1;
  int _pageSize = 20;
  BuildContext _context;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      title:AppLocalizations.of(context).notify,
      onBack: (){
        Navigator.of(context).pop();
      },
      child: BlocProvider(
        create: (context) => NotificationBloc(
            NotificationRepo.withToken(widget.session.getSession().accessToken)),
        child: BlocConsumer<NotificationBloc, NotificationState>(
            listener: (context, state) {},
            builder: (context, state) {
              _context = context;
              if(state is NotificationInitial){
                BlocProvider.of<NotificationBloc>(_context).add(GetNotificationByIdEvent(""));
              } else
              if (state is GetNotificationByIdSuccess) {
                List<NotificationData> data = state.data;
                if (data.length == 0) {
                  return myEmptyListWidget();
                }
                return Container(
                  height: SizeConfig.screenHeight * 0.9,
                  margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.01, left:SizeConfig.screenWidth * 0.03 ),
                  child: MediaQuery.removePadding(context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            // _onTapDetailNotification(
                            //     "2b61ecc9-316d-4d45-4d25-08d898326d6e");
                            _onTapDetailNotification(data[index].id);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.005),
                            margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide( //
                                  color: Colors.black38,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.001),
                                  height: SizeConfig.screenWidth * 0.03,
                                  width: SizeConfig.screenWidth * 0.03,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green
                                  ),
                                ),
                                Container(

                                  margin: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].title,
                                        style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05, fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: SizeConfig.screenHeight * 0.004),
                                      Text(
                                        convertDateTimeToVN(data[index].dateCreated),
                                        style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                                      ),
                                      SizedBox(height: SizeConfig.screenHeight * 0.004,),
                                      Text(
                                          data[index].description,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(fontSize: SizeConfig.screenWidth * 0.045, fontWeight: FontWeight.w300, color: Colors.black54
                                          )),
                                      SizedBox(height: SizeConfig.screenHeight * 0.005,),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                );
              }
              return LoadingIndicator();
            }),
      ),
    );
  }

  void _onTapDetailNotification(String notificationId) {
    Navigator.of(context).pushNamed(DetailNotificationScreen.routeName,
        arguments: notificationId);
  }
}
