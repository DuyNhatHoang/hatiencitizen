import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/auth/auth_bloc.dart';
import 'package:ha_tien_app/src/blocs/login/login_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/%20test_results/test_result.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:commons/commons.dart' as common;
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/medican/test_result/test_result_page.dart';
import 'package:ha_tien_app/src/ui/register/otp/account_authenticate_page.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';

import '../yte_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PhoneNumberCheck extends StatefulWidget {
  final SessionManager session;

  const PhoneNumberCheck({Key key, this.session}) : super(key: key);

  @override
  _PhoneNumberCheckState createState() => _PhoneNumberCheckState();
}

class _PhoneNumberCheckState extends State<PhoneNumberCheck> {
  String phoneNumber = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onSmsReceived(String message) {
    print("onSmsReceived ${message}");
  }

  void onTimeout() {
    print("onTimeout");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (_) => LoginBloc(AuthRepo.withToken(widget.session.getSession().accessToken), null)
            ..add(GetUserInfoEvent()),
          child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                print("adssadasd ${state}");
                if (state is GetUserInfoSuccess) {
                  // showSnackBar(context, "lấp thông tin thành công");
                  phoneNumber = state.data.phoneNumber;
                  if(state.data.phoneNumberConfirmed == true){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MedicanPage(session: widget.session, phoneNumber: state.data.phoneNumber,)));
                  }
                } else if(state is GetUserInfoFailure){
                  showSnackBar(context, "${state.error}");
                }
              }, builder: (context, state) {
            if (state is GetUserInfoSuccess) {
              Session userInfo = state.data;
              print("userInfo ${userInfo.toJson()}");
              return BlocProvider(
                create: (_) => AuthBloc(repo: AuthRepo()),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is OTPError) {
                      if(state.error.getErrorMessage().toString().contains("Tài khoản đã xác thực") ){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MedicanPage(session: widget.session, phoneNumber: phoneNumber,)));
                      } else{
                        showSnackBar(context, "${state.error.getErrorMessage()}");
                        Navigator.of(context).pop();
                      }

                    } else if (state is OTPSuccess) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AccountAuthenticatePage(phoneNumber: phoneNumber, session: widget.session,)));
                    }
                  },
                  builder: (context, state) {
                    if(state is AuthInitial){
                      BlocProvider.of<AuthBloc>(context).add(SendOTPE(phoneNumber));
                      // BlocProvider.of<AuthBloc>(context).add(SendOTPE( phoneNumber));
                    }
                    return Center(
                      child: LoadingIndicator(),
                    );
                  },
                ),
              );
            } else if (state is UpdateUserSuccess) {
              showSnackBar(context, AppLocalizations.of(context).updateSuccess);
            } else if(state is GetUserInfoFailure){
              showSnackBar(context, "${state.error}");
            }
            return Container();
          }
          ),
        )
    );
  }
}
