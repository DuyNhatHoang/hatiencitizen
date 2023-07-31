import 'dart:core';

import 'package:commons/commons.dart' as commons;
import 'package:commons/commons.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/employees/employee_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_logs/event_logs_bloc.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/blocs/form/form_bloc.dart';
import 'package:ha_tien_app/src/blocs/related_user/related_user_bloc.dart';
import 'package:ha_tien_app/src/blocs/setting/bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/arguments/detail_event_to_update_event_argument.dart';
import 'package:ha_tien_app/src/repositories/models/arguments/form_to_detail_argument.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/create_event_log_request.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/events/invite_employee_request.dart';
import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/repositories/remote/employees/employees_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_logs/event_logs_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/form/form_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/setting/settingrepo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/detail_event/components/image_slider_component.dart';
import 'package:ha_tien_app/src/ui/detail_event/history_event_page.dart';
import 'package:ha_tien_app/src/ui/home/dssc/update_event_screen.dart';
import 'package:ha_tien_app/src/ui/map/tracking_location_screen.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_connection.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DetailEmployeeEventScreen extends StatefulWidget {
  static const String routeName = '/DetailEmployeeEventScreen';
  final FormToDetailArgument argument;

  const DetailEmployeeEventScreen({Key key, this.argument}) : super(key: key);

  @override
  _DetailEmployeeEventScreenState createState() =>
      _DetailEmployeeEventScreenState();
}

