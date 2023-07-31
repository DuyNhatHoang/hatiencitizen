import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/ui/login/login_screen.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LogOutWidget extends StatelessWidget {
  const LogOutWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){
        onLogOutPressed(context);
      },
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.grey, width: 1),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.exit_to_app,
                size: SizeConfig.screenWidth * 0.04,
              ),
            ),
            Center(
              child: Text(AppLocalizations.of(context).logout,
                  style: TextStyle(color: Colors.red, fontSize: SizeConfig.screenWidth * 0.03)),
            )
          ],
        ),

      ),
    );
  }
  Future<void> onLogOutPressed(BuildContext context) async {
    SessionManager sessionManager =
    SessionManager(await SharedPreferences.getInstance());
    sessionManager.removeSession();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }
}
