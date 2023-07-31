import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ForgetPassState extends Equatable {}

class ForgetPassInitial extends ForgetPassState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class ForgetPassSendOtdLoading extends ForgetPassState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class ForgetPassSendOtpLoaded extends ForgetPassState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class ForgetPassSendOtpError extends ForgetPassState {
  final String msg;
  ForgetPassSendOtpError(this.msg);

  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
class ForgetPassVertifyOtpLoading extends ForgetPassState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class ForgetPassVertifyOtpLoaded extends ForgetPassState {
  final String id;

  ForgetPassVertifyOtpLoaded(this.id);
  @override
  // TODO: implement props
  List<Object> get props => [id];
}
class ForgetPassVertifyOtpError extends ForgetPassState {
  final String msg;

  ForgetPassVertifyOtpError(this.msg);

  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
class ForgetPassResetPassLoading extends ForgetPassState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class ForgetPassResetPassLoaded extends ForgetPassState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class ForgetPassResetPassError extends ForgetPassState {
  final String msg;

  ForgetPassResetPassError(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
