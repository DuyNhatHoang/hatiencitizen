class CreateUserRequest {
  String userName;
  String password;
  String phoneNumber;
  String fullName;
  String title;

  CreateUserRequest(
      {this.userName,
        this.password,
        this.phoneNumber,
        this.fullName,
        this.title});

  CreateUserRequest.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    data['title'] = this.title;
    return data;
  }
}