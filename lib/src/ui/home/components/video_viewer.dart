import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/ui/home/components/video_overlay.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends StatefulWidget {
  final String url;
  const VideoViewer({Key key, this.url}) : super(key: key);

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  VideoPlayerController _videoPlayerController;
  bool _playVideo = false;
  File file;

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
    // file(videoInUnit8List);
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _videoPlayerController.setLooping(true);
    _videoPlayerController.initialize().then((_) => setState(() {}));
    // _videoPlayerController.play();
    print("video controller ${_videoPlayerController.dataSource}");
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    file.delete();
  }
}
