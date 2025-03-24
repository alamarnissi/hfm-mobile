import 'package:app_logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tiwee/src/features/home/presentation/widgets/landscape_player_controls.dart';
import 'package:video_player/video_player.dart';

class SamplePlayer extends StatefulWidget {
  final String url;
  final Map<String, String>? httpHeaders;

  const SamplePlayer({super.key, required this.url, this.httpHeaders});

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  late FlickManager flickManager;
  late VideoPlayerController videoPlayerController;
  bool canPop = false;
BoxFit videoFit= BoxFit.contain;
  @override
  void initState() {
    super.initState();
    AppLogger.it.logInfo("url ${widget.url}");

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url),
            httpHeaders: widget.httpHeaders ?? {},
            videoPlayerOptions: VideoPlayerOptions(
              allowBackgroundPlayback: false,

            ),);

    flickManager = FlickManager(
      videoPlayerController: videoPlayerController,

    );
   // flickManager.flickControlManager?.enterFullscreen();
  }

  @override
  void dispose() {
    super.dispose();

    try {
      // flickManager.flickControlManager?.exitFullscreen();
      flickManager.flickControlManager?.pause();
    } catch (_) {}
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FlickVideoPlayer(
        flickManager: flickManager,
        preferredDeviceOrientation: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ],
        systemUIOverlay: [],
        flickVideoWithControls: FlickVideoWithControls(
          controls: LandscapePlayerControls(
          toggleFit: () {
            setState(() {
              videoFit = BoxFit.values[(videoFit.index + 1) % BoxFit.values.length];
            });
          },
          ),
          videoFit: videoFit,

        ),
      ),
    );

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        AppLogger.it.logInfo("didPop $didPop");
        AppLogger.it.logInfo("result $result");
        if (flickManager.flickControlManager?.isFullscreen == true) {
          flickManager.flickControlManager?.exitFullscreen();

          Get.showSnackbar(GetSnackBar(title: '',message: 'Tap back again to leave',duration: Duration(seconds: 1),isDismissible: true,));

        }

        setState(() {
          canPop=true;
        });

      },
      canPop: canPop,
      child: AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: FlickVideoPlayer(

          preferredDeviceOrientation: [
            DeviceOrientation.landscapeLeft,
            // DeviceOrientation.landscapeRight,
          ],
          flickManager: flickManager,
        ),
      ),
    );
  }
}
