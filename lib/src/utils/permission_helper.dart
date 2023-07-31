import 'package:location/location.dart';

Location location = new Location();
bool locationServiceEnable;
PermissionStatus locationPerGranted;
LocationData locationData;
void checkLocationpermission() async {
  locationServiceEnable = await location.serviceEnabled();
  if (!locationServiceEnable) {
    locationServiceEnable = await location.requestService();
    if (!locationServiceEnable) {
      return;
    }
  }
  locationPerGranted = await location.hasPermission();
  if (locationPerGranted == PermissionStatus.DENIED) {
    locationPerGranted = await location.requestPermission();
    if (locationPerGranted != PermissionStatus.GRANTED) {
      return;
    }
  }
  locationData = await location.getLocation();
}
