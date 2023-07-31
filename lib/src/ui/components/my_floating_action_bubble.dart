import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';

class MyFloatingActionBubble extends AnimatedWidget {
  const MyFloatingActionBubble({
    this.endIcon,
    this.startIcon,
    @required this.items,
    @required this.onPress,
    @required this.iconColor,
    @required Animation animation,
  }) : super(listenable: animation);

  final List<Bubble> items;
  final Function onPress;
  final IconData endIcon;
  final IconData startIcon;
  final Color iconColor;

  get _animation => listenable;

  Widget buildItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    final transform = Matrix4.translationValues(
      -(screenWidth - _animation.value * screenWidth) *
          ((items.length - index) / 4),
      0.0,
      0.0,
    );

    return Align(
      alignment: Alignment.centerRight,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: _animation.value,
          child: BubbleMenu(items[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IgnorePointer(
          ignoring: _animation.value == 0,
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height: 12.0),
            padding: EdgeInsets.symmetric(vertical: 12),
            itemCount: items.length,
            itemBuilder: buildItem,
          ),
        ),
        FloatingActionButton(
          backgroundColor: iconColor,
          child: AnimatedIconButton(
            size: 24,
            onPressed: onPress,
            duration: Duration(milliseconds: 200),
            endIcon: Icon(
              endIcon,
              color: kWhiteColor,
            ),
            startIcon: Icon(
              startIcon,
              color: kWhiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
