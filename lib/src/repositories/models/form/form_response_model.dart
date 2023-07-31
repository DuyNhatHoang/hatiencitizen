import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/repositories/models/form/form_type.dart';
import 'package:ha_tien_app/src/repositories/models/form/quyet_dinh_xu_phat_thong_tu_3.dart';

import 'form_data.dart';

class FormResponse {
  String id;
  // Violator violator;
  // RecordMakers recordMaker;
  UserEvent event;
  FormType formType;
  String dateCreated;
  QuyetDinhXuPhatThongTu03 quyetDinhXuPhatThongTu03;
  BienBanViPhamHanhChinh03 bienBanViPhamHanhChinh03;
  FormType formStatusId;

  FormResponse(
      {this.id,
        // this.violator,
        // this.recordMaker,
        this.event,
        this.formType,
        this.dateCreated,
        this.quyetDinhXuPhatThongTu03,
        this.bienBanViPhamHanhChinh03,
        this.formStatusId});

  FormResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // violator = json['violator'] != null
    //     ? new Violator.fromJson(json['violator'])
    //     : null;
    // recordMaker = json['recordMaker'] != null
    //     ? new RecordMakers.fromJson(json['recordMaker'])
    //     : null;
    event =
    json['event'] != null ? new UserEvent.fromJson(json['event']) : null;
    formType = json['formType'] != null
        ? new FormType.fromJson(json['formType'])
        : null;
    dateCreated = json['dateCreated'];
    print("Loai form gi day ${formType.id}");
    if(formType.id == 6){
      bienBanViPhamHanhChinh03 = json['formData'] != null
          ? new BienBanViPhamHanhChinh03.fromJson(json['formData'])
          : null;
    } else
    if(formType.id == 10){
      quyetDinhXuPhatThongTu03 = json['formData'] != null
          ? new QuyetDinhXuPhatThongTu03.fromJson(json['formData'])
          : null;
    }
    formStatusId = json['formStatusId'] != null
        ? new FormType.fromJson(json['formStatusId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // if (this.violator != null) {
    //   data['violator'] = this.violator.toJson();
    // }
    // if (this.recordMaker != null) {
    //   data['recordMaker'] = this.recordMaker.toJson();
    // }
    if (this.event != null) {
      data['event'] = this.event.toJson();
    }
    if (this.formType != null) {
      data['formType'] = this.formType.toJson();
    }
    data['dateCreated'] = this.dateCreated;
    if (this.formStatusId != null) {
      data['formStatusId'] = this.formStatusId.toJson();
    }
    return data;
  }
}
