import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/repositories/models/event_file/event_file.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewScreen extends StatefulWidget {
  static String routeName = "/PhotoViewScreen";
  final List<EventFiles> files;

  const PhotoViewScreen({Key key, this.files}) : super(key: key);

  @override
  _PhotoViewScreenState createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: MemoryImage(base64Decode(widget.files[index].file)),
          initialScale: PhotoViewComputedScale.contained * 0.8,
        );
      },
      itemCount: widget.files.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          ),
        ),
      ),
      // backgroundDecoration: widget.backgroundDecoration,
      // pageController: widget.pageController,
      // onPageChanged: onPageChanged,
    ));
  }
}
