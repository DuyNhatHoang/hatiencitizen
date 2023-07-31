class FormForEmployeeRequest {
  List<String> userIds;
  String formId;

  FormForEmployeeRequest({this.userIds, this.formId});

  FormForEmployeeRequest.fromJson(Map<String, dynamic> json) {
    userIds = json['userIds'].cast<String>();
    formId = json['formId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userIds'] = this.userIds;
    data['formId'] = this.formId;
    return data;
  }
}