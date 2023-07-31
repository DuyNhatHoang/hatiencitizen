class MyUserEventDistance {
  String id;
  String decription;
  bool emergency;
  String dateTime;
  String latitude;
  String longitude;
  String eventTypeId;
  String eventTypeName;
  int status;
  String address;
  String ward;
  String phoneContact;
  int distance;

  MyUserEventDistance(
      {this.id,
      this.decription,
      this.emergency,
      this.dateTime,
      this.latitude,
      this.longitude,
      this.eventTypeId,
      this.eventTypeName,
      this.status,
      this.address,
      this.ward,
      this.phoneContact,
      this.distance});

  MyUserEventDistance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    decription = json['decription'];
    emergency = json['emergency'];
    dateTime = json['dateTime'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    eventTypeId = json['eventTypeId'];
    eventTypeName = json['eventTypeName'];
    status = json['status'];
    address = json['address'];
    ward = json['ward'];
    phoneContact = json['phoneContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['decription'] = this.decription;
    data['emergency'] = this.emergency;
    data['dateTime'] = this.dateTime;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['eventTypeId'] = this.eventTypeId;
    data['eventTypeName'] = this.eventTypeName;
    data['status'] = this.status;
    data['address'] = this.address;
    data['ward'] = this.ward;
    data['phoneContact'] = this.phoneContact;
    return data;
  }
}
