import 'category.dart';
import 'files.dart';

class NotificationData {
  String id;
  List<Files> files;
  Category category;
  String description;
  String title;
  String dateCreated;
  String datePublic;
  NotificationData({this.id, this.files, this.category, this.description, this.title, this.dateCreated,
    this.datePublic,});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['files'] != null) {
      files = new List<Files>();
      json['files'].forEach((v) {
        files.add(new Files.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    description = json['description'];
    title = json['title'];
    dateCreated = json['dateCreated'];
    datePublic = json['datePublic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.files != null) {
      data['files'] = this.files.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['dateCreated'] = this.dateCreated;
    data['datePublic'] = this.datePublic;
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}