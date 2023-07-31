class BaseError {
  String type;
  String title;
  int status;
  String traceId;
  String errors;

  BaseError({this.type, this.title, this.status, this.traceId, this.errors});

  BaseError.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    status = json['status'];
    traceId = json['traceId'];
    errors =
    json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['status'] = this.status;
    data['traceId'] = this.traceId;
    if (this.errors != null) {
    }
    return data;
  }
}
