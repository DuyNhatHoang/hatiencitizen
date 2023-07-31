import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/models/users/create_user_request.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/login/otp_comfirm/forget_pass_incode.dart';
import 'package:ha_tien_app/src/ui/register/otp/pin_code_verification.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PhoneRegisterPage extends StatefulWidget {
  final String phoneNumber;
  final SessionManager session;
  const PhoneRegisterPage({Key key, this.phoneNumber, this.session}) : super(key: key);

  @override
  _PhoneRegisterPageState createState() => _PhoneRegisterPageState();
}

class _PhoneRegisterPageState extends State<PhoneRegisterPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseSubPage(
      title: AppLocalizations.of(context).accountValidate,
      onBack: () {
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          ForgetPassPinCode(
              widget.phoneNumber)
        ],
      ),
    );
  }
}
