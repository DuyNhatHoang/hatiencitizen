import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/utils/constants.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:http/http.dart' as http;

class EventItem extends StatefulWidget {
  final UserEvent event;
  final int index;

  const EventItem({
    Key key,
    this.event,
    this.index,
  }) : super(key: key);

  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  RelatedUserResponse response;
  http.Client client = http.Client();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRelatedUser("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // color: Colors.grey.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: SizeConfig.screenHeight * 0.18,
                  width: SizeConfig.screenWidth * 0.022,
                  decoration: BoxDecoration(
                      color: Constants
                          .statusColors[widget.event.status] != null ? Constants
                          .statusColors[widget.event.status].withOpacity(.7) : Constants
                          .statusColors[1 ].withOpacity(.7) ,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), topLeft: Radius.circular(30))
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "${widget.event.eventTypeName}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: SizeConfig.screenWidth * 0.05),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.008,),
                    Text("${ widget.event.decription}",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: SizeConfig.screenWidth * 0.035)),
                    Divider(color: Colors.grey, thickness: 0.5,),
                    SizedBox(height: SizeConfig.screenHeight * 0.008,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.event_note, size: SizeConfig.screenWidth * 0.05,),
                        Container(
                          width:  SizeConfig.screenWidth * 0.75,
                          child:  Text(
                            "   ${convertDateTimeToVN(widget.event.dateTime)}",
                            style: TextStyle(fontSize: SizeConfig.screenWidth * 0.03),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.008,),
                    Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.location_on, size: SizeConfig.screenWidth * 0.05,),
                            Container(
                              width:  SizeConfig.screenWidth * 0.75,
                              child:  Text(
                                "   ${widget.event.address}",
                                style: TextStyle(fontSize: SizeConfig.screenWidth * 0.03),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        )
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01,),

                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<int> getRelatedUser(String id) async {
    // BlocProvider.of<EventsBloc>(context)
    //     .add(GetRelateEvent(request: "353aa653-ef4b-431d-8af8-0cd57ad820c2"));
  }
  Color mapEventTypeToColor(int type){
    switch(type) {
      case 1:
        return Color(0xE5E5E5);
        break;
      case 2:
        return Color(0xE5E5E5);
        break;
      case 3:
        return Color(0xE5E5E5);
        break;
      case 4:
        return Color(0xE5E5E5);
        break;
      case 5:
        return Color(0xE5E5E5);
        break;
      default:
        return Color(0xE5E5E5);
    }
  }
}
