import 'dart:async';
import 'dart:io';
import 'package:commons/commons.dart' as common;
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/auth/auth_bloc.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/ui/login/login_screen.dart';
import 'package:ha_tien_app/src/ui/medican/yte_page.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ForgetPassPinCode extends StatefulWidget {
  final String phoneNumber;

  ForgetPassPinCode(this.phoneNumber);

  @override
  _ForgetPassPinCodeState createState() =>
      _ForgetPassPinCodeState();
}

class _ForgetPassPinCodeState extends State<ForgetPassPinCode>{
  Timer _timer;
  bool isResendCD = false;
  int _resendCD = 300;
  int _activecodeCD = 300;
  BuildContext authContext;
  BuildContext registerContext;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String otpCode;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    startActiveCodeCd();
    super.initState();
    if(Platform.isAndroid) {
      getOtp();
    }

  }

  void onSmsReceived(String message) {
    print("onSmsReceived");
  }

  void onTimeout() {
    print("onTimeout");
  }
  @override
  void dispose() {
    errorController.close();
    _timer.cancel();
    super.dispose();
  }

  Future<void> getOtp() async {
    var platform = MethodChannel('bakco.hatien.otp');
    try {
      final String result = await platform.invokeMethod('receiveMessage');
      print("asdasd ${result}");
      try{
        List<String> s = result.split(" ");
        print("asdasd ${s.first}");
          textEditingController.text = s.first;
      } catch(e){

      }
      print('receiveMessage $result');

    } on PlatformException catch (e) {
      print("Failed to receiveMessage: '${e.message}'.");
    }
  }


  void startActiveCodeCd() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_activecodeCD == 0) {
          setState(() {
            timer.cancel();
            showSnackBar(context, "Hết thời gian hiệu lực của mã hiện tại");
          });
        } else {
          setState(() {
            _activecodeCD--;
          });
        }
      },
    );
  }
  void startResendCD() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_resendCD == 0) {
          setState(() {
            timer.cancel();
            isResendCD = false;
          });
        } else {
          setState(() {
            _resendCD--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: FlareActor(
                    "assets/otp.flr",
                    animation: "otp",
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalizations.of(context).validatePhoneNumber,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                        text: AppLocalizations.of(context).sendCodeToNumber,
                        children: [
                          TextSpan(
                              text: widget.phoneNumber,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ],
                        style: TextStyle(color: Colors.black54, fontSize: 15)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: SizeConfig.screenWidth * 0.02),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        obscuringCharacter: '*',
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v.length < 3) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          inactiveFillColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: SizeConfig.screenWidth * 0.15,
                          fieldWidth: SizeConfig.screenWidth * 0.13,
                          disabledColor: Colors.green,
                          inactiveColor: Colors.blue,
                          activeFillColor:
                          hasError ? Colors.white : Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        textStyle: TextStyle(fontSize: 20, height: 1.6),
                        // backgroundColor: Colors.blue.shade50,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        // boxShadows: [
                        //   BoxShadow(
                        //     offset: Offset(0, 1),
                        //     color: Colors.black12,
                        //     blurRadius: 10,
                        //   )
                        // ],
                        onCompleted: (v) {
                          print("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          return true;
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "* ${AppLocalizations.of(context).codeConfirm}" : "",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${AppLocalizations.of(context).notRecieveOTP} ",
                      style: TextStyle(color: Colors.black54, fontSize: 15),),
                    BlocProvider(create: (_) => AuthBloc(repo: AuthRepo()),
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state){
                          print("AuthBloc ${state}");
                          if(state is OTPLoading){
                          } else
                          if(state is OTPError){
                            textEditingController.clear();
                            showSnackBar(context, "Gửi lại mã thát bại");
                          } else
                          if(state is OTPSuccess){
                            textEditingController.clear();
                            showSnackBar(context, "Gửi lại mã thành công");
                            setState(() {
                              _activecodeCD = 300;
                              _resendCD = 300;
                              isResendCD = true;
                            });
                            startResendCD();
                          } else
                          if(state is VertifyOTPLoading){
                            common.push(
                              context,
                              common.loadingScreen(
                                context,
                                loadingType: common.LoadingType.JUMPING,
                              ),
                            );
                          } else if(state is VertifyOTPError){
                            Navigator.of(context).pop();
                            showSnackBar(context, state.error.getErrorMessage().toString());
                          } else if(state is VertifyOTPSuccess){
                            showSnackBar(context, AppLocalizations.of(context).validateSuccess);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (context, state){
                          authContext = context;
                          if(state is OTPLoading){
                            return CircularProgressIndicator();
                          }
                          return InkWell(
                            child: Text(
                                " ${AppLocalizations.of(context).resend}",
                                style: TextStyle(
                                    color: _activecodeCD > 0 ? Colors.grey:Color(0xFF91D3B3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            onTap:(){
                              if( _activecodeCD > 0){

                              } else{
                                BlocProvider.of<AuthBloc>(context).add(SendOTPE(widget.phoneNumber));
                              }

                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    height: 50,
                    child: FlatButton(
                      onPressed: () {
                        formKey.currentState.validate();
                        // conditions for validating
                        if (currentText.length != 6) {
                          errorController.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() {
                            hasError = true;
                          });
                        } else {
                          setState(() {
                            hasError = false;
                          });
                          BlocProvider.of<AuthBloc>(authContext).add(VertifyOTP(widget.phoneNumber, textEditingController.text));
                        }
                      },
                      child: Center(
                          child: Text(
                            AppLocalizations.of(context).validate.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
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
                            blurRadius: 5),
                        BoxShadow(
                            color: Colors.green.shade200,
                            offset: Offset(-1, 2),
                            blurRadius: 5)
                      ]),
                ),
                SizedBox(
                  height: 16,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: AppLocalizations.of(context).otpExpired,
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                      children: [
                        TextSpan(
                            text: "${_activecodeCD} s",
                            style: TextStyle(
                                color: Color(0xFF91D3B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 16))
                      ]),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     FlatButton(
                //       child: Text("Clear"),
                //       onPressed: () {
                //         textEditingController.clear();
                //       },
                //     ),
                //     FlatButton(
                //       child: Text("Set Text"),
                //       onPressed: () {
                //         textEditingController.text = "123456";
                //       },
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

}