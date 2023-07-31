import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ha_tien_app/src/blocs/auth/auth_bloc.dart';
import 'package:ha_tien_app/src/blocs/login/login_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/models/users/update_user_request.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:nice_button/NiceButton.dart';

class UpdateInfoBottomSheet extends StatefulWidget {
  final SessionManager session;
  final Session sessionData;

  const UpdateInfoBottomSheet({this.session, this.sessionData});

  @override
  _UpdateInfoBottomSheetState createState() => _UpdateInfoBottomSheetState();
}

class _UpdateInfoBottomSheetState extends State<UpdateInfoBottomSheet> {
  String _nameText = "";
  String _phoneText = "";
  String _emailText = "";
  Session session;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    session = widget.sessionData;
    _nameText = widget.sessionData.fullName;
    _phoneText = widget.sessionData.phoneNumber;
    _emailText = widget.sessionData.email;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BlocProvider(
        create: (context) => LoginBloc(
            AuthRepo.withToken(widget.session.getSession().accessToken),
            AuthBloc()),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 32),
              width: size.width * Constants.horizontalArea,
              child: TextFormField(
                keyboardType: TextInputType.text,
                cursorColor: Theme.of(context).cursorColor,
                initialValue: session.fullName,
                onChanged: (s) {
                  setState(() {
                    _nameText = s;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Họ tên",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 32),
            //   width: size.width * Constants.horizontalArea,
            //   child: TextFormField(
            //     cursorColor: Theme.of(context).cursorColor,
            //     keyboardType: TextInputType.phone,
            //     initialValue: session.phoneNumber,
            //     onChanged: (s) {
            //       setState(() {
            //         _phoneText = s;
            //       });
            //     },
            //     decoration: InputDecoration(
            //       labelText: "Số điện thoại",
            //       labelStyle: TextStyle(
            //         color: Colors.black,
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              margin: EdgeInsets.only(top: 32),
              width: size.width * Constants.horizontalArea,
              child: TextFormField(
                cursorColor: Theme.of(context).cursorColor,
                initialValue: session.email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (s) {
                  setState(() {
                    _emailText = s;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is UpdateUserSuccess) {
                  updateSession();
                  showSnackBar(context, "Cập nhật thành công");
                } else if (state is UpdateUserFailure) {
                  print("loi: ${state.error.getErrorMessage()}");
                  showSnackBar(context,
                      "Cập nhật thất bại do ${state.error.getErrorMessage()}");
                }
              },
              builder: (context, state) {
                if (state is UpdateUserInProgress) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LoadingIndicator(),
                  );
                }
                return Container(
                  margin: EdgeInsets.only(top: 16),
                  child: NiceButton(
                    fontSize: Constants.largeFontSize,
                    elevation: 3.0,
                    radius: 12.0,
                    text: "Xác nhận",
                    background: kPrimaryColor,
                    onPressed: () {
                      onUpdateUserPressed(context);
                      setState(() {});
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
      );
    });
  }

  bool check(context) {
    if (_nameText.length <= 0) {
      showSnackBar(context, "Tên không được trống");
      return false;
    }
    if (!validateEmail(_emailText)) {
      showSnackBar(context, "Email không đúng định dạng");
      return false;
    }
    return true;
  }

  void updateSession() {
    var session = widget.session.getSession();
    session.fullName = _nameText;
    session.email = _emailText;
    session.phoneNumber = _phoneText;
    widget.session.createSession(session);

    _emailText = "";
    _phoneText = "";
  }

  void onUpdateUserPressed(BuildContext context) {
    check(context)
        ? BlocProvider.of<LoginBloc>(context).add(UpdateUserEvent(
            UpdateUserRequest(
                phoneNumber: _phoneText,
                fullName: _nameText,
                email: _emailText)))
        : null;
  }
}
