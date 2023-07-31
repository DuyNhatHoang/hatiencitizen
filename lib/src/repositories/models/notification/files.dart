class Files {
  String id;
  String fileName;

  Files({this.id, this.fileName});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['fileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fileName'] = this.fileName;
    return data;
  }
}