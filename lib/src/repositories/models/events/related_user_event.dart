class RelatedUserResponse {
  Owner owner;
  List<Employee> employees;

  RelatedUserResponse({this.owner, this.employees});

  RelatedUserResponse.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    if (json['employees'] != null) {
      employees = new List<Employee>();
      json['employees'].forEach((v) {
        employees.add(new Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.employees != null) {
      data['employees'] = this.employees.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Owner {
  Role role;
  String id;
  String userName;
  String phoneNumber;
  String fullName;
  String title;
  String email;
  String phoneAddress;

  Owner(
      {this.id,
      this.userName,
      this.phoneNumber,
      this.fullName,
      this.title,
      this.email,
      this.phoneAddress});

  Owner.fromJson(Map<String, dynamic> json) {
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    if (json['id'] != null && json['id'] != "") id = json['id'];
    if (json['userName'] != null && json['userName'] != "")
      userName = json['userName'];
    if (json['phoneNumber'] != null && json['phoneNumber'] != "")
      phoneNumber = json['phoneNumber'];
    if (json['fullName'] != null && json['fullName'] != "")
      fullName = json['fullName'];
    if (json['title'] != null && json['title'] != "") title = json['title'];
    if (json['email'] != null && json['email'] != "") email = json['email'];
    if (json['phoneAddress'] != null && json['phoneAddress'] != "")
      phoneAddress = json['phoneAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.role != null) {
      data['role'] = this.role.toJson();
    }
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['phoneNumber'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    data['title'] = this.title;
    data['email'] = this.email;
    data['phoneAddress'] = this.phoneAddress;
    return data;
  }
}

class Role {
  String id;
  String description;

  Role({this.id, this.description});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }
}

class Employee {
  String id;
  String userName;
  String phoneNumber;
  String fullName;
  String title;
  String email;
  String phoneAddress;

  Employee(
      {this.id,
      this.userName,
      this.phoneNumber,
      this.fullName,
      this.title,
      this.email,
      this.phoneAddress});

  Employee.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null && json['id'] != "") id = json['id'];
    if (json['userName'] != null && json['userName'] != "")
      userName = json['userName'];
    if (json['phoneNumber'] != null && json['phoneNumber'] != "")
      phoneNumber = json['phoneNumber'];
    if (json['fullName'] != null && json['fullName'] != "")
      fullName = json['fullName'];
    if (json['title'] != null && json['title'] != "") title = json['title'];
    if (json['email'] != null && json['email'] != "") email = json['email'];
    if (json['phoneAddress'] != null && json['phoneAddress'] != "")
      phoneAddress = json['phoneAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['phoneNumber'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    data['title'] = this.title;
    data['email'] = this.email;
    data['phoneAddress'] = this.phoneAddress;
    return data;
  }
}
