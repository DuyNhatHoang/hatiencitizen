import 'package:commons/commons.dart';
import 'package:dio/dio.dart';
import 'package:easy_text_input/easy_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ha_tien_app/src/blocs/auth/auth_bloc.dart';
import 'package:ha_tien_app/src/blocs/employees/employee_bloc.dart';
import 'package:ha_tien_app/src/blocs/login/login_bloc.dart';
import 'package:ha_tien_app/src/blocs/setting/bloc.dart';
import 'package:ha_tien_app/src/blocs/text_bloc/text_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/Setting.dart';
import 'package:ha_tien_app/src/repositories/models/auth/login.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/employees/reset_password_request.dart';
import 'package:ha_tien_app/src/repositories/models/users/update_user_request.dart';
import 'package:ha_tien_app/src/repositories/remote/api_client.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/employees/employees_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/setting/settingrepo.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/home/components/tk_view.dart';
import 'package:ha_tien_app/src/ui/home/tkview/logout_widget.dart';
import 'package:ha_tien_app/src/ui/home/tkview/tk_bottom_sheet.dart';
import 'package:ha_tien_app/src/ui/home/tkview/user_avatar.dart';
import 'package:ha_tien_app/src/ui/login/login_screen.dart';
import 'package:ha_tien_app/src/ui/medican/test_result/phone_number_check.dart';
import 'package:ha_tien_app/src/ui/medican/test_result/test_result_page.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nice_button/nice_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TKMainView extends StatefulWidget {
  final SessionManager session;

  const TKMainView({Key key, this.session}) : super(key: key);

  @override
  _TKMainViewState createState() => _TKMainViewState();
}

class _TKMainViewState extends State<TKMainView> {
  TextBloc _textUsernameBloc = TextBloc();
  TextBloc _fullNameBloc = TextBloc();
  TextBloc _phoneNumberBloc = TextBloc();
  TextBloc _emailBloc = TextBloc();
  String _username;
  String _fullName;
  String _phoneNumber;
  String _email;
  BuildContext _settingContext;
  Session _session;
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _session = widget.session.getSession();
    _usernameController.text = _session.userName;
    _fullNameController.text = _session.fullName;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textUsernameBloc.dispose();
    _fullNameBloc.dispose();
    _phoneNumberBloc.dispose();
    _emailBloc.dispose();

