class GetNotificationUsesrRequest {
  bool isDeleted;
  bool starred;
  int pageIndex;
  int pageSize;

  GetNotificationUsesrRequest(
      {this.isDeleted, this.starred, this.pageIndex, this.pageSize});

  GetNotificationUsesrRequest.fromJson(Map<String, dynamic> json) {
    isDeleted = json['isDeleted'];
    starred = json['starred'];
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDeleted'] = this.isDeleted;
    data['starred'] = this.starred;
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    return data;
  }
}
