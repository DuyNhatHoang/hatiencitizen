import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/login/login_bloc.dart';
import 'package:ha_tien_app/src/blocs/users/users_bloc.dart';
import 'package:ha_tien_app/src/repositories/local/pref/session_manager.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/home/tkview/user_avatar.dart';
import 'package:ha_tien_app/src/ui/medican/test_result/test_result_page.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';

class MedicanPage extends StatefulWidget {
  final SessionManager session;
  final String phoneNumber;

  const MedicanPage({Key key, this.session, this.phoneNumber}) : super(key: key);

  @override
  _MedicanPageState createState() => _MedicanPageState();
}

class _MedicanPageState extends State<MedicanPage> {
  bool isTestResult = true;

  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      title: "Y tế",
      onBack: (){
        Navigator.of(context).pop();
      },
      child: BlocProvider(
        create: (context) {
      return LoginBloc(AuthRepo.withToken(widget.session.getSession().accessToken), null)
        ..add(GetUserInfoEvent());
    },
      child: Container(
        height: SizeConfig.screenHeight * 0.91,
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Center(
              child: UserAvatarVer2(name: widget.session.getSession().fullName, showDetail: true, phone: widget.phoneNumber,),
            ),
            // SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isTestResult = true;
                    });
                  },
                  child: Container(
                      width: SizeConfig.screenWidth * 0.45,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: chonCaNhan?kPrimaryColor: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Kết quả xét nghiệm",
                                style: TextStyle(
                                    color: isTestResult
                                        ? Colors.green
                                        : Colors.black,
                                    fontSize: SizeConfig.screenWidth * 0.04,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
                            height: 2,
                            color: isTestResult ? Colors.green : Colors.transparent,
                          )
                        ],
                      )),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      isTestResult = false;
                    });
                  },
                  child: Container(
                      width: SizeConfig.screenWidth * 0.45,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: chonCaNhan?kPrimaryColor: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Tiêm chủng",
                                style: TextStyle(
                                    color:
                                    !isTestResult ? Colors.green : Colors.black,
                                    fontSize: SizeConfig.screenWidth * 0.04,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
                            height: 2,
                            color:
                            !isTestResult ? Colors.green : Colors.transparent,
                          )
                        ],
                      )),
                ),

              ],
            ),
            isTestResult?TestResultPage(phoneNumber: widget.phoneNumber,):Container(
              margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01),
              child: Center(
                child: Text("Tính năng đang phát triển!"),
              ),
            )
            // TestResultPage(phoneNumber: widget.phoneNumber)
          ],
        ),
      ))
      ,
    );
  }
}
