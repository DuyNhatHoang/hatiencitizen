import 'dart:convert';

import 'package:ha_tien_app/src/ui/map/goong_map_api/model/detail_place.dart';
import 'package:ha_tien_app/src/ui/map/goong_map_api/model/geo-response.dart';
import 'package:ha_tien_app/src/ui/map/goong_map_api/model/place_response.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class GoongApi{
  static String url = "https://rsapi.goong.io/";
  static String apiKey = "bi0BkJLtjKZ8ZCzrzaxu8aRibwi1j4vSZ8uVS0MW";
  static Future<GeoResponse> getAddressByPoint(double lat, double long) async {
    print("MAP - getAddressByPoint: loading ${lat} : ${long}");

    try{
      http.Client client = http.Client();
      final response = await client.get(
        "${url}Geocode?latlng=${lat},%20${long}&api_key=${apiKey}",
        // +
        //     "?latlng=${lat},%20${long}&api_key=${apiKey}",
        // headers: {
        //   "Accept": "application/json",
        //   "content-type": "application/json",
        // },

      );
      print("MAP - getAddressByPoint: ${response.body}");
      GeoResponse data =  GeoResponse.fromJson(json.decode(response.body));
      return data;
    } catch(e){
      print("MAP - getAddressByPoint Error: ${e}");
      throw Exception();
    }
  }
  static Future<GeoResponse> getAddressByName(String name) async {
    print("MAP - getAddressByPoint: loading ${name}");

    try{
      http.Client client = http.Client();
      final response = await client.get(
        "${url}/geocode?address=${name}&api_key=${apiKey}",
        // url +
        //     "?latlng=${lat},%20${long}&api_key=${apiKey}",

      );
      print("MAP - getAddressByPoint: ${response.body}");
      GeoResponse data =  GeoResponse.fromJson(json.decode(response.body));
      return data;
    } catch(e){
      print("MAP - getAddressByPoint Error: ${e}");
      throw Exception();
    }
  }
  static Future<PlaceResponse> autoCompleteAddress(String name) async {
    print("MAP - getAddressByPoint: loading ${name}");

    try{
      http.Client client = http.Client();
      final response = await client.get(
        "${url}Place/AutoComplete?api_key=${apiKey}&input=${name}",
        // url +
        //     "?latlng=${lat},%20${long}&api_key=${apiKey}",

      );
      print("MAP - autoCompleteAddress: ${response.body}");
      PlaceResponse data =  PlaceResponse.fromJson(json.decode(response.body));
      return data;
    } catch(e){
      print("MAP - autoCompleteAddress Error: ${e}");
      throw Exception();
    }
  }
  static Future<DetailPlace> getDetailPlace(String placeId) async {
    print("MAP - getDetailPlace: loading ${placeId}");

    try{
      http.Client client = http.Client();
      final response = await client.get(
        "${url}Place/Detail?place_id=${placeId}&api_key=${apiKey}",
        // url +
        //     "?latlng=${lat},%20${long}&api_key=${apiKey}",

      );
      print("MAP - getDetailPlace: ${response.body}");
      DetailPlace data =  DetailPlace.fromJson(json.decode(response.body));
      return data;
    } catch(e){
      print("MAP - getDetailPlace Error: ${e}");
      throw Exception();
    }
  }
}