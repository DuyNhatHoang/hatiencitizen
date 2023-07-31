class ExchangeEventToEmployeeIdRequest {
  String id;
  int status;
  int eventLogTypeId;
  String userId;
  String information;

  ExchangeEventToEmployeeIdRequest(
      {this.id,
        this.status,
        this.eventLogTypeId,
        this.userId,
        this.information});

  ExchangeEventToEmployeeIdRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    eventLogTypeId = json['eventLogTypeId'];
    userId = json['userId'];
    information = json['information'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['eventLogTypeId'] = this.eventLogTypeId;
    data['userId'] = this.userId;
    data['information'] = this.information;
    return data;
  }
}
