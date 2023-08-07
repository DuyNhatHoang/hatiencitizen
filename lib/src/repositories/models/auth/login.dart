class Login {
  String id;
  String accessToken;
  String fullName;
  String userName;
  String roles;
  int expiresIn;
  String phoneAddress;
  bool phoneNumberConfirmed;

  Login(
      {this.id,
      this.accessToken,
      this.fullName,
      this.userName,
      this.roles,
      this.phoneNumberConfirmed,
      this.expiresIn});

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['access_token'];
    fullName = json['fullname'];
    userName = json['userName'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    roles = json['roles'];
    expiresIn = json['expires_in'];
    phoneAddress = json['phoneAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['access_token'] = this.accessToken;
    data['fullname'] = this.fullName;
    data['userName'] = this.userName;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['roles'] = this.roles;
    data['expires_in'] = this.expiresIn;
    data['phoneAddress'] = this.phoneAddress;
    return data;
  }
}