class _DetailEmployeeEventScreenState extends State<DetailEmployeeEventScreen>
    with TickerProviderStateMixin {
  List<EventLog> _eventLogList;
  EventLog _firstEventLog;
  UserEvent _event;
  BuildContext _context;
  BuildContext _settingContext;
  BuildContext _formContext;
  List<Employee> selectedUser = List<Employee>();
  RelatedUserResponse relatedUserResponse;
  int inviteCount = 0;

  //use for fab bubble
  Animation<double> _animation;
  AnimationController _animationController;

  /// use for time line
  List<TimelineModel> timeLineList;
  Size size;
  List<Employee> employeeList = List<Employee>();
  List<Bubble> bubbleList;
  SessionManager _session;
  MyConnection connection;

  int statusId;

  @override
  void initState() {
    super.initState();
    _eventLogList = List<EventLog>();
    connection = MyConnection(context);
    statusId = statusId;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return FutureBuilder<SessionManager>(
        future: loadSession(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _session = snapshot.data;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => EventsBloc(EventsRepo.withToken(
                        snapshot.data.getSession().accessToken))),
                BlocProvider(
                    create: (context) => RelatedUserBloc(EventsRepo.withToken(
                        snapshot.data.getSession().accessToken))),
                BlocProvider(
                    create: (context) => EventLogsBloc(EventLogsRepo.withToken(
                        snapshot.data.getSession().accessToken))
                      ..add(GetEventLogsByEventIdEvent(
                          widget.argument.eventOfEmployee.id))),
                BlocProvider(
                    create: (context) => EmployeesBloc(EmployeesRepo.withToken(
                        _session.getSession().accessToken))),
                BlocProvider(
                    create: (context) => FormBloc(
                        FormRepo.withToken(_session.getSession().accessToken))),
                BlocProvider(
                    create: (context) => SettingBloc(
                        SettingRepo.withToken(_session.getSession().accessToken))),
              ],
              child: Stack(
                children: [
                  BlocConsumer<EventLogsBloc, EventLogsState>(
                      listener: (context, state) {
                        _context = context;
                        if (state is GetEventLogsByEventIdFailure) {
                          showSnackBar(context, state.error.getErrorMessage());
                        } else if (state is CreateEventLogSuccess) {
                          showSnackBar(context, "Đăng ký sự kiện thành công");
                          // commons.pop(context);
                          setState(() {});
                        }
                      }, builder: (context, state) {
                    if (state is GetEventLogsByEventIdSuccess) {
                      _eventLogList = state.data;
                      _firstEventLog = _eventLogList.first;
                      _event = _firstEventLog.event;
                      statusId = _event.status;
                      initBubbleList();
                      getRelatedUser();
                      return BaseSubPage(
                        suportIcon: Icons.access_time,
                        onBack: (){
                          Navigator.of(context).pop();
                        },
                        floatingActionButton: FloatingActionBubble(
                          // Menu items
                          items: bubbleList,

                          // animation controller
                          animation: _animation,

                          // On pressed change animation state
                          onPress: () => _animationController.isCompleted
                              ? _animationController.reverse()
                              : _animationController.forward(),

                          // onPress: _animationController.isCompleted
                          //     ? _animationController.reverse
                          //     : _animationController.forward,

                          // Floating Action button Icon color
                          iconColor: kPrimaryColor,

                          // Flaoting Action button Icon
                          icon: AnimatedIcons.menu_close,
                        ),
                        floatingActionButtonLocation:
                        FloatingActionButtonLocation.endFloat,
                        suportTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryEventPage(
                                  sessionManager: _session,
                                  event: _event,
                                ),
                              ));
                        },
                        title: AppLocalizations.of(context).detailed,
                        child: Container(
                          // margin: EdgeInsets.symmetric(
                          //     horizontal: SizeConfig.screenWidth * 0.01),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: SizeConfig.screenHeight * 0.02,),
                                  ImageSliderComponent(
                                    eventLogList: _eventLogList,
                                    // eventLogId: "0e77e030-5d79-4b12-a773-08d892dcc975",
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Text(
                                                "${widget.argument.eventOfEmployee
                                                    .eventTypeName}" ??
                                                    CircularProgressIndicator(),
                                                style: TextStyle(
                                                    fontSize: SizeConfig.screenWidth * 0.04,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          )),
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            color: Constants
                                                .statusColors[statusId],
                                          ),
                                          child: Text(
                                            "● ${Constants.getStatus(context, statusId)}" ??
                                                "Trống",
                                            style:
                                            TextStyle(color: kWhiteColor, fontSize: SizeConfig.screenWidth * 0.025),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.01,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.01,
                                      ),
                                      Icon(
                                        Icons.person,
                                        size: SizeConfig.screenWidth * 0.05,
                                      ),
                                      Text(
                                        "  ${_eventLogList.last.userName}",
                                        style: TextStyle(
                                            fontSize:
                                            SizeConfig.screenWidth * 0.035),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.01,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.01,
                                      ),
                                      Icon(
                                        Icons.event_note,
                                        size: SizeConfig.screenWidth * 0.05,
                                      ),
                                      Text(
                                        "  ${convertDateTimeToVN(widget.argument.eventOfEmployee.dateTime)}",
                                        style: TextStyle(
                                            fontSize:
                                            SizeConfig.screenWidth * 0.035),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.01,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.01,
                                      ),
                                      Icon(
                                        Icons.location_on,
                                        size: SizeConfig.screenWidth * 0.05,
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.8,
                                        child: Text(
                                          "  ${widget.argument.eventOfEmployee.address}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: SizeConfig.screenWidth *
                                                  0.035),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Text(
                                      "${_event.decription ?? "Trống"}",
                                      style: TextStyle(
                                          fontSize: SizeConfig.screenWidth * 0.025),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.02,
                                  ),
                                  relatedUserResponse != null
                                      ? relatedUsers(relatedUserResponse)
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Scaffold(body: myEmptyListWidget());
                  }),
                  BlocConsumer<EmployeesBloc, EmployeesState>(
                    listener: (context, state) {
                      if (state is GetEmployeesInProgress) {
                      } else if (state is GetEmployeesSuccess) {
                        print("GetEmployeesSuccess");
                        initUsersSelectDialog(context, state.data);
                      } else if (state is GetEmployeesFailure) {
                        print("GetEmployeesFailure");
                        showSnackBar(context, state.error.toString());
                      }
                    },
                    builder: (context, state) {
                      return Container();
                    },
                  ),
                  BlocConsumer<EventsBloc, EventsState>(
                    listener: (context, state) {
                      if (state is InviteEventToEmployeeIdInProgress) {
                      } else if (state is InviteEventToEmployeeIdSuccess) {
                        print("InviteEventToEmployeeIdSuccess");
                        showSnackBar(context, "Mời thành công");
                        // commons.pop(context);
                      } else if (state is InviteEventToEmployeeIdFailure) {
                        print("InviteEventToEmployeeIdFailure");
                        showSnackBar(context, state.error.toString());
                        Navigator.of(context).pop();
                      }
                    },
                    builder: (context, state) {
                      return Container();
                    },
                  ),
                  BlocConsumer<RelatedUserBloc, GetRelatedState>(
                    listener: (context, state) {
                      if (state is GetRelatedUserSuccess) {
                        print("GetRelatedUserSuccess");
                        setState(() {
                          relatedUserResponse = state.response;
                        });
                      } else if (state is GetRelatedUserFailure) {
                        print("GetRelatedUserFailure");
                      }
                    },
                    builder: (context, state) {
                      return Container();
                    },
                  ),
                  BlocConsumer<SettingBloc, SettingState>(builder: (c,s) {
                    _settingContext = c;
                    return Container();
                  }, listener: (context, state){
                    _settingContext = context;
                    if(state is Success){
                      launch("tel://${state.value}");
                    }
                  })
                ],
              ),
            );
          }
          return LoadingIndicator();
        });
  }

  Future<void> _onClickTracking(int action) async {
    await Navigator.of(_context).push(
      MaterialPageRoute(
          builder: (context) => TrackingLocationScreen(
            event: _event,
            action: action,
            argument: widget.argument,
            sessionManager: _session,
          )),
    );
    setState(() {});
  }

  Future<void> _onClickInvite() async {
    _onGetUserInForm(_context);
  }

  Future<void> _onClickReporting() {
    // Navigator.of(context)
    //     .pushNamed(AdministrativeReport.routeName, arguments: widget.argument);
    showOptionForm();
  }

  Future<void> _onClickUpdateEvent(int statusId) async {
    this.statusId = statusId;
    await Navigator.of(_context).pushNamed(UpdateEventScreen.routeName,
        arguments:
        DetailEventToUpdateEventArgument(_session, _event, statusId));
    setState(() {
      BlocProvider.of<EventLogsBloc>(_context)
          .add(GetEventLogsByEventIdEvent(widget.argument.eventOfEmployee.id));
    });
    commons.pop(context);
  }

  Future<void> _onClickHandleEvent(int statusId) async {
    if (statusId == EventLogTypeID.tiepNhanSuKien) {
      _showComfirmDialog(_context, "Bạn có chắc muốn tiếp nhận sự kiện này",
          EventLogTypeID.tiepNhanSuKien);
    } else if (statusId == EventLogTypeID.batDauXuLy) {
      _showComfirmDialog(_context, "Bạn có chắc muốn đăng ký xử lý sự kiện này",
          EventLogTypeID.batDauXuLy);
    }
    // setState(() {
    //   BlocProvider.of<EventLogsBloc>(_context)
    //       .add(GetEventLogsByEventIdEvent(widget.argument.eventOfEmployee.id));
    // });
  }

  void initBubbleList() {
    bubbleList = List<Bubble>();
    var xemBienBan = Bubble(
      title: "Xem biên bản",
      iconColor: kWhiteColor,
      bubbleColor: Colors.grey,
      icon: Icons.arrow_forward_rounded,
      titleStyle: TextStyle(fontSize: 16, color: Colors.white),
      onPress: () {
        _animationController.reverse();
        _onClickSeeForm();
      },
    );


    var vitri = Bubble(
      title: AppLocalizations.of(context).eventPlace,
      iconColor: kWhiteColor,
      bubbleColor: Colors.green,
      icon: Icons.place,
      titleStyle: TextStyle(fontSize: 16, color: Colors.white),
      onPress: () => _onPressTracking(2),
    );

    var urgentCall = Bubble(
      title: AppLocalizations.of(context).urgentCall,
      iconColor: kWhiteColor,
      bubbleColor: Colors.red,
      icon: Icons.phone,
      titleStyle: TextStyle(fontSize: 16, color: Colors.white),
      onPress: (){
       BlocProvider.of<SettingBloc>(_settingContext).add(GetSettingE("hotline"));
      },
    );
    bubbleList.add(vitri);
    bubbleList.add(urgentCall);
    if (statusId == Constants.dangXuLy || statusId == Constants.daXuLy) {
      // bubbleList.add(xemBienBan);
    }

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
    CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  _onPressTracking(int action) {
    _animationController.reverse();
    _onClickTracking(action);
  }

  _onInviteEmployee() {
    _animationController.reverse();
    _onClickInvite();
    setState(() {
      BlocProvider.of<EventLogsBloc>(_context)
          .add(GetEventLogsByEventIdEvent(widget.argument.eventOfEmployee.id));
    });
  }

  _onStartHandleEvent() {
    _animationController.reverse();
    _onClickInvite();
  }

  _onPressReporting() {
    _animationController.reverse();
    _onClickReporting();
  }

  Future<void> _onClickExchange(int statusId) async {
    await Navigator.of(_context).pushNamed(UpdateEventScreen.routeName,
        arguments:
        DetailEventToUpdateEventArgument(_session, _event, statusId));
    setState(() {
      BlocProvider.of<EventLogsBloc>(_context)
          .add(GetEventLogsByEventIdEvent(widget.argument.eventOfEmployee.id));
    });
  }

  _showComfirmDialog(BuildContext context, String content, int statusId) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Ok"),
          content: new Text("${content}"),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                BlocProvider.of<EventLogsBloc>(context)
                    .add(CreateEventLogEvent(CreateEventLogRequest(
                  status: getStatusDependLogType(statusId),
                  eventId: _event.id,
                  userId: _session.getSession().id,
                  information: statusId == EventLogTypeID.batDauXuLy
                      ? "${_session.getSession().fullName} bắt đầu xử lý"
                      : "${_session.getSession().fullName} tiếp nhận sự kiện",
                  eventLogTypeId: statusId,
                )));
                statusId == EventLogTypeID.batDauXuLy
                    ? BlocProvider.of<EventsBloc>(context)
                    .add(InviteEmployeeEvent(
                    request: InviteEmployeeRequest(
                      eventId: _event.id,
                      eventLogTypeId: Constants.moiXuLy,
                      information: "Đã tham gia sự kiện",
                      status: getStatusDependLogType(statusId),
                      userId: _session.getSession().id,
                    )))
                    : null;
                commons.pop(context);
                setState(() {
                  BlocProvider.of<EventLogsBloc>(_context).add(
                      GetEventLogsByEventIdEvent(
                          widget.argument.eventOfEmployee.id));
                });
              },
            )
          ],
        ));
  }

  void initUsersSelectDialog(BuildContext context, List<Employee> list) {
    var widgetList = Set<commons.SimpleItem>();
    var selectList = Set<commons.SimpleItem>();
    inviteCount = 0;
    int i = 0;
    employeeList = list;
    for (var i in relatedUserResponse.employees) {
      employeeList
          .removeWhere((element) => element.phoneNumber == i.phoneNumber);
    }

    employeeList.forEach((element) {
      widgetList.add(
          commons.SimpleItem(i++, "${element.fullName} (${element.title})"));
    });
    commons.multiSelectDialog(context, AppLocalizations.of(context).choose, widgetList, selectList,
            (item) async {
          selectList = item;
          for (var i in item) {
            selectedUser.add(employeeList[i.id]);
            _inviteEmployee(context, employeeList[i.id]);
          }
        }, autoClose: true, searchable: true);
  }

  void _onGetUserInForm(context) {
    BlocProvider.of<EmployeesBloc>(context).add(GetEmployeesEvent());
  }

  void _inviteEmployee(BuildContext context, Employee employee) {
    BlocProvider.of<EventsBloc>(context).add(InviteEmployeeEvent(
        request: InviteEmployeeRequest(
          eventId: _event.id,
          eventLogTypeId: EventLogTypeID.moiXuLy,
          information:
          "${_session.getSession().fullName} mời xử lý ${employee.fullName} ",
          status: _event.status,
          userId: employee.id,
        )));
    commons.pop(context);
  }

  void getRelatedUser() {
    BlocProvider.of<RelatedUserBloc>(_context)
        .add(GetRelateEvent(request: _event.id));
  }

  List<Container> _buildListItemsFromitems(List<Employee> list) {
    return list.map((item) {
      var container = Container(
          width: size.width,
          margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01, horizontal: SizeConfig.screenWidth * 0.05),
          padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.02, horizontal: SizeConfig.screenWidth * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/icons/user_location.png",
                    height: SizeConfig.screenWidth * 0.05,
                  ),
                  SizedBox(width: SizeConfig.screenWidth * 0.03,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.fullName}",
                        style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${item.phoneNumber}",
                          style: TextStyle(fontSize: SizeConfig.screenWidth * 0.03)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/icons/phone_icon.png",
                    height: SizeConfig.screenWidth * 0.05,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    "assets/icons/message_icon.png",
                    height: SizeConfig.screenWidth * 0.05,
                  ),
                ],
              )
            ],
          ));
      return container;
    }).toList();
  }

  Widget relatedUsers(RelatedUserResponse response) {
    ScrollController _controller = new ScrollController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).handlingOfficer,
          style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04, fontWeight: FontWeight.bold),
        ),
        Container(
            width: size.width,
            height: SizeConfig.screenHeight * 0.2,
            child: MediaQuery.removePadding(context: context,
                removeTop: true,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: _buildListItemsFromitems(response.employees),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: _controller,
                )))
      ],
    );
  }

  showOptionForm() {
    // var options = List<commons.Option>()
    //   ..add(commons.Option.item(Text("Biên bản hành chính"),
    //       icon: Icon(Icons.note_add), action: () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => AdministrativeReport(
    //             argument: widget.argument,
    //           ),
    //         ));
    //   }))
    //   ..add(commons.Option.item(Text("Quyết định xử phạt"),
    //       icon: Icon(Icons.note_add), action: () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => AdjudicateReport(
    //             argument: widget.argument,
    //           ),
    //         ));
    //   }));
    // commons.optionsDialog(
    //   context,
    //   "Chọn biên bản",
    //   options,
    // );
  }

  int getStatusDependLogType(int logTypeID) {
    switch (logTypeID) {
      case 1:
        return 0;
        break;

      case 2:
        return 7;
        break;

      case 3:
        return 1;
        break;

      case 4:
        return 1;
        break;

      case 5:
        return 0;
        break;

      case 6:
        return 1;
        break;

      case 7:
        return 1;
        break;

      case 8:
        return 1;
        break;

      case 9:
        return 1;
        break;

      case 10:
        return 1;
        break;

      case 11:
        return 1;
        break;

      case 12:
        return 1;
        break;

      case 13:
        return 1;
        break;

      case 14:
        return 1;
        break;

      case 15:
        return 0;
        break;
    }
  }

  void _onClickSeeForm() {
    BlocProvider.of<FormBloc>(_context)
        .add(GetFormEvent(widget.argument.eventOfEmployee.id));
  }
}
  