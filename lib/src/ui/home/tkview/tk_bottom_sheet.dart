import 'package:easy_text_input/easy_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ha_tien_app/src/blocs/employees/employee_bloc.dart';
import 'package:ha_tien_app/src/blocs/forget_pass/bloc.dart';
import 'package:ha_tien_app/src/blocs/text_bloc/text_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/employees/reset_password_request.dart';
import 'package:ha_tien_app/src/repositories/remote/employees/employees_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/base/dialog/loading_dialog.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:nice_button/NiceButton.dart';

class TKBottomSheet extends StatefulWidget {
  final SessionManager session;

  const TKBottomSheet(this.session);

  @override
  _TKBottomSheetState createState() => _TKBottomSheetState();
}

class _TKBottomSheetState extends State<TKBottomSheet> {
  TextBloc _textOldPasswordBloc = TextBloc();
  String _oldPasswordText = "";

  TextBloc _textPasswordBloc = TextBloc();
  String _passwordText = "";

  TextBloc _textConfirmPasswordBloc = TextBloc();
  String _passwordConfirmText = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.session.getSession().password);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseSubPage(
      title: "Đổi mật khẩu",
      onBack: (){
        Navigator.of(context).pop();
      },
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return BlocProvider(
          create: (context) => EmployeesBloc(
              EmployeesRepo.withToken(widget.session.getSession().accessToken)),
          child: Container(
            width: SizeConfig.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 32),
                  width: size.width * Constants.horizontalArea,
                  child: InputField(
                    stream: _textOldPasswordBloc.textStream,
                    labelText: 'Mật khẩu cũ',
                    onChanged: _onOldPasswordTextChanged,
                    obscureText: true,
                    obscureTextIconOff: Icon(Icons.visibility),
                    obscureTextIconOn: Icon(Icons.visibility_off),
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
                    labelText: 'Mật khẩu',
                    onChanged: _onPasswordTextChanged,
                    obscureText: true,
                    obscureTextIconOff: Icon(Icons.visibility),
                    obscureTextIconOn: Icon(Icons.visibility_off),
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
                    stream: _textConfirmPasswordBloc.textStream,
                    labelText: 'Nhập lại mật khẩu',
                    onChanged: _onPasswordConfirmTextChanged,
                    obscureText: true,
                    obscureTextIconOff: Icon(Icons.visibility),
                    obscureTextIconOn: Icon(Icons.visibility_off),
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
                SizedBox(height: SizeConfig.screenHeight * 0.1,),
                BlocConsumer<EmployeesBloc, EmployeesState>(
                  listener: (context, state) {
                    if (state is ResetPasswordFailure) {
                      Navigator.of(context).pop();
                      showSnackBar(context, state.error.getErrorMessage());
                    } else if (state is ResetPasswordSuccess) {
                      updateSession();
                      Navigator.of(context).pop();
                      // Navigator.of(context).pop();
                      showSnackBar(context, "Đổi mật khẩu thành công");
                    } else if(state is ForgetPassResetPassLoading){
                      showLoadingDialog(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is ResetPasswordInProgress) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LoadingIndicator(),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.only(top: 16),
                      child: NiceButton(
                        width: SizeConfig.screenWidth * 0.9,
                        fontSize: Constants.largeFontSize,
                        elevation: 3.0,
                        radius: 12.0,
                        text: "Xác nhận",
                        background: Colors.green.shade600,
                        onPressed: () {
                          onConfirmPressed(context);
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: isKeyboardVisible ? getKeyboardHeight(size.height) : 200,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _onOldPasswordTextChanged(String text) {
    _textOldPasswordBloc.updateText(text);
    _oldPasswordText = text;
  }

  _onPasswordTextChanged(String text) {
    _textPasswordBloc.updateText(text);
    _passwordText = text;
  }

  _onPasswordConfirmTextChanged(String text) {
    _textConfirmPasswordBloc.updateText(text);
    _passwordConfirmText = text;
  }

  void onConfirmPressed(context) {
    if (!check(context)) return;
    BlocProvider.of<EmployeesBloc>(context)
        .add(ResetPasswordEvent(ResetPasswordRequest(
      oldpass: _oldPasswordText,
      newPassword: _passwordText,
    )));
  }

  bool check(context) {
    if (_oldPasswordText != widget.session.getSession().password) {
      showSnackBar(context, "Mật khẩu cũ không đúng");
      return false;
    }
    if (_passwordText != _passwordConfirmText) {
      showSnackBar(context, "Mật khẩu không trùng");
      return false;
    }
    if (_passwordText.isEmpty || _passwordConfirmText.isEmpty) {
      showSnackBar(context, "Mật khẩu trống");
      return false;
    }
    return true;
  }

  void updateSession() {
    var session = widget.session.getSession();
    session.password = _passwordText;
    widget.session.createSession(session);

    _passwordConfirmText = "";
    _passwordText = "";
  }
}
