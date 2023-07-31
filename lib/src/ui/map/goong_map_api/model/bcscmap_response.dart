import 'package:google_maps_flutter/google_maps_flutter.dart';

class BSSCMapResponse{
  final LatLng location;
  final String address;

  BSSCMapResponse(this.location, this.address);
}