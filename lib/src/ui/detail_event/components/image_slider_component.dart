import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/repositories/models/event_file/event_file.dart';
import 'package:ha_tien_app/src/repositories/models/event_log/event_log.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/home/components/bcsc_view.dart';
import 'package:ha_tien_app/src/ui/home/components/gallery_item.dart';
import 'package:ha_tien_app/src/ui/home/components/video_viewer.dart';
import 'package:ha_tien_app/src/ui/home/components/video_viewer2.dart';
import 'package:ha_tien_app/src/ui/photo_view/photo_view_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

List<AttachedFile> fileImage = List<AttachedFile>();

class ImageSliderComponent extends StatefulWidget {
  final List<EventLog> eventLogList;

  const ImageSliderComponent({Key key, this.eventLogList}) : super(key: key);

  @override
  _ImageSliderComponentState createState() => _ImageSliderComponentState();
}

GlobalKey<_ImageSliderComponentState> ImgStateGlobalKey =
new GlobalKey<_ImageSliderComponentState>();

class _ImageSliderComponentState extends State<ImageSliderComponent> {
  List<AttachedFile> files;
  List<EventFiles> eventFile = List<EventFiles>();
  int i = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<EventsBloc>(context)
        .add(GetEventFilesEvent(widget.eventLogList[i].id));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<EventsBloc, EventsState>(
        listener: (context, state) => {},
        builder: (context, state) {
          if (state is GetEventFilesSuccess) {
            print("_ImageSliderComponentState ${state.data.length}");
            eventFile.clear();
            for (var i in state.data) {
              eventFile.add(i);
              log("_ImageSliderComponentData ${i.linkFileAttached}");
            }
            i++;
            if (i < widget.eventLogList.length) {
              BlocProvider.of<EventsBloc>(context)
                  .add(GetEventFilesEvent(widget.eventLogList[i].id));
            }
            if (i >= widget.eventLogList.length) {
              if (eventFile.length <= 0)
                return Center(
                  child: Text(
                    "Không có hình ảnh",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              else
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false),
                    items: eventFile
                        .map((e) => Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: e.linkFileAttached.contains("jpeg") || e.linkFileAttached.contains("png") || e.linkFileAttached.contains("jpg")
                            ? Container(
                          height: (size.height * 0.3),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    e.linkFileAttached,
                                  ),
                                  fit: BoxFit.cover)),
                          width: (size.width),
                        )
                            : FutureBuilder(
                          future: getThumbnailfile(e.linkFileAttached),
                          builder: (context, data){
                            if(data.hasData){
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                height: (size.height * 0.3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: FileImage(File(data.data)),
                                      fit: BoxFit.fill
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: Center(
                                          child: Icon(Icons.play_arrow, size: 40, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoViewer(url: e.linkFileAttached,)));
                                      },
                                      child: Container(
                                        height: (size.height * 0.3),
                                        color:Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return LoadingIndicator();
                          },
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                );
            }
          }
          return LoadingIndicator();
        });
  }
  Future<ThumbNailData> getThumbnail(Uint8List data) async {
    final tempDir = await getTemporaryDirectory();
    File file;
    if (Platform.isAndroid) {
      file = await File('${tempDir.path}/${data.sublist(1,10)}.mp4').create();
    } else if (Platform.isIOS) {
      file = await File('${tempDir.path}/${DateTime.now().toIso8601String()}.mp4').create();
    }

    await file.writeAsBytes(data);
    final uint8list = await VideoThumbnail.thumbnailData(
      video: file.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 300,
// specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 80,
    );
    return ThumbNailData(uint8list, file);
  }


  void _onTapItem(List<EventFiles> data) {
    Navigator.of(context).pushNamed(PhotoViewScreen.routeName, arguments: data);
  }


  void postFile(String eventLogId) async {
    List<MapEntry<String, MultipartFile>> mapEntries =
    List<MapEntry<String, MultipartFile>>();
    for (AttachedFile data in files) {
      MultipartFile file = MultipartFile.fromBytes(data.file, filename: "name");
      mapEntries.add(MapEntry("files", file));
    }
    print("_postFile ${mapEntries.length}");
    try {
      for (var i in mapEntries) {
        var formData = FormData();
        formData.files.add(i);
        try {
          BlocProvider.of<EventsBloc>(context).add(UpdateEventFilesEvent(
            eventLogId,
            [],
          ));
        } catch (e) {}
      }
    } catch (e) {}
  }
}

class ThumbNailData{
  final Uint8List thumbnail;
  final File file;

  ThumbNailData(this.thumbnail, this.file);
}
