import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ha_tien_app/src/blocs/event_logs/event_logs_bloc.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/arguments/form_to_detail_argument.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/create_event_log_request.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/repositories/remote/event_logs/event_logs_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_connection.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:http/io_client.dart';
import 'package:location/location.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:ha_tien_app/src/ui/home/components/bcsc_view.dart';
class TrackingLocationScreen extends StatefulWidget {
  static String routeName = "/TrackingLocationScreen";
  final UserEvent event;
  final int action;
  final SessionManager sessionManager;
  final FormToDetailArgument argument;
  const TrackingLocationScreen(
      {Key key, this.event, this.action, this.sessionManager, this.argument})
      : super(key: key);

  @override
  _TrackingLocationScreenState createState() => _TrackingLocationScreenState();
}

class _TrackingLocationScreenState extends State<TrackingLocationScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Session session;
  var sessionManager;
  Timer timer;
  Location location = new Location();
  Size size;
  BuildContext blocContext;
// for my drawn routes on the map
  Set<Polyline> _polyLines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

// for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

// the user's initial location and current location
// as it moves
  LocationData currentLocation;

// a reference to the destination location
  LocationData destinationLocation;

// wrapper around the location API
  HubConnection connection1;
  double CAMERA_ZOOM = 16;
  double CAMERA_TILT = 0;
  double CAMERA_BEARING = 30;
  LatLng sourceLocation;
  LatLng destLocation;
  MyConnection connection;
  bool isMove = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connection = MyConnection(context);
    connection.checkConnection();
    print("vi tri sụ kien ${widget.event.latitude},${widget.event.longitude}");
    // create an instance of Location
    // location = new Location();
    polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location = new Location();
    moveCamera();
    location.onLocationChanged().listen((LocationData cLoc) {
      if (!mounted) return;
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      updatePinOnMap();
    });
    // set the initial location
  }

  void updatePinOnMap() async {
    if (!mounted) return;

    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition, // updated position
          icon: sourceIcon));
    });
  }

  setSourceAndDestinationIcons() async {
    sourceIcon = await bitmapDescriptorFromSvgAsset(
        context, 'assets/icons/placeholder.svg', Colors.redAccent);

    destinationIcon = await bitmapDescriptorFromSvgAsset(
        context, 'assets/icons/tracking.svg', Colors.redAccent);
  }

  Future<bool> setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    // currentLocation = LocationData.fromMap({
    //   "latitude": SOURCE_LOCATION.latitude,
    //   "longitude": SOURCE_LOCATION.longitude
    // });
    if(eventLong == 0){
      currentLocation = await location.getLocation();
      sourceLocation =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      destLocation = LatLng(double.parse(widget.event.latitude), double.parse(widget.event.longitude));
    } else{
      sourceLocation =
          LatLng(eventLat, eventLong);
      destLocation = LatLng(double.parse(widget.event.latitude), double.parse(widget.event.longitude));
    }


    // hard-coded destination for this example
    destinationLocation = LocationData.fromMap({
      "latitude": destLocation.latitude,
      "longitude": destLocation.longitude
    });
    return true;
  }

  showPinsOnMap() async {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    var destPosition =
        LatLng(destinationLocation.latitude, destinationLocation.longitude);
    await setSourceAndDestinationIcons();
// add the initial source location pin
    _markers.add(Marker(
      markerId: MarkerId('sourcePin'),
      position: pinPosition,
      icon: sourceIcon,
    ));

    // destination pin
    _markers.add(Marker(
      markerId: MarkerId('destPin'),
      position: destPosition,
      icon: destinationIcon,
    ));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolyLines();
    if (widget.action == 1) signalRLocation();
  }

  void setPolyLines() async {
    polylineCoordinates = [];
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.GOOGLE_MAP_API,
        currentLocation.latitude,
        currentLocation.longitude,
        destinationLocation.latitude,
        destinationLocation.longitude);
    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polyLines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("tracking"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: buildMyAppBar(
        //   title: "Bản đồ di chuyển",
        //   centerTitle: true,
        //   actions: <Widget>[
        //     Padding(
        //         padding: EdgeInsets.only(right: 20.0, top: 15),
        //         child: GestureDetector(
        //             onTap: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) => HistoryEventPage(
        //                       sessionManager: sessionManager,
        //                       event: widget.event,
        //                     ),
        //                   ));
        //             },
        //             child: Stack(
        //               children: <Widget>[
        //                 Icon(
        //                   Icons.access_time,
        //                   size: 25.0,
        //                   color: Colors.white,
        //                 ),
        //               ],
        //             ))),
        //   ],
        // ),
        body: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => EventsBloc(EventsRepo.withToken(
                widget.sessionManager.getSession().accessToken))),
        BlocProvider(
            create: (context) => EventLogsBloc(EventLogsRepo.withToken(
                widget.sessionManager.getSession().accessToken))
              ..add(GetEventLogsByEventIdEvent(
                  widget.argument.eventOfEmployee.id))),
      ],
      child: BlocConsumer<EventLogsBloc, EventLogsState>(
        listener: (context, state) {
          if (state is GetEventLogsByEventIdFailure) {
            showSnackBar(context, "Có lỗi xãy ra vui lòng thử lại");
          } else if (state is CreateEventLogSuccess) {
            print("CreateEventLogSuccess");
            // Navigator.of(context).pop();
          } else if (state is CreateEventLogFailure) {
            print("CreateEventLogFailure");
          }
        },
        builder: (context, state) {
          blocContext = context;
          return FutureBuilder(
              future: setInitialLocation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  CameraPosition initialCameraPosition = CameraPosition(
                      zoom: CAMERA_ZOOM,
                      tilt: CAMERA_TILT,
                      bearing: CAMERA_BEARING,
                      target: LatLng(double.parse(widget.event.latitude), double.parse(widget.event.longitude)));
                  // if (currentLocation != null) {
                  //   initialCameraPosition = CameraPosition(
                  //       target: LatLng(double.parse(widget.event.latitude), double.parse(widget.event.longitude)),
                  //       zoom: CAMERA_ZOOM,
                  //       tilt: CAMERA_TILT,
                  //       bearing: CAMERA_BEARING);
                  // }
                  return Container(
                    height: size.height,
                    width: size.width,
                    child: Stack(
                      children: <Widget>[
                        GoogleMap(
                          myLocationEnabled: true,
                          compassEnabled: true,
                          tiltGesturesEnabled: false,
                          markers: _markers,
                          polylines: _polyLines,
                          mapType: MapType.normal,
                          initialCameraPosition: initialCameraPosition,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                            // my map has completed being created;
                            // i'm ready to show the pins on the map
                            showPinsOnMap();
                          },
                          myLocationButtonEnabled: true,
                          onTap: (LatLng latLng) => _onTapMap(latLng),
                        ),
                        widget.action == 1
                            ? Container(
                                height: size.height,
                                width: size.width,
                                child: Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      isMove == false
                                          ? RaisedButton(
                                              color: Colors.green,
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              onPressed: () async {
                                                setState(() {
                                                  isMove = true;
                                                });
                                                signalRLocation();
                                                // showSnackBar(context,
                                                //     "Bắt đầu di chuyển");
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                width: size.width,
                                                child: Center(
                                                  child: Text(
                                                    "Bắt đầu di chuyển",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : RaisedButton(
                                              color: Colors.red,
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              onPressed: () {
                                                setState(() {
                                                  isMove = false;
                                                });
                                                connection1.stop();
                                                timer.cancel();
                                                BlocProvider.of<EventLogsBloc>(
                                                        blocContext)
                                                    .add(CreateEventLogEvent(
                                                        CreateEventLogRequest(
                                                  status: widget.event.status,
                                                  eventId: widget.event.id,
                                                  userId: widget.sessionManager
                                                      .getSession()
                                                      .id,
                                                  information: "",
                                                  eventLogTypeId: EventLogTypeID
                                                      .dungDiChuyen,
                                                )));
                                                showSnackBar(
                                                    context, "Dừng di chuyển");
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                width: size.width,
                                                child: Center(
                                                  child: Text(
                                                    "Dừng di chuyển",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      RaisedButton(
                                        color: Colors.green,
                                        onPressed: () {
                                          showSnackBar(
                                              context, "Hoàn thành di chuyển");
                                          BlocProvider.of<EventLogsBloc>(
                                                  blocContext)
                                              .add(CreateEventLogEvent(
                                                  CreateEventLogRequest(
                                            status: widget.event.status,
                                            eventId: widget.event.id,
                                            userId: widget.sessionManager
                                                .getSession()
                                                .id,
                                            information: "",
                                            eventLogTypeId:
                                                EventLogTypeID.daTiepCanSuKien,
                                          )));
                                          connection1.stop();
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          width: size.width,
                                          child: Center(
                                            child: Text(
                                              "Đã tiếp cận sự kiện",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                } else
                  return LoadingIndicator();
              });
        },
      ),
    ));
  }

  _onTapMap(LatLng location) {
    // setState(() {
    //   currentLocation = LocationData.fromMap(
    //       {"latitude": location.latitude, "longitude": location.longitude});
    //   updatePinOnMap();
    //   setPolyLines();
    // });
  }

  Future<void> moveCamera() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }

  void signalRLocation() async {
    showSnackBar(context, "Bắt đầu di chuyển");
    sessionManager = await loadSession();
    session = sessionManager.getSession();
    try {
      print("currentLocation ${currentLocation.longitude}");
      BlocProvider.of<EventLogsBloc>(blocContext)
          .add(CreateEventLogEvent(CreateEventLogRequest(
        status: widget.event.status,
        eventId: widget.event.id,
        userId: widget.sessionManager.getSession().id,
        information: "",
        eventLogTypeId: EventLogTypeID.batDauDiChuyen,
      )));
    } catch (e) {}
    connection1 = HubConnectionBuilder()
        .withUrl(
            'https://smarthatien.bakco.vn/centerHub',
            HttpConnectionOptions(
                transport: HttpTransportType.webSockets,
                client: IOClient(
                    HttpClient()..badCertificateCallback = (x, y, z) => true),
                logging: (level, message) => print('SendLatLong: $message'),
                accessTokenFactory: () =>
                    Future.value("${session.accessToken}"),
                skipNegotiation: true))
        .withAutomaticReconnect()
        .build();
    connection1.serverTimeoutInMilliseconds = 99999;
    await connection1.start();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
      await connection1.invoke("SendLatLong", args: [
        "${currentLocation.latitude}",
        "${currentLocation.longitude}",
        "${widget.event.id}"
      ]);
      print("Send long lat thành công");
    });
  }
}
