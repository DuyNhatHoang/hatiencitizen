import 'package:commons/commons.dart';
import 'package:easy_text_input/easy_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ha_tien_app/src/blocs/auth/auth_bloc.dart';
import 'package:ha_tien_app/src/blocs/employees/employee_bloc.dart';
import 'package:ha_tien_app/src/blocs/login/login_bloc.dart';
import 'package:ha_tien_app/src/blocs/text_bloc/text_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/auth/login.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/employees/reset_password_request.dart';
import 'package:ha_tien_app/src/repositories/models/users/update_user_request.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/employees/employees_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/home/tkview/tk_bottom_sheet.dart';
import 'package:ha_tien_app/src/ui/login/login_screen.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nice_button/nice_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TKView extends StatefulWidget {
  final SessionManager session;

  const TKView({Key key, this.session}) : super(key: key);

  @override
  _TKViewState createState() => _TKViewState();
}

class _TKViewState extends State<TKView> {
  TextBloc _textUsernameBloc = TextBloc();
  TextBloc _fullNameBloc = TextBloc();
  TextBloc _phoneNumberBloc = TextBloc();
  TextBloc _emailBloc = TextBloc();
  String _username;
  String _fullName;
  String _phoneNumber;
  String _email;
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
    // _usernameController.text = _session.userName;
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
    return BaseSubPage(
      title: AppLocalizations.of(context).updateInfo,
      onBack: (){
        Navigator.of(context).pop();
      },
      child: BlocProvider(
        create: (context) {
          return LoginBloc(AuthRepo.withToken(_session.accessToken), null)
            ..add(GetUserInfoEvent());
        },
        child: BlocProvider(
          create: (context) =>
              EmployeesBloc(EmployeesRepo.withToken(_session.accessToken)),
          child: BlocConsumer<EmployeesBloc, EmployeesState>(
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
                            SizedBox(height: size.height * 0.05,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(AppLocalizations.of(context).username, style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: size.height * 0.01,),
                            Container(
                              width: size.width * 0.9,
                              child: TextFormField(
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    // labelText: "Tên đăng nhâp",
                                    border:  OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.black)),
                                  )),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.03,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(AppLocalizations.of(context).fullname, style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: size.height * 0.01,),
                            Container(
                              width: size.width * 0.9,
                              child: InputField(
                                controller: _fullNameController,
                                stream: _fullNameBloc.textStream,
                                onChanged: _onFullNameTextChanged,
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
                            // Container(
                            //   width: size.width * Constants.horizontalArea,
                            //   child: TextFormField(
                            //       readOnly: true,
                            //       keyboardType: TextInputType.text,
                            //       controller: _phoneNumberController,
                            //       decoration: InputDecoration(
                            //         labelText: "Số điện thoại",
                            //         border:  OutlineInputBorder(
                            //             borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            //             borderSide: BorderSide(color: Colors.black)),
                            //       )),
                            // ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.03,         
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Email", style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: size.height * 0.01,),
                            Container(
                              width: size.width * 0.9,
                              child: InputField(
                                controller: _emailController,
                                stream: _emailBloc.textStream,
                                onChanged: _onEmailTextChanged,
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
                              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.07),
                              child: NiceButton(
                                fontSize: SizeConfig.screenWidth * 0.05,
                                width: SizeConfig.screenWidth * 0.9,
                                elevation: 3.0,
                                radius: 8.0,
                                text: AppLocalizations.of(context).updateInfo,
                                background: Colors.green,
                                onPressed: () {
                                  onUpdateUserPressed(context);
                                },
                              ),
                            ),
                            KeyboardVisibilityBuilder(
                                builder: (context, isKeyboardVisible) {
                                  double sheetHeight = MediaQuery.of(context).size.height;
                                  double keyboardHeight =
                                      MediaQuery.of(context).viewInsets.bottom;
                                  isKeyboardVisible
                                      ? scrollController.animateTo(sheetHeight * 0.1,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.ease)
                                      : null;
                                  return isKeyboardVisible
                                      ? SizedBox(height: sheetHeight - keyboardHeight)
                                      : SizedBox(
                                    height: 0,
                                  );
                                }),
                            // Container(
                            //   margin: EdgeInsets.only(top: 16),
                            //   child: NiceButton(
                            //     fontSize: Constants.largeFontSize,
                            //     elevation: 3.0,
                            //     radius: 12.0,
                            //     text: "Đổi mật khẩu",
                            //     background: Colors.grey,
                            //     onPressed: () {
                            //       onResetPasswordPressed(context);
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          }),
        ),
      ),
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
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          child: TKBottomSheet(widget.session),
        ),
      ),
    );
  }
}
