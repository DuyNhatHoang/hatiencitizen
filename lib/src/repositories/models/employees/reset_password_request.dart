class ResetPasswordRequest {
  String oldpass;
  String newPassword;

  ResetPasswordRequest({this.oldpass, this.newPassword});

  ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    oldpass = json['oldPassword'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldPassword'] = this.oldpass;
    data['newPassword'] = this.newPassword;
    return data;
  }
}