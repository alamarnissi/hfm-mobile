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
  @override
  void initState() {
    super.initState();
    AppLogger.it.logInfo("url ${widget.url}");
    flickManager = FlickManager(
        videoPlayerController:VideoPlayerController.networkUrl(Uri.parse("${widget.url}")),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: FlickVideoPlayer(

            flickManager: flickManager
        ),
      ),
    );
  }
}