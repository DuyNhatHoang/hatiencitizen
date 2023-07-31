class CreateEventRequest {
  String decription;
  String latitude;
  String longitude;
  String phoneContact;
  bool emergency;
  String eventTypeId;
  String postedByUser;
  String address;
  String ward;

  CreateEventRequest(
      {this.decription,
        this.latitude,
        this.longitude,
        this.phoneContact,
        this.emergency,
        this.eventTypeId,
        this.postedByUser,
        this.address,
        this.ward});

  CreateEventRequest.fromJson(Map<String, dynamic> json) {
    decription = json['decription'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phoneContact = json['phoneContact'];
    emergency = json['emergency'];
    eventTypeId = json['eventTypeId'];
    postedByUser = json['postedByUser'];
    address = json['address'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['decription'] = this.decription;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phoneContact'] = this.phoneContact;
    data['emergency'] = this.emergency;
    data['eventTypeId'] = this.eventTypeId;
    data['postedByUser'] = this.postedByUser;
    data['address'] = this.address;
    data['ward'] = this.ward;
    return data;
  }
}