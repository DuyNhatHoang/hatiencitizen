import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/models/events/my_user_event_distance.dart';
import 'package:ha_tien_app/src/repositories/models/events/user_event.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_functions.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DistanceEventItem extends StatelessWidget {
  final MyUserEventDistance event;
  final int index;

  const DistanceEventItem({Key key, this.event, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "${event.eventTypeName}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(convertDateTimeToVN(event.dateTime),
                    style: myHintItemStyle()),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${AppLocalizations.of(context).content}: ",
                        style: TextStyle(color: kBlackColor),
                      ),
                      TextSpan(
                        text: event.decription,
                        style: myTitleItemStyle(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text("${AppLocalizations.of(context).place}: ${event.address}"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${AppLocalizations.of(context).distance}: ",
                            style: TextStyle(color: kBlackColor),
                          ),
                          TextSpan(
                            text: convertDistanceVN(event.distance),
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
