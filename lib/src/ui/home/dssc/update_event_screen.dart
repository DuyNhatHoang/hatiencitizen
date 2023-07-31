import 'package:carousel_slider/carousel_slider.dart';
import 'package:commons/commons.dart' as commons;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/employees/employee_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_logs/event_logs_bloc.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/repositories/models/arguments/detail_event_to_update_event_argument.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/create_event_log_request.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/events/exchange_event_to_employee_id.dart';
import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';
import 'package:ha_tien_app/src/repositories/remote/employees/employees_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_logs/event_logs_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/ui/add_image/add_images_screen.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/components/my_drop_down_text_field.dart';
import 'package:ha_tien_app/src/ui/components/my_input_text_field.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_connection.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nice_button/NiceButton.dart';

class UpdateEventScreen extends StatefulWidget {
  static String routeName = "/UpdateEventScreen";
  final DetailEventToUpdateEventArgument argument;

  const UpdateEventScreen({Key key, this.argument}) : super(key: key);

  @override
  _UpdateEventScreenState createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  List<Asset> images = List<Asset>();
  List<Employee> employees = List<Employee>();
  Employee selectedEmployee;
  final _contentController = TextEditingController();
  List<MapEntry<String, MultipartFile>> mapEntries =
      List<MapEntry<String, MultipartFile>>();
  final _employeeController = TextEditingController();
  MyConnection connection;
  bool imageSizeCheck = true;
  String isImageLoad = "empty";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _contentController.dispose();
    connection = MyConnection(context);
    connection.checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => EventsBloc(EventsRepo.withToken(
                  widget.argument.session.getSession().accessToken))),
          BlocProvider(
              create: (context) => EventLogsBloc(EventLogsRepo.withToken(
                  widget.argument.session.getSession().accessToken))
                ..add(GetEventLogType())),
          BlocProvider(
              create: (context) => EmployeesBloc(EmployeesRepo.withToken(
                  widget.argument.session.getSession().accessToken))),
        ],
        child: Scaffold(
          appBar: buildMyAppBar(
            centerTitle: true,
            title: "Cập nhật sự cố",
          ),
          body: BlocConsumer<EmployeesBloc, EmployeesState>(
              listener: (context, state) {
            if (state is GetEmployeesSuccess) {
              _initEmployeesSelectDialog(state.data);
            } else if (state is GetEmployeesFailure) {
              showSnackBar(context, state.error.getErrorMessage());
            }
          }, builder: (context, state) {
            return BlocConsumer<EventLogsBloc, EventLogsState>(
              listener: (context, state) {
                if (state is CreateEventLogSuccess) {
                  _onCreateEventLogSuccess(context, state.data);
                } else if (state is CreateEventLogFailure) {
                  // showSnackBar(context, "Cập nhật sự cố lỗi");
                  showSnackBar(context, state.error.getErrorMessage());
                }
              },
              builder: (context, state) {
                if (state is GetEventLogTypeInProgress) {
                  return LoadingIndicator();
                }
                return BlocConsumer<EventsBloc, EventsState>(
                    listener: (context, state) {
                  if (state is UpdateEventFilesSuccess) {
                    showSnackBar(context, "Cập nhật sự cố thành công");
                    Navigator.of(context).pop();
                  } else if (state is UpdateEventFilesFailure) {
                    showSnackBar(context, "Cập nhật hình ảnh không thành công");
                  } else if (state is ExchangeEventToEmployeeIdSuccess) {
                    _onCreateEventLogSuccess(context, state.data);
                  }
                }, builder: (context, state) {
                  if (state is UpdateEventFilesInProgress ||
                      state is ExchangeEventToEmployeeIdInProgress) {
                    return LoadingIndicator();
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: kLightGrayColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                              ),
                              items: images
                                  .map((e) => Container(
                                        decoration: BoxDecoration(
                                          color: kBlackColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                        ),
                                        child: Center(
                                          child: AssetThumb(
                                            asset: e,
                                            height: (size.height * 0.3).round(),
                                            width: (size.width).round(),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          isImageLoad == "empty"
                              ? GestureDetector(
                                  onTap: () => _onTapAddPhoto(context),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.only(left: 5, top: 10),
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: kWhiteColor,
                                      size: 50,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                )
                              : CircularProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder<int>(
                              future: getStatus(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data ==
                                        EventLogTypeID.chuyenXuLy) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: MyActionTextField(
                                      onTap: () {
                                        _onTapChooseEmployee(context);
                                      },
                                      labelText: "Chọn cán bộ",
                                      suffixIcon: Icon(
                                        Icons.assignment_ind_rounded,
                                        color: kPrimaryColor,
                                      ),
                                      controller: _employeeController,
                                    ),
                                  );
                                } else
                                  return SizedBox();
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: MyInputTextField(
                              controller: _contentController,
                              labelText: "Ý kiến về sự cố",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NiceButton(
                            fontSize: Constants.largeFontSize,
                            elevation: 3.0,
                            radius: 12.0,
                            text: "Gửi",
                            background: kPrimaryColor,
                            onPressed: () => _onTapUpdate(context),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            );
          }),
        ));
  }

  _onTapAddPhoto(context) async {
    final result = await Navigator.pushNamed(context, AddImageScreen.routeName,
        arguments: images);
    setState(() {
      images = result;
      if (images == null) {
        images = List<Asset>();
      }
    });
  }

  _onTapUpdate(context) {
    if (!imageSizeCheck) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Vui lòng chờ hình ảnh được tải xong")));
      return;
    }
    {
      if (widget.argument.statusId == EventLogTypeID.chuyenXuLy) {
        BlocProvider.of<EventsBloc>(context)
            .add(ExchangeEventToEmployeeId(ExchangeEventToEmployeeIdRequest(
          eventLogTypeId: 1,
          information: _contentController.text,
          userId: selectedEmployee.id,
          status: widget.argument.event.status,
          // status: widget.argument.statusId,
          id: widget.argument.event.id,
        )));
      } else if (widget.argument.statusId == EventLogTypeID.huyTiepNhan ||
          widget.argument.statusId == EventLogTypeID.huyXuLy) {
        BlocProvider.of<EventLogsBloc>(context)
            .add(CreateEventLogEvent(CreateEventLogRequest(
          status: widget.argument.event.status,
          eventId: widget.argument.event.id,
          userId: widget.argument.session.getSession().id,
          information: _contentController.text,
          eventLogTypeId: widget.argument.statusId,
        )));
      } else if (widget.argument.statusId == EventLogTypeID.hoanTatXuLy) {
        BlocProvider.of<EventLogsBloc>(context)
            .add(CreateEventLogEvent(CreateEventLogRequest(
          status: 3,
          eventId: widget.argument.event.id,
          userId: widget.argument.session.getSession().id,
          information: _contentController.text,
          eventLogTypeId: widget.argument.statusId,
        )));
      } else {
        BlocProvider.of<EventLogsBloc>(context)
            .add(CreateEventLogEvent(CreateEventLogRequest(
          status: widget.argument.event.status,
          eventId: widget.argument.event.id,
          userId: widget.argument.session.getSession().id,
          information: _contentController.text,
          eventLogTypeId:
              widget.argument.statusId == 3 ? 8 : widget.argument.statusId,
        )));
      }
    }
  }

  Future<void> _onCreateEventLogSuccess(context, EventLog data) async {
    List<MapEntry<String, MultipartFile>> mapEntries =
        await convertImagesToMultipartFile();
    var formData = FormData();

    formData.files.addAll(mapEntries);
    
  }

  Future<List<MapEntry<String, MultipartFile>>>
      convertImagesToMultipartFile() async {
    List<MapEntry<String, MultipartFile>> mapEntries =
        List<MapEntry<String, MultipartFile>>();

    setState(() {
      isImageLoad == "loading";
      imageSizeCheck = false;
    });
    for (Asset i in images) {
      int resizeval = 100;
      var data = await i.getByteData();
      while (data.lengthInBytes > 1000000) {
        if (resizeval > 40) {
          resizeval -= 40;
        } else {
          if (resizeval > 10) {
            resizeval -= 10;
          } else
            resizeval -= 3;
        }

        data = await i.getByteData(quality: resizeval);
      }
      MultipartFile file =
          MultipartFile.fromBytes(data.buffer.asUint8List(), filename: i.name);
      mapEntries.add(MapEntry("files", file));
    }
    await images.forEach((element) async {
      var data = await element.getByteData();
      MultipartFile file = MultipartFile.fromBytes(data.buffer.asUint8List(),
          filename: element.name);
      mapEntries.add(MapEntry("files", file));
      print("PreIn: $mapEntries");
    });

    setState(() {
      isImageLoad == "empty";
      imageSizeCheck = true;
    });
    return mapEntries;
  }

  Future<int> getStatus() async {
    return await widget.argument.statusId;
  }

  void _onTapChooseEmployee(context) {
    BlocProvider.of<EmployeesBloc>(context).add(GetEmployeesEvent());
  }

  void _initEmployeesSelectDialog(List<Employee> list) {
    var widgetList = Set<commons.SimpleItem>();
    employees = list;
    for (int i = 0; i < list.length; i++) {
      widgetList.add(commons.SimpleItem(i, list[i].fullName));
    }
    commons.singleSelectDialog(context, "Chọn cán bộ", widgetList, (item) {
      selectedEmployee = employees[item.id];
      _employeeController.text = selectedEmployee.fullName;
    });
  }

  Future<Null> _selectDate(BuildContext context, String key) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2022));
    if (picked != null) {
      setState(() {});
    }
  }
}
