class User {
  String id;
  String userName;
  String phoneNumber;
  String fullName;
  String title;
  String email;
  String phoneAddress;

  User(
      {this.id,
        this.userName,
        this.phoneNumber,
        this.fullName,
        this.title,
        this.email,
        this.phoneAddress});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    title = json['title'];
    email = json['email'];
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