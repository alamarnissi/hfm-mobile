import 'package:app_logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tiwee/src/features/home/presentation/widgets/chewie_player_controls.dart';

class SamplePlayer extends StatefulWidget {
  final String url;
  final Map<String, String>? httpHeaders;

  const SamplePlayer({super.key, required this.url, this.httpHeaders});

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool canPop = false;
  BoxFit videoFit = BoxFit.contain;

  @override
  void initState() {
    super.initState();
    AppLogger.it.logInfo("url ${widget.url}");

    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
      httpHeaders: widget.httpHeaders ?? {},
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
    );

    chewieController = ChewieController(
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(errorMessage, style: TextStyle(color: Colors.white)),
        );
      },
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      // Use a default aspect ratio initially; will be updated dynamically
      aspectRatio: 16 / 9,
      customControls: AdvancedChewieControls(toggleFit: () {
        setState(() {
          videoFit = BoxFit.values[(videoFit.index + 1) % BoxFit.values.length];
        });
      }),
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );

    // Initialize the controller after setting it up
    videoPlayerController.initialize().then((_) {
      setState(() {}); // Trigger a rebuild to update aspect ratio
    });
  }

  @override
  void dispose() {
    super.dispose();
    try {
      chewieController.pause();
      chewieController.dispose();
      videoPlayerController.dispose();
    } catch (_) {}
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        AppLogger.it.logInfo("didPop $didPop");
        AppLogger.it.logInfo("result $result");
        if (chewieController.isFullScreen) {
          chewieController.exitFullScreen();
          Get.showSnackbar(
            GetSnackBar(
              title: '',
              message: 'Tap back again to leave',
              duration: Duration(seconds: 1),
              isDismissible: true,
            ),
          );
        }
        setState(() {
          canPop = true;
        });
      },
      canPop: canPop,
      child: Scaffold(
        body: Container(
          // Ensure the container takes the full screen
          width: double.infinity,
          height: double.infinity,
          child: ValueListenableBuilder(
            valueListenable: videoPlayerController,
            builder: (context, VideoPlayerValue value, child) {
              return AspectRatio(
                aspectRatio: value.hasError
                    ? 16 / 9 // Fallback aspect ratio if error
                    : value.aspectRatio > 0
                        ? value.aspectRatio
                        : 16 / 9, // Dynamic aspect ratio or fallback
                child: Chewie(
                  controller: chewieController,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}