import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/forget_pass/bloc.dart';
import 'package:ha_tien_app/src/repositories/models/auth/reset_pass_request.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/components/rounded_button.dart';
import 'package:ha_tien_app/src/ui/register/widgets/components/rounded_password_field.dart';
import 'package:ha_tien_app/src/utils/my_texts.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:commons/commons.dart' as common;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'otp/foreget_pass-auth.dart';
class ChangePassPage extends StatefulWidget {
  final String phoneNumber;
  final String id;
  const ChangePassPage({Key key, this.phoneNumber, this.id}) : super(key: key);

  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  String newpass = "";
  String cnewpass = "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseSubPage(
      title: "${AppLocalizations.of(context).forgetPass}  ",
      onBack: () {},
      child: BlocProvider(
        create: (_) => ForgetPassBloc(authRepo: AuthRepo()),
        child: BlocConsumer<ForgetPassBloc, ForgetPassState>(
          listener: (context, state){
             if(state is ForgetPassResetPassLoading){
               common.push(
                 context,
                 common.loadingScreen(
                   context,
                   loadingType: common.LoadingType.JUMPING,
                 ),
               );
             } else
               if(state is ForgetPassResetPassLoaded){
                 Navigator.of(context).pop();
                 Navigator.of(context).pop();
                 showSnackBar(context,AppLocalizations.of(context).changePassSuccess);
               } else
               if(state is ForgetPassResetPassError){
                 Navigator.of(context).pop();
                 showSnackBar(context, state.msg);
               }
          },
          builder: (context, state){
            return Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.2,),
                Text(AppLocalizations.of(context).changePassTitle, style: bigBoldTextStyle,),
                Text(AppLocalizations.of(context).changePassSubTitle, style: normalFadeTextStyle, textAlign: TextAlign.center,),
                SizedBox(height: SizeConfig.screenHeight * 0.05,),
                RoundedPasswordField(
                  width: SizeConfig.screenWidth,
                  title: AppLocalizations.of(context).password,
                  onChanged: (value) {
                    newpass = value;
                  },
                ),
                RoundedPasswordField(
                  title: AppLocalizations.of(context).registerConfirm,
                  width: SizeConfig.screenWidth,
                  onChanged: (value) {
                    cnewpass = value;
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03,),
                RoundedButton(text: AppLocalizations.of(context).update, color: Colors.green, textColor: Colors.black, press: (){
                  if(newpass != cnewpass){
                    showSnackBar(context, AppLocalizations.of(context).confirmPassCheck);
                  } else if(newpass.length <1 || cnewpass.length <1){
                    showSnackBar(context, AppLocalizations.of(context).fillAllInfo);
                  }else
                    {
                      IdEncode idEncode = IdEncode.fromJson(json.decode(widget.id));
                      BlocProvider.of<ForgetPassBloc>(context).add(ResetPassE(ResetPassRequest(id: idEncode.id, newPass: cnewpass, phoneNumber: widget.phoneNumber)));
                    }
                },),
              ],
            );
          },
        ),
      ),
    );
  }
}

class IdEncode{
  String id;

  IdEncode(
      {this.id});

  IdEncode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
