class UpdateUserRequest {
  String phoneNumber;
  String fullName;
  String email;

  UpdateUserRequest({this.phoneNumber, this.fullName, this.email});

  UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    return data;
  }
}