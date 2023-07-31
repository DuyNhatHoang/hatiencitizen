import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/frequently_questions/frequently_question_bloc.dart';
import 'package:ha_tien_app/src/blocs/notifications/notification_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/models.dart';
import 'package:ha_tien_app/src/repositories/models/notification/files.dart';
import 'package:ha_tien_app/src/repositories/remote/frequently_questions/frequently_question_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/notifications/notification_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DetailNotificationScreen extends StatefulWidget {
  static String routeName = '/DetailNotificationScreen';
  final String notificationId;

  const DetailNotificationScreen({Key key, this.notificationId})
      : super(key: key);

  @override
  _DetailNotificationScreenState createState() =>
      _DetailNotificationScreenState();
}

class _DetailNotificationScreenState extends State<DetailNotificationScreen> {
  NotificationData notification;
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseSubPage(
      title: AppLocalizations.of(context).detailed,
      onBack: (){
        Navigator.of(context).pop();
      },
      child: FutureBuilder<SessionManager>(
          future: loadSession(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BlocProvider(
                create: (context) => NotificationBloc(
                    NotificationRepo.withToken(
                        snapshot.data.getSession().accessToken))
                  ..add(GetNotificationByIdEvent(widget.notificationId)),
                child: BlocProvider(
                  create: (context) => FrequentlyQuestionBloc(
                      FrequentlyQuestionRepo.withToken(
                          snapshot.data.getSession().accessToken)),
                  child: BlocConsumer<NotificationBloc, NotificationState>(
                      listener: (context, state) {
                        if (state is GetNotificationByIdSuccess) {
                          _onGetNotificationSuccess(context);
                        } else if (state is DownloadNotificationFileFailure) {
                          print(state.error.getErrorMessage());
                        }
                      }, builder: (context, state) {
                    if (state is GetNotificationByIdSuccess ||
                        state is DownloadNotificationFileSuccess) {
                      if (state is GetNotificationByIdSuccess)
                        notification = state.data.first;
                      return SingleChildScrollView
                        (
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.screenHeight * 0.02,),
                            Container(
                              width: size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        notification.title,
                                        style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05, fontWeight: FontWeight.w500)
                                    ),
                                    SizedBox(height: SizeConfig.screenHeight * 0.01,),
                                    Text("${notification.category.description} | ${convertDateTime(notification.dateCreated)}", style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),),
                                    SizedBox(height: SizeConfig.screenHeight * 0.01,),
                                    Text(
                                        notification.description,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.black45)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black38 ,
                            ),
                            ExpansionTileCard(
                              key: cardA,
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).attachedFile,
                                  ),
                                  Text(
                                    notification.files.length.toString(),
                                  ),
                                ],
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: notification.files.length,
                                  itemBuilder: (context, index) => Container(
                                    width: size.width,
                                    height: size.height * 0.1,
                                    child: GestureDetector(
                                      onTap: () {
                                        _onTapFile(context,
                                            notification.files[index]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.attach_file_outlined,
                                                  size: 28,
                                                ),
                                                Text(notification
                                                    .files[index].fileName),
                                              ],
                                            ),
                                            Icon(
                                              Icons.file_download,
                                              size: 28,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            BlocConsumer<FrequentlyQuestionBloc,
                                FrequentlyQuestionState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state
                                  is GetFrequentlyQuestionByNotificationIdIdSuccess) {
                                    List<FrequentlyQuestion>
                                    frequentlyQuestions = state.data;
                                    return ExpansionTileCard(
                                      key: cardB,
                                      title: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Câu hỏi thường xuyên",
                                          ),
                                          Text(
                                            frequentlyQuestions.length
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 8.0,
                                              left: 16.0,
                                              right: 16.0,
                                            ),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: frequentlyQuestions
                                                    .length,
                                                itemBuilder:
                                                    (context, index) {
                                                  var item =
                                                  frequentlyQuestions[
                                                  index];
                                                  return ListTile(
                                                    title: Text(item.title),
                                                    subtitle: Text(
                                                        item.description),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else
                                    return LoadingIndicator();
                                })
                          ],
                        ),
                      );
                    } else
                      return LoadingIndicator();
                  }),
                ),
              );
            } else
              return LoadingIndicator();
          }),
    );
  }

  void _onGetNotificationSuccess(context) {
    BlocProvider.of<FrequentlyQuestionBloc>(context).add(
        GetFrequentlyQuestionsByNotificationIdEvent(widget.notificationId));
    // GetFrequentlyQuestionsByNotificationIdEvent(
    //     "1ab618a6-6f82-473e-6e9e-08d8982bfe7e"));
  }

  void _onTapFile(context, Files file) {
    BlocProvider.of<NotificationBloc>(context)
        .add(DownloadNotificationFileEvent(file));
  }
}
