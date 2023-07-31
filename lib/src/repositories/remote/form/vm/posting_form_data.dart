import 'package:dio/dio.dart';
import 'package:ha_tien_app/src/repositories/models/form/form_data.dart';

class PostingFormData {
  FormEventData formData;
  String violatorId;
  String eventId;
  int formTypeId;

  PostingFormData({this.formData, this.violatorId, this.eventId, this.formTypeId});

  PostingFormData.fromJson(Map<String, dynamic> json) {
    formData = json['formData'] != null ? new FormEventData.fromJson(json['formData']) : null;
    violatorId = json['violatorId'];
    eventId = json['eventId'];
    formTypeId = json['formTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.formData != null) {
      data['formData'] = this.formData.toJson();
    }
    data['violatorId'] = this.violatorId;
    data['eventId'] = this.eventId;
    data['formTypeId'] = this.formTypeId;
    return data;
  }
}
