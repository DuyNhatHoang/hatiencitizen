import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/auth/auth_bloc.dart';
import 'package:ha_tien_app/src/blocs/register/register_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/users/create_user_request.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/medican/test_result/phone_number_check.dart';
import 'package:ha_tien_app/src/ui/login/otp_comfirm/otp_insert_phone.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_connection.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/ui/login/otp_comfirm/otp_insert_phone.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:commons/commons.dart' as common;
import 'otp/account_authenticate_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class RegisterScreen extends StatefulWidget {
  static const String routeName = "/RegisterScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  BuildContext authContext;
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _name = TextEditingController();
  String _email = "";
  TextEditingController _phoneNumber = TextEditingController();
  MyConnection connection;
  double space = 20;
  bool isConfirm = false;
  bool _passwordVisible = true;
  bool _cfPasswordVisible = true;

  //error
  String nameE;
  String passE;
  String cpassE;
  String tkE;
  String phoneE;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connection = MyConnection(context);
    connection.checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocProvider(
              create: (context) => RegisterBloc(AuthRepo()),
              child: BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Navigator.pop(context);
                      showSnackBar(context, AppLocalizations.of(context).registerSuccess);
                      // Navigator.of(context).push(  MaterialPageRoute(builder: (context) => PhoneOptInsert(phoneNumber: _phoneNumber.text,)));
                    } else if (state is RegisterFailure) {
                      showSnackBar(context, AppLocalizations.of(context).accountExisted);
                    }
                  }, builder: (context, state) {
                if (state is RegisterInProgress) {
                  return Container(
                    height: size.height,
                    child: Center(
                      child: LoadingIndicator(),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.1,
                    ),
                    Container(
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).register,
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        )),
                    SizedBox(
                      width: double.infinity,
                      height: 20,
                    ),
                    Container(
                        width: size.width * Constants.horizontalArea,
                        child: TextFormField(
                            controller:  _username,
                            keyboardType: TextInputType.text,
                            decoration: (_username.text.length <= 0 && isConfirm == true)
                                ? InputDecoration(
                              labelText: AppLocalizations.of(context).username,
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              errorText: tkE,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            )
                                : InputDecoration(
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: AppLocalizations.of(context).username,
                            ))),
                    SizedBox(
                      height: space,
                    ),
                    Container(
                        width: size.width * Constants.horizontalArea,
                        child: TextFormField(
                          controller: _password,
                          keyboardType: TextInputType.text,
                          obscureText: _passwordVisible,
                          decoration: (_password.text.length < 6 && isConfirm == true)
                              ? InputDecoration(
                            labelText: AppLocalizations.of(context).password,
                            border:  OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.black)),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            errorText: passE,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          )
                              : InputDecoration(
                            border:  OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: AppLocalizations.of(context).password,
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        )),
                    SizedBox(
                      height: space,
                    ),
                    Container(
                        width: size.width * Constants.horizontalArea,
                        child: TextFormField(
                          controller: _confirmPassword,
                            keyboardType: TextInputType.text,
                            obscureText: _cfPasswordVisible,
                            decoration: (_confirmPassword.text.length < 6 &&
                                isConfirm == true)
                                ? InputDecoration(
                              labelText: AppLocalizations.of(context).confirmPass,
                              errorText: cpassE,
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _cfPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _cfPasswordVisible = !_cfPasswordVisible;
                                  });
                                },
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            )
                                : InputDecoration(
                              labelText: AppLocalizations.of(context).confirmPass,
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _cfPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _cfPasswordVisible = !_cfPasswordVisible;
                                  });
                                },
                              ),
                            )
                        )),
                    SizedBox(
                      height: space,
                    ),
                    Container(
                        width: size.width * Constants.horizontalArea,
                        child: TextFormField(
                          controller: _name,
                            keyboardType: TextInputType.text,
                            decoration: (_name.text.length <= 0 && isConfirm == true)
                                ? InputDecoration(
                              labelText: AppLocalizations.of(context).fullname,
                              errorText: nameE,
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            )
                                : InputDecoration(
                              labelText: AppLocalizations.of(context).fullname,
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                            ))),
                    SizedBox(
                      height: space,
                    ),
                    Container(
                        width: size.width * Constants.horizontalArea,
                        child: TextFormField(
                          controller: _phoneNumber,
                            keyboardType: TextInputType.number,
                            decoration: (_phoneNumber.text.length != 10 &&
                                isConfirm == true)
                                ? InputDecoration(
                              labelText: AppLocalizations.of(context).phoneNumber,
                              errorText: phoneE,
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            )
                                : InputDecoration(
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: AppLocalizations.of(context).phoneNumber,
                            ))),
                    SizedBox(
                      height: space,
                    ),
                    // Container(
                    //     width: size.width * Constants.horizontalArea,
                    //     child: TextFormField(
                    //         keyboardType: TextInputType.text,
                    //         initialValue: "",
                    //         onChanged: (s) {
                    //           _email = s;
                    //           setState(() {});
                    //         },
                    //         decoration: (_email.length <= 0 && isConfirm == true)
                    //             ? InputDecoration(
                    //           labelText: "Email",
                    //           errorText: '',
                    //           border: OutlineInputBorder(),
                    //           labelStyle: TextStyle(
                    //             color: Colors.black,
                    //           ),
                    //           enabledBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(color: Colors.black),
                    //           ),
                    //         )
                    //             : InputDecoration(
                    //           labelText: "Email",
                    //         ))),
                    SizedBox(
                      height: space,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: NiceButton(
                        fontSize: Constants.largeFontSize,
                        elevation: 8.0,
                        radius: 12.0,
                        text: AppLocalizations.of(context).registerConfirm,
                        background: Colors.green.shade600,
                        onPressed: () {

                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (context) => AccountAuthenticatePage())
                          // );
                          onRegisterPressed(context);
                          setState(() {
                            isConfirm = true;
                          });

                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onCancelPressed(),
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                          AppLocalizations.of(context).cancel,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: kPrimaryColor,
                              fontSize: Constants.normalFontSize),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onRegisterPressed(BuildContext context) async {

    if (_name.text.length <= 0 ||
        _username.text.length <= 0 ||
        _phoneNumber.text.length != 10 ||
        _confirmPassword.text.length < 6 ||
        _password.text.length < 6) {
      showSnackBar(context, AppLocalizations.of(context).incorrectInfo);
      if(_confirmPassword.text != _password.text){
        setState(() {
          cpassE = AppLocalizations.of(context).confirmPassCheck;
        });
      }
      if(_username.text.length <= 0){
        setState(() {
          tkE = AppLocalizations.of(context).wrongUserName;
        });
      }
      if(_name.text.length <= 0){
        setState(() {
          nameE = AppLocalizations.of(context).emptyName;
        });
      }
      if(_password.text.length < 6){
        setState(() {
          passE = "Mật khẩu phải lớn hơn 6 kí tự";
        });
      }
      if(_confirmPassword.text.length < 6){
        setState(() {
          cpassE = AppLocalizations.of(context).passLong;
        });
      }
      if(_phoneNumber.text.length <= 0){
        setState(() {
          phoneE = AppLocalizations.of(context).passLong;
        });
      }
    } else {
      if (await connection.checkConnection()) if (_password.text !=
          _confirmPassword.text) {
        showSnackBar(context, AppLocalizations.of(context).confirmPassCheck);
      } else {
        BlocProvider.of<RegisterBloc>(context)
            .add(RegisterStarted(CreateUserRequest(
          fullName: _name.text,
          password: _password.text,
          phoneNumber: _phoneNumber.text,
          userName: _username.text,
        )));
      }
    }
  }

  _onCancelPressed() {
    Navigator.pop(context);
  }
}
