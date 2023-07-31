class Login {
  String id;
  String accessToken;
  String fullName;
  String userName;
  String roles;
  int expiresIn;

  Login(
      {this.id,
      this.accessToken,
      this.fullName,
      this.userName,
      this.roles,
      this.expiresIn});

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['access_token'];
    fullName = json['fullname'];
    userName = json['userName'];
    roles = json['roles'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['access_token'] = this.accessToken;
    data['fullname'] = this.fullName;
    data['userName'] = this.userName;
    data['roles'] = this.roles;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
