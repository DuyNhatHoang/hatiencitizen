class UpdatedFile {
  int id;
  Null exception;
  int status;
  bool isCanceled;
  bool isCompleted;
  bool isCompletedSuccessfully;
  int creationOptions;
  Null asyncState;
  bool isFaulted;

  UpdatedFile(
      {this.id,
        this.exception,
        this.status,
        this.isCanceled,
        this.isCompleted,
        this.isCompletedSuccessfully,
        this.creationOptions,
        this.asyncState,
        this.isFaulted});

  UpdatedFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exception = json['exception'];
    status = json['status'];
    isCanceled = json['isCanceled'];
    isCompleted = json['isCompleted'];
    isCompletedSuccessfully = json['isCompletedSuccessfully'];
    creationOptions = json['creationOptions'];
    asyncState = json['asyncState'];
    isFaulted = json['isFaulted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exception'] = this.exception;
    data['status'] = this.status;
    data['isCanceled'] = this.isCanceled;
    data['isCompleted'] = this.isCompleted;
    data['isCompletedSuccessfully'] = this.isCompletedSuccessfully;
    data['creationOptions'] = this.creationOptions;
    data['asyncState'] = this.asyncState;
    data['isFaulted'] = this.isFaulted;
    return data;
  }
}