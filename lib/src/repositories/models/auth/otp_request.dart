class OtpRequest {
  String otpCode;
  String phoneNumber;

  OtpRequest(
      {
        this.phoneNumber,
        this.otpCode});

  OtpRequest.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    otpCode = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['otp'] = this.otpCode;
    return data;
  }
}