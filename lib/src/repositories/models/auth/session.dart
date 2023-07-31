import 'dart:math';

import 'login.dart';

class Session {
  String id;
  String accessToken;
  String fullName;
  String userName;
  String roles;
  String password;

  String phoneNumber;
  String email;
  String phoneAddress;

  int expiresIn;
  String authorizeDate;
  bool phoneNumberConfirmed;

  Session(
      {this.id,
      this.accessToken,
      this.fullName,
      this.userName,
      this.roles,
      this.expiresIn,
      this.password,
      this.email,
      this.phoneNumberConfirmed,
      this.phoneAddress,
      this.phoneNumber,
      this.authorizeDate});

  Session.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['access_token'];
    fullName = json['fullName'];
    userName = json['userName'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    roles = json['roles'];
    expiresIn = json['expires_in'];
    phoneAddress = json['phoneAddress'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
  }

  Session.fromLogin(Login login) {
    id = login.id;
    accessToken = login.accessToken;
    fullName = login.fullName;
    userName = login.userName;
    roles = login.roles;
    expiresIn = login.expiresIn;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['access_token'] = this.accessToken;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['fullname'] = this.fullName;
    data['userName'] = this.userName;
    data['roles'] = this.roles;
    data['expires_in'] = this.expiresIn;
    data['phoneAddress'] = this.phoneAddress;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    return data;
  }
}
