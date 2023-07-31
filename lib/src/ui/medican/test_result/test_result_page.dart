import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/test_result/bloc.dart';
import 'package:ha_tien_app/src/repositories/models/%20test_results/test_result.dart';
import 'package:ha_tien_app/src/repositories/remote/test_result_repo/test_repo_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';

import 'detailed_test_result_page.dart';

class TestResultPage extends StatefulWidget {
  final String phoneNumber;
  const TestResultPage({Key key, this.phoneNumber}) : super(key: key);

  @override
  _TestResultPageState createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TestResultBloc(TestResultRepo()),
      child: BlocBuilder<TestResultBloc, TestResultState>(
        builder: (context, state) {
          print("TestResultState ${state} ${widget.phoneNumber}");
          if (state is TestResultInitial) {
            BlocProvider.of<TestResultBloc>(context)
                .add(GetTestResultE(widget.phoneNumber));
          } else if (state is GetTestResulLoading) {
            return Center(child: LoadingIndicator());
          } else if (state is GetTestResulLoaded) {
            print("GetTestResulLoaded xx ${state.data.data.length}");
            return Expanded(
              // height: SizeConfig.screenHeight * 0.6,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: _buildListItemsFromitems(state.data),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: _controller,
                ),),
            );
          } else if (state is GetTestResulLoadError) {
            print("GetTestResulLoadError");
            return Container(child: Text("Hiện không tìm thấy thông tin!", style: TextStyle(color: Colors.black),),);
          }
          return Container();
        },
      ),
    );
  }

  List<Widget> _buildListItemsFromitems(TestResult data) {
    List<Widget> widgets = List<Widget>();
    for (var i in data.data) {
      for (var j in i.profiles) {
        DateTime testTime;
        DateTime resultTime;
        if (j.phone != widget.phoneNumber) {
          continue;
        }
        try {
          testTime = DateTime.parse(i.dateTesting);
          resultTime = DateTime.parse(i.resultDate);
        } catch (e) {}
        var container = InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailedTestResultPage(
                      profiles: j,
                      testResultData: i,
                    )));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.015),
            padding: EdgeInsets.all(SizeConfig.screenWidth * 0.02),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(-10, 10),
                  blurRadius: 10),
            ]),
            child: Row(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.02,
                ),
                Column(
                  children: [
                    Text(
                      "${testTime?.day < 10 ? "0" : ""}${testTime?.day}",
                      style: TextStyle(
                          fontSize: SizeConfig.screenWidth * 0.08,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.007,
                    ),
                    Text("${testTime?.month}/${testTime?.year}",
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.04,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.03,
                ),
                Column(
                  children: [
                    horiWidget("assets/icons/person.png", j.name),
                    horiWidget("assets/icons/test_results.png", i.result,
                        titleColor: i.result.contains("ÂM")
                            ? Colors.green
                            : Colors.red),
                    horiWidget(
                        "assets/icons/calendar.png",
                        resultTime != null
                            ? "${resultTime.hour}:${resultTime.minute} ${resultTime.day}/${resultTime.month}/${resultTime.year}"
                            : ""),
                    horiWidget(
                        "assets/icons/location.jpg", i.assigmentUnit.name),
                  ],
                )
              ],
            ),
          ),
        );
        widgets.add(container);
      }
    }
    return widgets;
  }

  Widget horiWidget(String asset, String title,
      {Color titleColor = Colors.black}) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.screenWidth * 0.015),
      child: Row(
        children: [
          Image.asset(
            asset,
            width: SizeConfig.screenWidth * 0.05,
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.02,
          ),
          Container(
            width: SizeConfig.screenWidth * 0.6,
            child: Text(title,
                style: TextStyle(
                    color: titleColor, fontSize: SizeConfig.screenWidth * 0.04),
                overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}
