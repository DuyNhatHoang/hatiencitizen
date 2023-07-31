import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_text_input/easy_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/auth/auth_bloc.dart';
import 'package:ha_tien_app/src/blocs/login/login_bloc.dart';
import 'package:ha_tien_app/src/blocs/text_bloc/text_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/view_models/login_request.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/home/home_screen.dart';
import 'package:ha_tien_app/src/ui/medican/test_result/phone_number_check.dart';
import 'package:ha_tien_app/src/ui/register/otp/otp_insert_phone.dart';
import 'package:ha_tien_app/src/ui/register/register_screen.dart';
import 'package:ha_tien_app/src/ui/register/reset_pass.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/get_otp/get_otp.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_connection.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:http/io_client.dart';
import 'package:nice_button/nice_button.dart';
import 'package:signalr_core/signalr_core.dart';
import 'component/input_user_name_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailEdt = TextEditingController();
  TextBloc _textPasswordBloc = TextBloc();
  String _usernameText;
  String _passwordText;
  MyConnection connection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initHub();
    connection = MyConnection(context);
    connection.checkConnection();
    // getMessage();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
          create: (context) => LoginBloc(AuthRepo(), AuthBloc()),
          child: Scaffold(
            body: BlocConsumer<LoginBloc, LoginState>(
                listener: (BuildContext context, state) {
                  if (state is LoginSuccess) {          
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                    // Navigator.of(context).pushNamed(HomeScreen.routeName);
                  } else if (state is LoginFailure) {
                    showSnackBar(context, AppLocalizations.of(context).loginFailed);
                  } else if(state is ForgotPassSuccess){
                    print("thanh cong");
                    showSendEmailDialog(context, state.data);
                  } else if(state is ForgotPassFailure){
                    print("that bai");
                    showSnackBar(context, "${state.data.getErrorMessage()}");
                  } else if(state is ForgotPassInProgress){
                    print("Loading");
                  }
                }, builder: (context, state) {
              if (state is LoginInProgress) {
                return LoadingIndicator();
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.25,
                    ),
                    // Image(
                    //   image: AssetImage("assets/images/quochuy.png"),
                    //   height: size.height * 0.15,
                    //   fit: BoxFit.fitHeight,
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        "UBNDTP HÀ TIÊN",
                        style: TextStyle(
                          fontSize: Constants.homeFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.green
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.1,
                    ),
                    Container(
                      width: size.width * Constants.horizontalArea,
                      child: InputField(
                        controller: _emailEdt,
                        labelText: AppLocalizations.of(context).username,
                        onChanged: _onUsernameTextChanged,
                        successIcon: Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                        errorIcon: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        successColor: kGreenColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      width: size.width * Constants.horizontalArea,
                      child: InputField(
                        stream: _textPasswordBloc.textStream,
                        labelText: AppLocalizations.of(context).password,
                        onChanged: _onPasswordTextChanged,
                        obscureText: true,
                        obscureTextIconOff: Icon(Icons.visibility),
                        obscureTextIconOn: Icon(Icons.visibility_off),
                        successIcon: Icon(
                          Icons.done,
                          color: Colors.green.shade600,
                        ),
                        errorIcon: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        successColor: kGreenColor,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.centerRight,
                      child:  GestureDetector(
                        onTap: () async {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => OptInsertPhone()));
                        },
                        child: Text("${AppLocalizations.of(context).forgetPass}?         ", style:TextStyle()),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: NiceButton(
                        fontSize: Constants.largeFontSize,
                        elevation: 8.0,
                        radius: 12.0,
                        text: AppLocalizations.of(context).login,
                        background: Colors.green.shade600,
                        onPressed: () {
                          onLoginPressed(context);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: NiceButton(
                        fontSize: Constants.largeFontSize,
                        elevation: 8.0,
                        radius: 12.0,
                        text: AppLocalizations.of(context).register,
                        background: kLightGrayColor,
                        onPressed: () {
                          onRegisterPressed(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          )),
    );
  }

  Future<void> onLoginPressed(BuildContext context) async {
    // BlocProvider.of<LoginBloc>(context).add(
    //     LogInStarted(LoginRequest(username: "nguoid1", password: "123123")));
    if (await connection.checkConnection())
      BlocProvider.of<LoginBloc>(context).add(LogInStarted(
          LoginRequest(username: _usernameText, password: _passwordText)));
  }

  @override
  void dispose() {
    super.dispose();
    _textPasswordBloc.dispose();
  }

  Future<void> _initHub() async {
    final connection = HubConnectionBuilder()
        .withUrl(
        'http://api.dev.hr.systemkul.com/hub',
        // 'http://192.168.56.1:9992/hub',
        HttpConnectionOptions(
          transport: HttpTransportType.longPolling,
          client: IOClient(
              HttpClient()..badCertificateCallback = (x, y, z) => true),
          logging: (level, message) => print(message),
          accessTokenFactory: () => _getToken(),
        ))
        .withAutomaticReconnect()
        .build();
    // Sử dụng để nghe sự kiện AttendanceNotification, khi có một người điểm danh bằng vân tay, hoặc khuôn mặt
    connection.on('ReminderNotification', (message) {
      // nội dung trả về
      print(message.toString());
    });
    connection.on('AttendanceNotification', (message) {
      // nội dung trả về
      print(message.toString());
    });
    await connection.start();
    // Test phương thức invoke,
    // arg 1: Sự kiện
    // arg 2: Nội dung
    // Trả về ["Content"]
    // await connection.invoke('NotifyToCaller', args: ['AttendanceNotification', "Content"]);
  }

  Future<String> _getToken() async {
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJoaWdodGxpZ2h0MTMwOUBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJOaOG6rXQgRHV5IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6Im5oYXRkMSIsImV4cCI6MTYwNTc3MjgxMywiaXNzIjoiaHR0cHM6Ly90aXRrdWwudm4iLCJhdWQiOiJodHRwczovL3RpdGt1bC52biJ9.u4_P6hR--kTa_oDX7OwTiVMn5ou4yg9vynWMxuts888";
  }

  _onUsernameTextChanged(String text) {
    _usernameText = text;
  }

  _onPasswordTextChanged(String text) {
    _textPasswordBloc.updateText(text);
    _passwordText = text;
  }

  void onRegisterPressed(BuildContext context) {
    Navigator.of(context).pushNamed(RegisterScreen.routeName);
  }
}
