
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';

class LandscapePlayerControls extends StatelessWidget {
  const LandscapePlayerControls(
      {super.key, this.iconSize = 20, this.fontSize = 12,this.toggleFit});
  final double iconSize;
  final double fontSize;
final void Function()?  toggleFit;
  @override
  Widget build(BuildContext context) {
    FlickControlManager controlManager =
    Provider.of<FlickControlManager>(context);
    FlickVideoManager videoManager = Provider.of<FlickVideoManager>(context);


    return Stack(
      children: <Widget>[
        FlickShowControlsAction(
          child: FlickSeekVideoAction(
            child: Center(
              child: FlickVideoBuffer(
                child: FlickAutoHideChild(
                  showIfVideoNotInitialized: false,
                  child: LandscapePlayToggle(),
                ),
              ),

            ),
          ),

        ),

        Positioned.fill(
          child: FlickAutoHideChild(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlickPlayToggle(
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlickCurrentPosition(
                        fontSize: fontSize,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: FlickVideoProgressBar(
                          flickProgressBarSettings: FlickProgressBarSettings(
                            height: 10,
                            handleRadius: 10,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8,
                            ),
                            backgroundColor: Colors.white24,
                            bufferedColor: Colors.white38,
                            getPlayedPaint: (
                                {double? handleRadius,
                                  double? height,
                                  double? playedPart,
                                  double? width}) {
                              return Paint()
                                ..shader = LinearGradient(colors: [
                                  Color.fromRGBO(108, 165, 242, 1),
                                  Color.fromRGBO(97, 104, 236, 1)
                                ], stops: [
                                  0.0,
                                  0.5
                                ]).createShader(
                                  Rect.fromPoints(
                                    Offset(0, 0),
                                    Offset(width!, 0),
                                  ),
                                );
                            },
                            getHandlePaint: (
                                {double? handleRadius,
                                  double? height,
                                  double? playedPart,
                                  double? width}) {
                              return Paint()
                                ..shader = RadialGradient(
                                  colors: [
                                    Color.fromRGBO(97, 104, 236, 1),
                                    Color.fromRGBO(97, 104, 236, 1),
                                    Colors.white,
                                  ],
                                  stops: [0.0, 0.4, 0.5],
                                  radius: 0.4,
                                ).createShader(
                                  Rect.fromCircle(
                                    center: Offset(playedPart!, height! / 2),
                                    radius: handleRadius!,
                                  ),
                                );
                            },
                          ),
                        ),
                      ),
                      FlickTotalDuration(
                        fontSize: fontSize,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlickSoundToggle(
                        size: 20,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          right: 20,
          top: 10,
          child: GestureDetector(
            onTap: () {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: SystemUiOverlay.values);
              SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp]);
              Navigator.pop(context);
            },
            child: Icon(
              Icons.cancel,
              size: 30,
            ),
          ),
        ),

        Positioned(
          right: 70,
          top: 10,
          child: GestureDetector(
            onTap: toggleFit,
            child: Icon(
              Icons.fullscreen_outlined ,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}




class LandscapePlayToggle extends StatelessWidget {
  const LandscapePlayToggle({super.key});

  @override
  Widget build(BuildContext context) {
    FlickControlManager controlManager =
    Provider.of<FlickControlManager>(context);
    FlickVideoManager videoManager = Provider.of<FlickVideoManager>(context);

    double size = 50;
    Color color = Colors.white;

    Widget playWidget = Icon(
      Icons.play_arrow,
      size: size,
      color: color,
    );
    Widget pauseWidget = Icon(
      Icons.pause,
      size: size,
      color: color,
    );
    Widget replayWidget = Icon(
      Icons.replay,
      size: size,
      color: color,
    );

    Widget child = videoManager.isVideoEnded
        ? replayWidget
        : videoManager.isPlaying
        ? pauseWidget
        : playWidget;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        splashColor: Color.fromRGBO(108, 165, 242, 0.5),
        key: key,
        onTap: () {
          videoManager.isVideoEnded
              ? controlManager.replay()
              : controlManager.togglePlay();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.all(10),
          child: child,
        ),
      ),
    );
  }
}