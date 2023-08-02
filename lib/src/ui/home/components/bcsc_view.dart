import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:commons/commons.dart' as commonns;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ha_tien_app/src/blocs/event_logs/event_logs_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_statuses/event_status_bloc.dart';
import 'package:ha_tien_app/src/blocs/event_types/event_types_bloc.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/blocs/login/login_bloc.dart';
import 'package:ha_tien_app/src/blocs/notifications/notification_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/Setting.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/event_types/event_types.dart';
import 'package:ha_tien_app/src/repositories/remote/api_client.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_logs/event_logs_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_statuses/event_statuses_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/event_types/event_types_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/events/view_models/create_event_request.dart';
import 'package:ha_tien_app/src/repositories/remote/notifications/notification_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/base/dialog/loading_dialog.dart';
import 'package:ha_tien_app/src/ui/base/dialog/success_dialog.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/components/my_drop_down_text_field.dart';
import 'package:ha_tien_app/src/ui/components/my_input_text_field.dart';
import 'package:ha_tien_app/src/ui/home/components/video_viewer.dart';
import 'package:ha_tien_app/src/ui/map/goong_map_api/model/bcscmap_response.dart';
import 'package:ha_tien_app/src/ui/map/mapbox_search.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_connection.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/permission_helper.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:location/location.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nice_button/nice_button.dart';
import 'package:permission_handler/permission_handler.dart' as PH;
import 'package:signalr_core/signalr_core.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../home_screen.dart';
import 'gallery_app_view.dart';
import 'gallery_item.dart';

String movingEventId = "";
double eventLong = 0;
double eventLat = 0;
HubConnection connection1;

class BCSCView extends StatefulWidget {
  final SessionManager session;

  const BCSCView({Key key, this.session}) : super(key: key);

  @override
  _BCSCViewState createState() => _BCSCViewState();
}

