class EventLogInformation {
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

  EventLogInformation(
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
        this.phoneContact});

  EventLogInformation.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    decription = json['Decription'];
    emergency = json['Emergency'];
    dateTime = json['DateTime'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    eventTypeId = json['EventTypeId'];
    eventTypeName = json['EventTypeName'];
    status = json['Status'];
    address = json['Address'];
    ward = json['Ward'];
    phoneContact = json['PhoneContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Decription'] = this.decription;
    data['Emergency'] = this.emergency;
    data['DateTime'] = this.dateTime;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['EventTypeId'] = this.eventTypeId;
    data['EventTypeName'] = this.eventTypeName;
    data['Status'] = this.status;
    data['Address'] = this.address;
    data['Ward'] = this.ward;
    data['PhoneContact'] = this.phoneContact;
    return data;
  }
}