    _usernameController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) {
        return LoginBloc(AuthRepo.withToken(_session.accessToken), null)
          ..add(GetUserInfoEvent());
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
          create: (context) =>
        EmployeesBloc(EmployeesRepo.withToken(_session.accessToken))),
          BlocProvider(
              create: (context) => SettingBloc(
                  SettingRepo.withToken(_session.accessToken))),
        ],
        child: Stack(
          children: [
            BlocConsumer<SettingBloc, SettingState>(builder: (c,s) {
              _settingContext = c;
              return Container();
            }, listener: (context, state){
              _settingContext = context;
              if(state is Success){
                launch("tel://${state.value}");
              }
            }),
            BlocConsumer<EmployeesBloc, EmployeesState>(
                listener: (context, state) {
                  if (state is ResetPasswordFailure) {
                    showSnackBar(context, state.error.getErrorMessage());
                  } else if (state is ResetPasswordSuccess) {
                    showSnackBar(context, AppLocalizations.of(context).changePassSuccess);
                  }
                }, builder: (context, state) {
              if (state is ResetPasswordInProgress) {
                return LoadingIndicator();
              }
              return BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is GetUserInfoSuccess) {
                      fillText(state.data);
                    } else if (state is UpdateUserSuccess) {
                      updateSession();
                      showSnackBar(context, AppLocalizations.of(context).updateSuccess);
                    } else if(state is UpdateUserFailure){
                      showSnackBar(context, "${state.error}");
                    }
                  }, builder: (context, state) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(height: size.height * 0.05,),
                              UserAvatarVer2(name: _session.fullName, showDetail: true, phone: _phoneNumberController.text,),
                              horiFunc("assets/icons/update.png", AppLocalizations.of(context).updateInfo, ontap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => TKView(session: widget.session,))
                                );
                              }),
                              horiFunc("assets/icons/gallery.png", AppLocalizations.of(context).gallery, ontap: ()async{
                                // !await launch( "https://uploadfile1.bakco.com.vn/?user=${_session.userName}&page=upfile");
                                if((await Permission.camera.isGranted)){
                                } else{
                                  await Permission.camera.request();
                                }
                                List<Setting> settings = await ApiClient(Dio()).getSettings("upfile-url");
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => WebviewScaffold(
                                      // mediaPlaybackRequiresUserGesture: true,
                                      withJavascript: true,
                                      enableAppScheme: true,
                                      url: "${settings.first.value}/?user=${_session.userName}&page=upfile",
                                      appBar: new AppBar(
                                        title: new Text(AppLocalizations.of(context).gallery),
                                      ),
                                    ),)
                                );
                              }),
                              horiFunc("assets/icons/phone_icon.png", AppLocalizations.of(context).urgentCall, ontap: (){   BlocProvider.of<SettingBloc>(_settingContext).add(GetSettingE("hotline"));}),
                              horiFunc("assets/icons/lock.png", AppLocalizations.of(context).changePass, ontap: (){ onResetPasswordPressed(context);}),
                              horiFunc("assets/icons/result.png", AppLocalizations.of(context).testResult,
                                  ontap: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => PhoneNumberCheck(session: widget.session,))
                                    );
                                  }),
                              SizedBox(height: SizeConfig.screenHeight * 0.1,),
                              LogOutWidget()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            })
          ],
        )
      )
    );
  }

  _onUsernameTextChanged(String text) {
    _username = text;
    _textUsernameBloc.updateText(text);
  }

  _onFullNameTextChanged(String text) {
    _fullName = text;
    _fullNameBloc.updateText(text);
  }

  _onPhoneNumberTextChanged(String text) {
    _usernameController.text = _session.userName;
    _phoneNumber = text;
    _phoneNumberBloc.updateText(text);
  }

  _onEmailTextChanged(String text) {
    _emailBloc.updateText(text);
    _email = text;
  }

  Future<void> onLogOutPressed(BuildContext context) async {
    SessionManager sessionManager =
    SessionManager(await SharedPreferences.getInstance());
    sessionManager.removeSession();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  void fillText(Session data) {
    _phoneNumberController.text = data.phoneNumber;
    _emailController.text = data.email;
    _usernameController.text = data.userName;
    _textUsernameBloc.updateText(data.userName);
  }

  void onUpdateUserPressed(BuildContext context) {
    if(validateEmail(_emailController.text)){
      BlocProvider.of<LoginBloc>(context).add(UpdateUserEvent(UpdateUserRequest(
        phoneNumber: _phoneNumberController.text,
        fullName: _fullNameController.text,
        email: _emailController.text,
      )));
    }  else{
      showSnackBar(context, "Email không hợp lệ");
    }

  }

  void updateSession() {
    _session.fullName = _fullNameController.text;
    _session.phoneNumber = _phoneNumberController.text;
    _session.email = _emailController.text;

    widget.session.createSession(_session);
  }

  void onResetPasswordPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => TKBottomSheet(widget.session)));
    // showMaterialModalBottomSheet(
    //   context: context,
    //   builder: (context) => SingleChildScrollView(
    //     controller: ModalScrollController.of(context),
    //     child: Container(
    //       child: TKBottomSheet(widget.session),
    //     ),
    //   ),
    // );
  }

  Widget horiFunc(String icon, String title, {Function ontap}){
    return InkWell(
      onTap: ontap,
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 6 ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: SizeConfig.screenWidth * 0.01, ),
                Image.asset(icon, height: SizeConfig.screenWidth * 0.11, width: SizeConfig.screenWidth * 0.09 ),
                SizedBox(width: SizeConfig.screenWidth * 0.04, ),
                Text(title, style: TextStyle(color: Colors.black, fontSize: SizeConfig.screenWidth * 0.045, fontWeight: FontWeight.w500),),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded,size: SizeConfig.screenWidth * 0.04, color: Colors.black.withOpacity(0.7),)
          ],
        ),
      ),
    );
  }
}