class _BCSCViewState extends State<BCSCView> {
  // List<Asset> images = List<Asset>();
  List<AttachedFile> attached = List<AttachedFile>();
  String eventTypeId;
  bool imageSizeCheck = true;
  Session _session;
  List<EventType> eventTypes;
  LatLng _pickedLocation;
  List<MapEntry<String, MultipartFile>> mapEntries =
  List<MapEntry<String, MultipartFile>>();
  String ward;
  String district;
  String city;
  String address;
  EventLog log;
  final _eventTypeController = TextEditingController();
  final _addressController = TextEditingController();
  final _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  ScrollController scrollController = ScrollController();
  bool keyboardShow = false;
  BuildContext loaiSKContext;
  BuildContext loaiskcontext;
  PageController _controller;
  MyConnection connection;
  BuildContext currentContext;
  double totalFileUpload = 40000000;
  List<FileItem> choosefiles = List<FileItem>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connection = MyConnection(loaiskcontext);
    connection.checkConnection();
    checkLocationpermission();
    movingEventId = "";
    eventLong = 0;
    eventLat = 0;
    // signalRLocation();
  }

  @override
  void dispose() {
    super.dispose();
    _eventTypeController.dispose();
    _addressController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    Size size = MediaQuery.of(context).size;
    return BaseSubPage(
      title: AppLocalizations.of(context).createEvent,
      onBack: () {
        Navigator.of(context).pop();
      },
      child: MultiBlocProvider(
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
              create: (context) => LoginBloc(
                  AuthRepo.withToken(widget.session.getSession().accessToken),
                  null)
                ..add(GetUserInfoEvent())),
        ],
        child:
        BlocConsumer<EventsBloc, EventsState>(listener: (context, state) {
          if (state is CreateEventInProgress) {
            commonns.push(
              context,
              commonns.loadingScreen(
                context,
                loadingType: commonns.LoadingType.JUMPING,
              ),
            );
          } else if (state is CreateEventSuccess) {
            // showSnackBar(context, "Báo cáo sự kiện thành công");
            print("CreateEventSuccess");
            log = state.data;
            try {
              if (state.data.id.isNotEmpty && choosefiles.isNotEmpty ) {
                _onCreateEventSuccess(state.data.id);
              }
            } catch (e) {}
            if (attached.length < 1) {
              commonns.pop(context);
              _clearAll();
              showAppSuccesDialog(context,
                  subTitle: "Trang chủ",
                  title: "BÁO CÁO SỰ KIỆN THÀNH CÔNG",
                  mainTitle: "Lịch sử báo cáo", subTap: () {
                    commonns.pop(context);
                    commonns.pop(context);
                  }, mainTap: () {
                    commonns.pop(context);
                    commonns.pop(context);
                    final BottomNavigationBar navigationBar =
                        bottomBarKey.currentWidget;
                    navigationBar.onTap(1);
                  });
            }
          } else if (state is UpdateEventFilesSuccess) {
            _clearAll();
            commonns.pop(context);
            showAppSuccesDialog(context,
                subTitle: "Trang chủ",
                title: "BÁO CÁO SỰ KIỆN THÀNH CÔNG",
                mainTitle: "Lịch sử báo cáo", subTap: () {
                  commonns.pop(context);
                  commonns.pop(context);
                }, mainTap: () {
                  commonns.pop(context);
                  commonns.pop(context);
                  final BottomNavigationBar navigationBar =
                      bottomBarKey.currentWidget;
                  navigationBar.onTap(1);
                });
            // }
          } else if (state is UpdateEventFilesFailure) {
            showSnackBar(context, "${state.error.getErrorMessage()}");
            _clearAll();
            commonns.pop(context);
          } else if (state is CreateEventFailure) {
            showSnackBar(context, "${state.error.getErrorMessage()}");
            _clearAll();
            commonns.pop(context);
          }
        }, builder: (context, state) {
          return BlocConsumer<EventTypesBloc, EventTypesState>(
              listener: (context, state) {
                if (state is GetEventTypesSuccess) {
                  eventTypes = state.data;
                  _onShowSelectEventTypesDialog();
                }
              }, builder: (context, state) {
            loaiSKContext = context;
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is GetUserInfoSuccess) {
                        _session = state.data;
                      }
                    },
                    builder: (context, state) {
                      return Container();
                    },
                  ),
                  InkWell(
                    onTap: () => _showChooseAttachType(),
                    // onTap: () => _onTapAddPhoto(context),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.05),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          // color: Colors.black,
                          image: DecorationImage(
                              image: AssetImage("assets/icons/them_anh.png"),
                              fit: BoxFit.contain)),
                      child: choosefiles != null && choosefiles.isNotEmpty ? CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false),
                        items: choosefiles
                            .map((e) => Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: e.file.contains("jpeg") || e.file.contains("png") || e.file.contains("jpg")
                                ? Container(
                              height: (size.height * 0.3),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        e.file,
                                      ),
                                      fit: BoxFit.cover)),
                              width: (size.width),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      choosefiles.remove(e);
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            )
                                : FutureBuilder(
                              future: getThumbnailfile(e.file),
                              builder: (context, data){
                                if(data.hasData){
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    height: (size.height * 0.3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: FileImage(File(data.data)),
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: Center(
                                              child: Icon(Icons.play_arrow, size: 40, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoViewer(url: e.file,)));
                                          },
                                          child: Container(
                                            height: (size.height * 0.3),
                                            color:Colors.transparent,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                choosefiles.remove(e);
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(2),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  height: (size.height * 0.3),
                                  width: SizeConfig.screenWidth,
                                  child: Center(
                                    child: LoadingIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ))
                            .toList(),
                      ) : Container(
                        height: SizeConfig.screenHeight * 0.3,
                        width: SizeConfig.screenWidth,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  Column(
                    children: [
                      actionWidget(
                          AppLocalizations.of(context).chooseEventType,
                          Container(
                            width: size.width * 0.9,
                            child: MyActionTextField(
                              controller: _eventTypeController,
                              prefixIcon: Icon(
                                Icons.event,
                                color: Colors.black,
                                size: SizeConfig.screenWidth * 0.06,
                              ),
                              labelText: AppLocalizations.of(context).chooseEventType,
                              onTap: () => _onTapEventTypes(),
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          size),
                      SizedBox(
                        height: 20,
                      ),
                      actionWidget(
                          AppLocalizations.of(context).eventLocation,
                          Container(
                            width: size.width * 0.9,
                            child: MyActionTextField(
                              controller: _addressController,
                              labelText: AppLocalizations.of(context).eventLocation,
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Colors.black,
                                size: SizeConfig.screenWidth * 0.06,
                              ),
                              onTap: () => _onTapLocation(),
                            ),
                          ),
                          size),
                      SizedBox(
                        height: 20,
                      ),
                      actionWidget(
                          AppLocalizations.of(context).eventContent,
                          Container(
                            width: size.width * 0.9,
                            child: MyInputTextField(
                              line: 4,
                              controller: _contentController,
                              labelText:  AppLocalizations.of(context).eventContent,
                            ),
                          ),
                          size),
                      SizedBox(
                        height: 20,
                      ),
                      NiceButton(
                        fontSize: Constants.largeFontSize,
                        elevation: 3.0,
                        radius: 12.0,
                        width: SizeConfig.screenWidth * 0.9,
                        text:  AppLocalizations.of(context).createEvent,
                        background: Colors.green.withOpacity(0.8),
                        onPressed: () => _onTapSend(),
                      ),
                      KeyboardVisibilityBuilder(
                          builder: (context, isKeyboardVisible) {
                            double sheetHeight = MediaQuery.of(context).size.height;
                            double keyboardHeight =
                                MediaQuery.of(context).viewInsets.bottom;
                            isKeyboardVisible
                                ? scrollController.animateTo(sheetHeight * 0.3,
                                duration: Duration(seconds: 1),
                                curve: Curves.ease)
                                : null;
                            return isKeyboardVisible
                                ? SizedBox(height: sheetHeight - keyboardHeight)
                                : SizedBox(
                              height: 0,
                            );
                          }),
                    ],
                  )
                ],
              ),
            );
          });
        }),
      ),
    );
  }

  Widget actionWidget(String name, Widget child, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: SizeConfig.screenWidth * 0.05,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          color: Colors.black,
          height: 1,
        ),
        SizedBox(
          height: 15,
        ),
        child
      ],
    );
  }

  Future<void> _onShowSelectEventTypesDialog() async {
    Set<commonns.SimpleItem> set = Set<commonns.SimpleItem>();
    int i = 0;
    eventTypes.forEach((element) {
      set.add(commonns.SimpleItem(i++, element.name));
    });
    commonns.radioListDialog<commonns.SimpleItem>(
        context, "Chọn loại sự kiện", set, (commonns.Data item) {
      eventTypeId = eventTypes[item.id].id;
      _eventTypeController.text = "$item";
      print(item);
    }, selectedItem: commonns.SimpleItem(0, set.elementAt(0).title));
  }

  _onTapEventTypes() {
    BlocProvider.of<EventTypesBloc>(loaiSKContext).add(GetEventTypesEvent());
  }

  _onTapLocation() async {
    print("_onTapLocation");
    var detailAddress = "${_addressController.text}";
    await _onShowMap(detailAddress: detailAddress);
  }

  _onTapSend() async {
    if (await connection.checkConnection() == false) return;
    if (eventTypeId == null || eventTypeId.isEmpty) {
      Scaffold.of(loaiSKContext)
          .showSnackBar(SnackBar(content: Text("Vui lòng chọn loại sự kiện")));
      return;
    }
    if (_pickedLocation == null) {
      Scaffold.of(loaiSKContext)
          .showSnackBar(SnackBar(content: Text("Vui lòng chọn vị trí")));
      return;
    }
    if (_contentController.text.isEmpty) {
      Scaffold.of(loaiSKContext).showSnackBar(
          SnackBar(content: Text("Vui lòng nhập nội dung sự kiện")));
      return;
    }

    BlocProvider.of<EventsBloc>(loaiSKContext)
        .add(CreateEventEvent(CreateEventRequest(
      address: _addressController.text,
      decription: _contentController.text,
      emergency: false,
      eventTypeId: eventTypeId,
      latitude: _pickedLocation.latitude.toString(),
      longitude: _pickedLocation.longitude.toString(),
      phoneContact: "${widget.session.getSession().phoneNumber}",
      postedByUser: widget.session.getSession().id,
      ward: ward,
    )));
  }

  _onShowMap({String detailAddress}) async {
    showLoadingDialog(context);
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }
    try {
      geo.Position position = await geo.Geolocator()
          .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
      BSSCMapResponse result = await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => BCSCMap(_pickedLocation == null
                  ? LatLng(position.latitude, position.longitude)
                  : _pickedLocation)));
      setState(() {
        if (result != null) {
          _addressController.text = result.address;
          _pickedLocation = result.location;
        }
      });
    } catch (e) {}
    Navigator.pop(context);
  }

  void _clearAll() {
    setState(() {
      _eventTypeController.text = "";
      _addressController.text = "";
      _contentController.text = "";
      attached = List<AttachedFile>();
      eventTypeId = null;
      eventTypes = null;
      _pickedLocation = null;
      ward = null;
      district = null;
      city = null;
      address = null;
      imageSizeCheck = false;
      totalFileUpload = 40000000;
    });
  }

  Future<void> _onCreateEventSuccess(String eventLogId) async {
    try {
      BlocProvider.of<EventsBloc>(loaiSKContext).add(UpdateEventFilesEvent(
        eventLogId,
        choosefiles.map((e) => "\"${e.file}\"").toList(),
      ));
    } catch (e) {}
  }



  Future<void> _showChooseAttachType() async {
    if((await PH.Permission.camera.isGranted)){
    } else{
      await PH.Permission.camera.request();
    }
    print("_showChooseAttachType ${_session.userName}");
    List<Setting> settings = await ApiClient(Dio()).getSettings("upfile-url");
    print("${settings.first.value}/?user=${ widget.session.getSession().userName}&page=upfile");
    choosefiles.addAll(await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => GalleryAppView(session: widget.session.getSession(), url: settings.first.value),)
    ));
    setState(() {
      choosefiles = choosefiles;
    });
    print("lolol ${choosefiles.length}");
  }

}

class AttachedFile {
  final Uint8List file;
  final String extension;
  final String path;
  final int size;

  AttachedFile( {this.size,this.path, this.file, this.extension});
}

Future<Uint8List> getThumbnail(String path) async {
  final uint8list = await VideoThumbnail.thumbnailData(
    video: path,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 128,
// specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
    quality: 80,
  );
  return uint8list;
}


