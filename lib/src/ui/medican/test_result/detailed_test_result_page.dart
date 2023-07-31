import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/models/%20test_results/test_result.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';

class DetailedTestResultPage extends StatefulWidget {
  final TestResultData testResultData;
  final Profiles profiles;
  const DetailedTestResultPage({Key key, this.testResultData, this.profiles}) : super(key: key);

  @override
  _DetailedTestResultPageState createState() => _DetailedTestResultPageState();
}

class _DetailedTestResultPageState extends State<DetailedTestResultPage> {
  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      onBack: (){
        Navigator.of(context).pop();
      },
      title: "Chi tiết xét nghiệm",
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.02,),  
            Text("Thông tin cá nhân", style: TextStyle(fontSize: SizeConfig.screenWidth * 0.06, fontWeight: FontWeight.bold),),
            SizedBox(height: SizeConfig.screenHeight * 0.03,),
            infoField("Họ tên", widget.profiles.name),
            infoField("Năm sinh", getYear(widget.profiles.dateOfBirth)),
            infoField("Số điện thoại", widget.profiles.phone),
            Text("Thông tin chi tiết xét nghiệm", style: TextStyle(fontSize: SizeConfig.screenWidth * 0.06, fontWeight: FontWeight.bold),),
            SizedBox(height: SizeConfig.screenHeight * 0.03,),
            infoField("Thời gian lấy mẫu", getDate(widget.testResultData.dateTaken)),
            infoField("Thời gian trả kết quả", getDate(widget.testResultData.resultDate)),
            infoField("Đơn vị xét nghiệm", widget.testResultData.executedUnit.name),
            infoField("Lý do",  widget.profiles.reason),
            infoField("Mã xét nghiệm", widget.testResultData.code),
            infoField("Kết quả", widget.testResultData.result, contentColor:widget.testResultData.result.toUpperCase() == "DƯƠNG TÍNH"
                ?Colors.red : Colors.green),
          ],
        ),
      ),
    );
  }
  String getDate(String iso){
    DateTime dateTime;
    try{
        dateTime = DateTime.parse(iso);
    } catch(e){
      return "";
    }
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
  String getYear(String iso){
    DateTime dateTime;
    try{
        dateTime = DateTime.parse(iso);
    } catch(e){
      return "";
    }
    return "${dateTime.year}";
  }

  Widget infoField(String title, String content, {Color contentColor = Colors.black}){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03, vertical: SizeConfig.screenHeight * 0.003),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: SizeConfig.screenWidth * 0.045, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: EdgeInsets.only(bottom: 10, top: 5, left: SizeConfig.screenWidth * 0.03, right: SizeConfig.screenWidth * 0.03),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.8), width: 0.5)
            ),
            child: TextField(
              readOnly: true,
              style: TextStyle(color: contentColor),
              controller: TextEditingController(text: content,),
              decoration: InputDecoration(
                border: InputBorder.none
              ),
            ),
          )
        ],
      ),
    );
  }
}
