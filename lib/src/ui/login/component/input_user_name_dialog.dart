import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/login/login_bloc.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void showInputUserNameDialog(BuildContext context){
  Size size = MediaQuery.of(context).size;
  String username = "";
  showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Center(child: Text(AppLocalizations.of(context).forgetPass, style: TextStyle(color: kPrimaryColor, fontSize: Constants.largeFontSize),),),
        content: Container(
          height: size.height * 0.15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context).inputname,style: TextStyle(fontWeight: FontWeight.bold, fontSize: Constants.mediumFontSize)),
              SizedBox(height: 20,),
              TextFormField(
                  keyboardType: TextInputType.text,
                  initialValue: "",
                  onChanged: (s) {
                    username = s;
                  },
                  decoration:
                  InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    errorText: '',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black),
                    ),
                  ))
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            color: Colors.grey,
            child: Text('    cancel    ', style: TextStyle(color: Colors.white),),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
            },
          ),
          SizedBox(width: 10,),
          FlatButton(
            color: kPrimaryColor,
            child: Text('  Reset  '),
            onPressed: () {
              forgetPassPress(context,username);
              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
            },
          ),
        ],
      );
    },
  );
}

void showSendEmailDialog(BuildContext context, String email){
  Size size = MediaQuery.of(context).size;
  String username = "";
  showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Center(child: Text('Đặt lại mật khẩu', style: TextStyle(color: kPrimaryColor, fontSize: Constants.largeFontSize)),),
        content: Container(
          height: size.height * 0.1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: new TextSpan(
                  text: 'Vui lòng kiểm tra email:  ',
                  style: TextStyle(fontSize: Constants.mediumFontSize, color: Colors.black),
                  children: <TextSpan>[
                    new TextSpan(
                        text: email,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: Constants.mediumFontSize, color: Colors.black)),
                    new TextSpan(text: ' để lấy lại mật khẩu', style: TextStyle( color: Colors.black,fontSize: Constants.mediumFontSize)),
                  ],
                ),)
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
            },
          ),
        ],
      );
    },
  );
}

Future<void> forgetPassPress(BuildContext context,String username) async {
  BlocProvider.of<LoginBloc>(context).add(ForgotPass(username: username));
}