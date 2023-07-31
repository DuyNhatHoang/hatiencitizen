class Setting {
  String key;
  String value;
  String title;
  String type;
  String groupId;

  Setting(
      {this.key,
        this.value,
        this.title,
        this.groupId,
        this.type});

  Setting.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    title = json['title'];
    groupId = json['groupId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['title'] = this.title;
    data['value'] = this.value;
    data['groupId'] = this.groupId;
    data['type'] = this.type;
    return data;
  }
}