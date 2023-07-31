import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/my_texts.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';

import '../../../../main.dart';

class UserAvatarVer2 extends StatelessWidget {
  final bool showDetail;
  final String name;
  final String phone;
  const UserAvatarVer2({Key key, this.showDetail = true, this.name, this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> listName;
    String slitName = name;
    try{
      if(listName.length >= 2){
        slitName = "${listName[listName.length -2].substring(0,1)}${listName[listName.length -1].substring(0,1)}";
      } else{
        slitName = slitName.substring(0,1);
      }
    } catch(e){
      slitName = "";
    }
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.all(10),
      width: SizeConfig.screenWidth,

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(8, 8, 8, 8 ),
            height: SizeConfig.screenWidth * 0.2,
            width: SizeConfig.screenWidth * 0.2,
            child:   Stack(
              children: [
                CircleAvatar(
                  radius: SizeConfig.screenWidth * 0.1,
                  child: Center(
                    child: Text(slitName),
                  ),
                ),
                SizedBox(width: 10,),
                Align(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: SizeConfig.screenWidth * 0.03,
                    child: Icon(Icons.camera_alt, size: SizeConfig.screenWidth * 0.03 , color: Colors.black,),
                  ),
                  alignment: Alignment.bottomRight,
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(color: Colors.black, fontSize: SizeConfig.screenWidth * 0.06, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(phone, style: mediumFadeTextStyle,),
            ],
          )
        ],
      ),
    );
  }
}
