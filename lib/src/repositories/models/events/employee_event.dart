import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/repositories/models/event_status/event_status.dart';
import 'package:ha_tien_app/src/repositories/models/users/user.dart';

class EventOfEmployee {
  EventLog eventLog;
  int totalTime;
  User user;
  EventStatus eventStatus;
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
  String phoneContact;

  EventOfEmployee(
      {this.eventLog,
      this.totalTime,
      this.user,
      this.eventStatus,
      this.id,
      this.decription,
      this.emergency,
      this.dateTime,
      this.latitude,
      this.longitude,
      this.eventTypeId,
      this.eventTypeName,
      this.status,
      this.address,
      this.phoneContact});

  EventOfEmployee.fromJson(Map<String, dynamic> json) {
    eventLog = json['eventLog'] != null
        ? new EventLog.fromJson(json['eventLog'])
        : null;
    totalTime = json['totalTime'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    ;
    eventStatus = json['eventStatus'] != null
        ? new EventStatus.fromJson(json['eventStatus'])
        : null;
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
    phoneContact = json['phoneContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventLog != null) {
      data['eventLog'] = this.eventLog.toJson();
    }
    data['totalTime'] = this.totalTime;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.eventStatus != null) {
      data['eventStatus'] = this.eventStatus.toJson();
    }
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
    data['phoneContact'] = this.phoneContact;
    return data;
  }
}
