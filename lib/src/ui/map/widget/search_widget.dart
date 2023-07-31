import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final ValueChanged onChanged;
  final ValueChanged onSummited;
  final String title;
  final double width;
  final double height;

  const SearchWidget({Key key, this.onChanged, this.onSummited, this.title, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: height,
        width: width,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueAccent)),
        child: Center(
          child: TextField(
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 18, ),
              hintText: title,
              // suffixIcon: Icon(Icons.search),
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 10 ),
            ),
            onChanged: onChanged,
            onSubmitted: onSummited,
          ),
        ));
  }
}
