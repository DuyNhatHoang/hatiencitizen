import 'dart:ui';
import 'package:commons/commons.dart' as common;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/auth/auth_bloc.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'foreget_pass-auth.dart';
import 'package:ha_tien_app/src/ui/register/otp/otp_insert_phone.dart';
class PhoneOptInsert extends StatefulWidget {
  final String phoneNumber;
  const PhoneOptInsert({Key key, this.phoneNumber}) : super(key: key);

  @override
  _PhoneOptInsertState createState() => _PhoneOptInsertState();
}

class _PhoneOptInsertState extends State<PhoneOptInsert> {
  TextEditingController phoneCtl;
  BuildContext sendOtpContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneCtl = TextEditingController(text: widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseSubPage(
        onBack: () {
          Navigator.of(context).pop();
        },
        title: AppLocalizations.of(context).validatePhoneNumber,
        child: BlocProvider<AuthBloc>(
            create: (BuildContext context) {
              return AuthBloc(repo: AuthRepo());
            },
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state){
                if(state is OTPLoading){
                  common.push(
                    context,
                    common.loadingScreen(
                      context,
                      loadingType: common.LoadingType.JUMPING,
                    ),
                  );
                } else
                if(state is OTPSuccess){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => PhoneRegisterPage(phoneNumber: phoneCtl.text,))
                  );
                }
                else
                if(state is OTPError){
                  Navigator.of(context).pop();
                  showSnackBar(context, state.error.getErrorMessage().toString());
                }
              },
              builder: (context, state){
                sendOtpContext = context;
                return Container(
                  width: SizeConfig.screenWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.05,),
                        Image.asset(
                          "assets/icons/phonenumber_send.jpg",
                          height: SizeConfig.screenHeight * 0.3,
                        ),
                        Container(
                          width: SizeConfig.screenWidth * 0.6,
                          child: Text(
                            AppLocalizations.of(context).getOTP,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: SizeConfig.screenWidth * 0.045),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.06,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context).inputPhoneNumber,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: Offset(1, 4),
                                    blurRadius: 5),
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: Offset(1, 4),
                                    blurRadius: 5),
                              ]),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: SizeConfig.screenWidth * 0.05),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      'assets/icons/vietnam.png',
                                      height: SizeConfig.screenHeight * 0.03,
                                    ),
                                    Text(
                                      "  (+84)",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: SizeConfig.screenWidth * 0.045),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.6,
                                child: TextFormField(
                                  controller: phoneCtl,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.screenWidth * 0.055),
                                  decoration:
                                  InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.05,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 30),
                          child: ButtonTheme(
                            height: SizeConfig.screenHeight * 0.05,
                            child: FlatButton(
                              onPressed: () {
                                if(phoneCtl.text.length < 10){
                                showSnackBar(context, AppLocalizations.of(context).phoneCheck);
                                } else{
                               BlocProvider.of<AuthBloc>(sendOtpContext).add(SendOTPE(phoneCtl.text));
                                }
                              },
                              child: Center(
                                  child: Text(
                                    AppLocalizations.of(context).validate.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.screenWidth * 0.04,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.green.shade300,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.green.shade200,
                                    offset: Offset(1, -2),
                                    blurRadius: 1),
                                BoxShadow(
                                    color: Colors.green.shade200,
                                    offset: Offset(-1, 2),
                                    blurRadius: 1)
                              ]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )));
  }


}
