class FrequentlyQuestion {
  String id;
  String description;
  String title;
  String notificationId;

  FrequentlyQuestion(
      {this.id, this.description, this.title, this.notificationId});

  FrequentlyQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    title = json['title'];
    notificationId = json['notificationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['title'] = this.title;
    data['notificationId'] = this.notificationId;
    return data;
  }
}