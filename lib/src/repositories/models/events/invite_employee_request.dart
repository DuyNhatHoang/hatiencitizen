class InviteEmployeeRequest {
  String eventId;
  String information;
  String userId;
  int status;
  int eventLogTypeId;

  InviteEmployeeRequest(
      {this.eventId,
        this.information,
        this.userId,
        this.status,
        this.eventLogTypeId});

  InviteEmployeeRequest.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    information = json['information'];
    userId = json['userId'];
    status = json['status'];
    eventLogTypeId = json['eventLogTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['information'] = this.information;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['eventLogTypeId'] = this.eventLogTypeId;
    return data;
  }
}