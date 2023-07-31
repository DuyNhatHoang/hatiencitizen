import 'package:ha_tien_app/src/repositories/models/event_file/event_file.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/repositories/models/users/user.dart';

import 'event_log_type.dart';

class EventLog {
  String id;
  User user;
  User taskMaster;
  UserEvent event;
  String dateTime;
  List<EventFiles> eventFiles;
  String eventName;
  String userName;
  EventLogType eventLogType;
  String eventId;
  String information;
  String userId;
  int status;
  int eventLogTypeId;

  EventLog(
      {this.id,
      this.user,
      this.taskMaster,
      this.event,
      this.dateTime,
      this.eventFiles,
      this.eventName,
      this.userName,
      this.eventLogType,
      this.eventId,
      this.information,
      this.userId,
      this.status,
      this.eventLogTypeId});

  EventLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    taskMaster = json['taskMaster'] != null
        ? new User.fromJson(json['taskMaster'])
        : null;
    event =
        json['event'] != null ? new UserEvent.fromJson(json['event']) : null;
    dateTime = json['dateTime'];
    // if (json['eventFiles'] != null) {
    //   eventFiles = new List<Null>();
    //   json['eventFiles'].forEach((v) {
    //     eventFiles.add(new EventFiles.fromJson(v));
    //   });
    // }
    eventName = json['eventName'];
    userName = json['userName'];
    eventLogType = json['eventLogType'] != null
        ? new EventLogType.fromJson(json['eventLogType'])
        : null;
    eventId = json['eventId'];
    information = json['information'];
    userId = json['userId'];
    status = json['status'];
    eventLogTypeId = json['eventLogTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['taskMaster'] = this.taskMaster;
    if (this.event != null) {
      data['event'] = this.event.toJson();
    }
    data['dateTime'] = this.dateTime;
    if (this.eventFiles != null) {
      data['eventFiles'] = this.eventFiles.map((v) => v.toJson()).toList();
    }
    data['eventName'] = this.eventName;
    data['userName'] = this.userName;
    if (this.eventLogType != null) {
      data['eventLogType'] = this.eventLogType.toJson();
    }
    data['eventId'] = this.eventId;
    data['information'] = this.information;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['eventLogTypeId'] = this.eventLogTypeId;
    return data;
  }
}
