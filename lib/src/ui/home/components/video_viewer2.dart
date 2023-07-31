import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/ui/home/components/video_overlay.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:video_player/video_player.dart';

class VideoViewer2 extends StatefulWidget {
  final File file;
  final Uint8List thumbnail;
  const VideoViewer2({Key key, this.file, this.thumbnail}) : super(key: key);

  @override
  State<VideoViewer2> createState() => _VideoViewer2State();
}

class _VideoViewer2State extends State<VideoViewer2> {
  VideoPlayerController _videoPlayerController;
  bool _playVideo = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: [
              Center(
                  child: videoWidget("")
              ),
              !_playVideo ? InkWell(
                onTap: (){
                  _videoPlayerController.play();
                  setState(() {
                    _playVideo = !_playVideo;
                  });
                },
                child: Center(
                  child:  Icon(Icons.play_arrow, size: 50, color: Colors.white),
                ),
              ): SizedBox()
            ],
          )
      ),
    );
  }

  Widget videoWidget(String path) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(_videoPlayerController),
            ControlsOverlay(controller: _videoPlayerController),
            VideoProgressIndicator(_videoPlayerController, allowScrubbing: true),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.file(
        widget.file)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    // file(videoInUnit8List);
    // _videoPlayerController.play();
    print("video controller ${_videoPlayerController.dataSource}");
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    widget.file.delete();
  }
}
