import 'geo-response.dart';

class DetailPlace {
  Result result;
  String status;

  DetailPlace({this.result, this.status});

  DetailPlace.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Result {
  String placeId;
  String formattedAddress;
  Geometry geometry;
  String name;

  Result({this.placeId, this.formattedAddress, this.geometry, this.name});

  Result.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place_id'] = this.placeId;
    data['formatted_address'] = this.formattedAddress;
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}