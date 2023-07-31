import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';

class EmployeeSwagger {
  int totalCount;
  int pageIndex;
  int pageSize;
  List<Employee> data;

  EmployeeSwagger({this.totalCount, this.pageIndex, this.pageSize, this.data});

  EmployeeSwagger.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    if (json['data'] != null) {
      data = new List<Employee>();
      json['data'].forEach((v) {
        data.add(new Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Positions {
  String name;
  String userId;
  String positionId;
  User user;
  Position position;
  String id;

  Positions(
      {this.name,
      this.userId,
      this.positionId,
      this.user,
      this.position,
      this.id});

  Positions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['userId'];
    positionId = json['positionId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['positionId'] = this.positionId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.position != null) {
      data['position'] = this.position.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class User {
  String fullName;
  Null gender;
  Null dateOfBirth;
  Null cmnd;
  Null identityCard;
  Null passport;
  String phoneAddress;
  String title;
  Null jobTitle;
  String id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  bool emailConfirmed;
  String passwordHash;
  String securityStamp;
  String concurrencyStamp;
  String phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  Null lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;

  User(
      {this.fullName,
      this.gender,
      this.dateOfBirth,
      this.cmnd,
      this.identityCard,
      this.passport,
      this.phoneAddress,
      this.title,
      this.jobTitle,
      this.id,
      this.userName,
      this.normalizedUserName,
      this.email,
      this.normalizedEmail,
      this.emailConfirmed,
      this.passwordHash,
      this.securityStamp,
      this.concurrencyStamp,
      this.phoneNumber,
      this.phoneNumberConfirmed,
      this.twoFactorEnabled,
      this.lockoutEnd,
      this.lockoutEnabled,
      this.accessFailedCount});

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    cmnd = json['cmnd'];
    identityCard = json['identityCard'];
    passport = json['passport'];
    phoneAddress = json['phoneAddress'];
    title = json['title'];
    jobTitle = json['jobTitle'];
    id = json['id'];
    userName = json['userName'];
    normalizedUserName = json['normalizedUserName'];
    email = json['email'];
    normalizedEmail = json['normalizedEmail'];
    emailConfirmed = json['emailConfirmed'];
    passwordHash = json['passwordHash'];
    securityStamp = json['securityStamp'];
    concurrencyStamp = json['concurrencyStamp'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnd = json['lockoutEnd'];
    lockoutEnabled = json['lockoutEnabled'];
    accessFailedCount = json['accessFailedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['cmnd'] = this.cmnd;
    data['identityCard'] = this.identityCard;
    data['passport'] = this.passport;
    data['phoneAddress'] = this.phoneAddress;
    data['title'] = this.title;
    data['jobTitle'] = this.jobTitle;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['normalizedUserName'] = this.normalizedUserName;
    data['email'] = this.email;
    data['normalizedEmail'] = this.normalizedEmail;
    data['emailConfirmed'] = this.emailConfirmed;
    data['passwordHash'] = this.passwordHash;
    data['securityStamp'] = this.securityStamp;
    data['concurrencyStamp'] = this.concurrencyStamp;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['lockoutEnd'] = this.lockoutEnd;
    data['lockoutEnabled'] = this.lockoutEnabled;
    data['accessFailedCount'] = this.accessFailedCount;
    return data;
  }
}

class Position {
  String code;
  String name;
  String decription;
  String departmentId;
  Department department;
  String id;

  Position(
      {this.code,
      this.name,
      this.decription,
      this.departmentId,
      this.department,
      this.id});

  Position.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    decription = json['decription'];
    departmentId = json['departmentId'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['decription'] = this.decription;
    data['departmentId'] = this.departmentId;
    if (this.department != null) {
      data['department'] = this.department.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Department {
  String code;
  String name;
  String decription;
  String id;

  Department({this.code, this.name, this.decription, this.id});

  Department.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    decription = json['decription'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['decription'] = this.decription;
    data['id'] = this.id;
    return data;
  }
}

class Groups {
  String decription;
  String userId;
  String groupId;
  User user;
  Group group;
  String id;

  Groups(
      {this.decription,
      this.userId,
      this.groupId,
      this.user,
      this.group,
      this.id});

  Groups.fromJson(Map<String, dynamic> json) {
    decription = json['decription'];
    userId = json['userId'];
    groupId = json['groupId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['decription'] = this.decription;
    data['userId'] = this.userId;
    data['groupId'] = this.groupId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.group != null) {
      data['group'] = this.group.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Group {
  String name;
  String decription;
  String id;

  Group({this.name, this.decription, this.id});

  Group.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    decription = json['decription'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['decription'] = this.decription;
    data['id'] = this.id;
    return data;
  }
}
