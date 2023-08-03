import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/ui/components/loading_indicator.dart';
import 'package:ha_tien_app/src/ui/home/components/photo_view.dart';
import 'package:ha_tien_app/src/ui/home/components/video_viewer.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'gallery_app_view.dart';

class GalleryItem extends StatefulWidget {
  final FileItem item;
  final ValueChanged<FileItem> onChanged;
  const GalleryItem({Key key, this.item, this.onChanged}) : super(key: key);

  @override
  State<GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  FileItem item;


  @override
  void initState() {
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {

    return image();
  }

  Widget image(){
    return  InkWell(
      onTap: (){
        setState(() {
          item.isChoose = !item.isChoose;
          widget.onChanged(item);

        });
        //
      },
      child: getWidgetByExtention(),
    );
  }

  Widget getWidgetByExtention(){
    if(item.file.toLowerCase().contains("png") || item.file.toLowerCase().contains("jpg") || item.file.toLowerCase().contains("jpeg")){
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: SizeConfig.screenWidth * 0.4,
        width: SizeConfig.screenWidth * 0.4,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(item.file),
                fit: BoxFit.fill
            ),

            borderRadius: BorderRadius.circular(5)
        ),
        child: Stack(
          children: [
            Container(
              height: SizeConfig.screenWidth * 0.4,
              width: SizeConfig.screenWidth * 0.4,
              color: item.isChoose ? Colors.black54 : Colors.transparent,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 30,
                width: 30,
                child: Center(
                  child: item.isChoose ? Image.asset("assets/icons/check.png", width: 40,) :Container(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhotoViewer(url: item.file,)));
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Image.asset("assets/icons/extend.png", width: 20, color: Colors.white,),
                  ),
                ),
              ),
            )

          ],
        ),
      );
    } else
    if(item.file.toLowerCase().contains("mp4")){
      return FutureBuilder(
        future: getThumbnailfile(item.file),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: SizeConfig.screenWidth * 0.4,
              width: SizeConfig.screenWidth * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: FileImage(File(snapshot.data)),
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
                  Container(
                    height: SizeConfig.screenWidth * 0.4,
                    width: SizeConfig.screenWidth * 0.4,
                    color: item.isChoose ? Colors.black54 : Colors.transparent,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: item.isChoose ? Image.asset("assets/icons/check.png", width: 40,) :Container(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoViewer(url: item.file,)));
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Image.asset("assets/icons/extend.png", width: 20, color: Colors.white,),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          }
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: SizeConfig.screenWidth * 0.4,
            width: SizeConfig.screenWidth * 0.4,
            child: Center(
              child: LoadingIndicator(),
            ),
          );
        },
      );
    }
    return Container();
  }

}

Future<String> getThumbnailfile(String url) async {
  final fileName = await VideoThumbnail.thumbnailFile(
    video: url,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.JPEG,
    maxHeight: 200, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
    quality: 100,
  );
  return fileName;
}
