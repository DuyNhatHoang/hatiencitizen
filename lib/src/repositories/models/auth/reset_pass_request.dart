class ResetPassRequest {
  String phoneNumber;
  String id;
  String newPass;

  ResetPassRequest(
      {
        this.phoneNumber,
        this.newPass,
        this.id});

  ResetPassRequest.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    id = json['id'];
    newPass = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['id'] = this.id;
    data['newPassword'] = this.newPass;
    return data;
  }
}