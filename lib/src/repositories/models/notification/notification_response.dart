import 'package:ha_tien_app/src/repositories/models/notification/notification.dart';

class NotificationResponse {
  int pageIndex;
  int pageSize;
  int totalSize;
  List<NotificationData> data;

  NotificationResponse(
      {this.pageIndex, this.pageSize, this.totalSize, this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalSize = json['totalSize'];
    if (json['data'] != null) {
      data = new List<NotificationData>();
      json['data'].forEach((v) {
        data.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalSize'] = this.totalSize;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}