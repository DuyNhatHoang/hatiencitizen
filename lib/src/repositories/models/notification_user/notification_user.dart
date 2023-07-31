import 'package:ha_tien_app/src/repositories/models/models.dart';

class NotificationUser {
  String id;
  bool seen;
  bool starred;
  bool isDeleted;
  String dateCreated;
  NotificationData notification;

  NotificationUser(
      {this.id,
      this.seen,
      this.starred,
      this.isDeleted,
      this.dateCreated,
      this.notification});

  NotificationUser.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) id = json['id'];
    if (json['seen'] != null) seen = json['seen'];
    if (json['starred'] != null) starred = json['starred'];
    if (json['isDeleted'] != null) isDeleted = json['isDeleted'];
    if (json['dateCreated'] != null) dateCreated = json['dateCreated'];
    notification = json['notification'] != null
        ? new NotificationData.fromJson(json['notification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seen'] = this.seen;
    data['starred'] = this.starred;
    data['isDeleted'] = this.isDeleted;
    data['dateCreated'] = this.dateCreated;
    if (this.notification != null) {
      data['notification'] = this.notification.toJson();
    }
    return data;
  }
}
