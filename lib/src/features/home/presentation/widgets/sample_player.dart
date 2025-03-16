import 'package:app_logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class SamplePlayer extends StatefulWidget {
  final String url;
  SamplePlayer({Key? key, required this.url}) : super(key: key);

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  late FlickManager flickManager;
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    AppLogger.it.logInfo("url ${widget.url}");


    videoPlayerController=  VideoPlayerController.networkUrl(Uri.parse("${widget.url}"));

    flickManager = FlickManager(
        videoPlayerController:videoPlayerController,

    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLogger.it.logInfo("videoPlayerController.value.aspectRatio ${videoPlayerController.value.aspectRatio}");
    return SafeArea(
      child:
          AspectRatio(
            aspectRatio: videoPlayerController.value.aspectRatio ,

            child: FlickVideoPlayer(
preferredDeviceOrientation: [
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,

],
                flickManager: flickManager,

            ),
          )


    );
  }
}