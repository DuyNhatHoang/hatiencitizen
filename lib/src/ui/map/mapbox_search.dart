import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:ha_tien_app/src/ui/map/goong_map_api/model/detail_place.dart';
import 'package:ha_tien_app/src/ui/map/goong_map_api/model/place_response.dart';
import 'package:ha_tien_app/src/ui/map/widget/search_widget.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:location/location.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapbox;
import 'package:nice_button/NiceButton.dart';

import 'goong_map_api/model/bcscmap_response.dart';
import 'goong_map_api/model/geo-response.dart' as GeoResponse;
import 'goong_map_api/request/geocoding.dart';

class BCSCMap extends StatefulWidget {
  final LatLng location;
  const BCSCMap(this.location);

  @override
  State createState() => BCSCMapState();
}

class BCSCMapState extends State<BCSCMap> {
  GoogleMapController _controller;

  BitmapDescriptor sourceIcon;

  double CAMERA_ZOOM = 16;
  double CAMERA_TILT = 0;
  double CAMERA_BEARING = 30;
  Set<Marker> _markers = Set<Marker>();
  Location location = new Location();

  CameraPosition initialCameraPosition;

  //app data
  String address = "";
  LatLng addressLocation;
  bool showSuggestLocationDialog = false;
  PlaceResponse listAddress = PlaceResponse();

  setSourceAndDestinationIcons() async {
    sourceIcon = await bitmapDescriptorFromSvgAsset(
        context, 'assets/icons/placeholder.svg', Colors.redAccent);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // by "listening" to the location's onLocationChanged event
    location = new Location();
    initialCameraPosition = CameraPosition(
      target: widget.location,
      // target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: CAMERA_ZOOM,
    );
    addressLocation = widget.location;
    moveCamera();
    _markers.add(Marker(
      markerId: MarkerId(location.toString()),
      position: widget.location,
      // position: LatLng(currentLocation.latitude, currentLocation.longitude),
      infoWindow: InfoWindow(
        title: '',
      ),
      icon:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    ));
    GoongApi.getAddressByPoint(widget.location.latitude, widget.location.longitude).then((value){
    // GoongApi.getAddressByPoint(currentLocation.latitude, currentLocation.longitude).then((value){
      String temp = value.results.first.formattedAddress;
      setState(() {
        address = temp;
      });
    });
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchWidget(
              width: SizeConfig.screenWidth * 0.7,
              height: SizeConfig.screenHeight * 0.05,
              onChanged: (s){
                if(!showSuggestLocationDialog){
                  setState(() {
                    showSuggestLocationDialog = true;
                  });
                }
                GoongApi.autoCompleteAddress(s).then((value){
                  setState(() {
                    listAddress = value;
                  });
                });
              },

            ),
            InkWell(
              onTap: (){
                Navigator.of(context).pop(BSSCMapResponse(addressLocation, address));
              },
              child: Text("Xong  ", style: TextStyle(color: Colors.white, fontSize: SizeConfig.screenWidth * 0.05),),
            )
          ],
        ),
        // leading: leading,
        // actions: actions,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: kWhiteColor,
        ),
      ),
        body: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              markers: _markers,
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                // my map has completed being created;
                // i'm ready to show the pins on the map
              },
              myLocationButtonEnabled: false,
              onTap: _onTapMap,
            ),
            Align(                        
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      margin: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      // height: SizeConfig.screenHeight * 0.1,
                      width: SizeConfig.screenWidth * 0.8,
                      child: Text(address, style: TextStyle(fontSize: SizeConfig.screenWidth * 0.045, ),),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.15,
                      height: SizeConfig.screenWidth * 0.15, margin: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        shape: BoxShape.circle
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop(BSSCMapResponse(addressLocation, address));
                        },
                        child: Icon(Icons.arrow_forward_outlined, color: Colors.white,),
                      ))
                  ],
                ),
              )
            ),
            showSuggestLocationDialog ? Align(
              alignment: Alignment.topCenter,
               child: Container(
                 decoration: BoxDecoration(
                   color: Colors.white
                 ),
                 // height: SizeConfig.screenHeight * 0.7,
                 width: SizeConfig.screenWidth * 0.9,
                 child: ListView(
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   children: _buildListItemsFromitems(listAddress),
                   physics: const BouncingScrollPhysics(
                       parent: AlwaysScrollableScrollPhysics()),
                 ),
               ),
            ):Container()
          ],
        ));
  }

  _onTapMap(LatLng location) async {
    setState(() {
      //add marker
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(
          title: '',
        ),
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));

    });
    //animate camera  
    double zoom = await _controller.getZoomLevel();
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location.latitude, location.longitude),
        zoom: zoom)));
    addressLocation = location;
    //test place search
    GoongApi.getAddressByPoint(location.latitude, location.longitude).then((value){
      String temp = value.results.first.formattedAddress;
      // for(var i in value.results.first.addressComponents){
      //   temp += "${i.longName},";
      // }
      setState(() {
         address = temp;
      });
    });
  }

  List<Widget> _buildListItemsFromitems(PlaceResponse data) {
    // print('duy ${data.results.length}');
    if(data == null || data.predictions ==  null){
      return [Container()];
    }
    return data.predictions.map((e){
      String temp = "";
       return InkWell(
         onTap: () async {
           DetailPlace detailPlace = await GoongApi.getDetailPlace(e.placeId);
           setState(() {
             showSuggestLocationDialog = false;
              address = e.description;
             addressLocation = LatLng(detailPlace.result.geometry.location.lat, detailPlace.result.geometry.location.lng);
           });
           //animate camera
           double zoom = await _controller.getZoomLevel();
           _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
               target: LatLng(detailPlace.result.geometry.location.lat, detailPlace.result.geometry.location.lng),
               zoom: zoom)));
         },
         child: Container(
           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
           child: Text(e.description, style: TextStyle(fontSize: SizeConfig.screenWidth * 0.045, )),
         ),
       );
    }).toList();
  }

  void onStyleLoadedCallback() {}


  Future<void> moveCamera( ) async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: widget.location,
      // target: LatLng(data.latitude, data.longitude),
    );
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }
}
