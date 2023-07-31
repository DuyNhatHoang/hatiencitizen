class EventFiles {
  String id;
  String name;
  String fileType;
  String file;
  String eventLogId;
  String linkFileAttached;

  EventFiles({this.id, this.name, this.fileType, this.file, this.eventLogId, this.linkFileAttached});

  EventFiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fileType = json['fileType'];
    file = json['file'];
    eventLogId = json['eventLogId'];
    linkFileAttached = json['linkFileAttached'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fileType'] = this.fileType;
    data['file'] = this.file;
    data['eventLogId'] = this.eventLogId;
    data['linkFileAttached'] = this.linkFileAttached;
    return data;
  }
}