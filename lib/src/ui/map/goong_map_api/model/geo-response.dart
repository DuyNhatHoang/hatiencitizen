class GeoResponse {
  PlusCode plusCode;
  List<Results> results;
  String status;

  GeoResponse({this.plusCode, this.results, this.status});

  GeoResponse.fromJson(Map<String, dynamic> json) {
    plusCode = json['plus_code'] != null ? new PlusCode.fromJson(json['plus_code']) : null;
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) { results.add(new Results.fromJson(v)); });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
class Results {
  List<AddressComponents> addressComponents;
  String formattedAddress;
  Geometry geometry;
  String placeId;
  String reference;
  PlusCode plusCode;

  Results({this.addressComponents, this.formattedAddress, this.geometry, this.placeId, this.reference, this.plusCode});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = new List<AddressComponents>();
      json['address_components'].forEach((v) { addressComponents.add(new AddressComponents.fromJson(v)); });
    }
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null ? new Geometry.fromJson(json['geometry']) : null;
    placeId = json['place_id'];
    reference = json['reference'];
    plusCode = json['plus_code'] != null ? new PlusCode.fromJson(json['plus_code']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressComponents != null) {
      data['address_components'] = this.addressComponents.map((v) => v.toJson()).toList();
    }
    data['formatted_address'] = this.formattedAddress;
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    data['place_id'] = this.placeId;
    data['reference'] = this.reference;
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode.toJson();
    }
    return data;
  }
}

class AddressComponents {
  String longName;
  String shortName;

  AddressComponents({this.longName, this.shortName});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long_name'] = this.longName;
    data['short_name'] = this.shortName;
    return data;
  }
}

class Geometry {
  Location location;

  Geometry({this.location});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}

class Location {
  double lat;
  double lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}