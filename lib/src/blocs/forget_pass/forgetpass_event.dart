import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/auth/reset_pass_request.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ForgetPassEvent extends Equatable{}

class SendOTPE extends  ForgetPassEvent{
  final String phoneNumber;

  SendOTPE(this.phoneNumber);

  @override
  // TODO: implement props
  List<Object> get props => [phoneNumber];
}

class VertifyOtpE extends  ForgetPassEvent{
  final String phoneNumber;
  final String otp;

  VertifyOtpE(this.phoneNumber, this.otp);

  @override
  // TODO: implement props
  List<Object> get props => [this.phoneNumber, this.otp];
}

class ResetPassE extends  ForgetPassEvent{
  final ResetPassRequest request;

  ResetPassE(this.request);

  @override
  // TODO: implement props
  List<Object> get props => [request];
}
