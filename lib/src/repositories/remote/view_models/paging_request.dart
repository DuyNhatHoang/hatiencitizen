class PagingRequest {
  int pageIndex;
  int pageSize;

  PagingRequest({this.pageIndex, this.pageSize});

  PagingRequest.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    return data;
  }
}
