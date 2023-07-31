import 'package:ha_tien_app/src/repositories/models/users/user.dart';
class UserSwagger {
  int pageCount;
  String searchValue;
  int pageIndex;
  int pageSize;
  List<User> data;

  UserSwagger(
      {this.pageCount,
        this.searchValue,
        this.pageIndex,
        this.pageSize,
        this.data});

  UserSwagger.fromJson(Map<String, dynamic> json) {
    pageCount = json['pageCount'];
    searchValue = json['searchValue'];
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    if (json['data'] != null) {
      data = new List<User>();
      json['data'].forEach((v) {
        data.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageCount'] = this.pageCount;
    data['searchValue'] = this.searchValue;
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}