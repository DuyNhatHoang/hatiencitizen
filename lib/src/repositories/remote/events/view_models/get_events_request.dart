class GetEventsRequest {
  String searchValue;
  int status;

  GetEventsRequest({this.searchValue, this.status});

  GetEventsRequest.fromJson(Map<String, dynamic> json) {
    searchValue = json['searchValue'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchValue'] = this.searchValue;
    data['status'] = this.status;
    return data;
  }
}