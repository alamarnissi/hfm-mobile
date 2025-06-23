import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';


// AdvancedChewieControls Widget
class AdvancedChewieControls extends StatefulWidget {
  final void Function()? toggleFit;

  const AdvancedChewieControls({super.key, this.toggleFit});

  @override
  _AdvancedChewieControlsState createState() => _AdvancedChewieControlsState();
}

class _AdvancedChewieControlsState extends State<AdvancedChewieControls> {
  bool _isMuted = false;
  bool _isControlsVisible = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    // Initialize basic state, no dependency on ChewieController yet
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final chewieController = ChewieController.of(context);
    _isMuted = chewieController.videoPlayerController.value.volume == 0;
    _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isControlsVisible = false;
        });
      }
    });
  }

  void _cancelHideTimer() {
    _hideTimer?.cancel();
  }

  void _onTap() {
    setState(() {
      _isControlsVisible = !_isControlsVisible;
    });
    if (_isControlsVisible) {
      _startHideTimer();
    }
  }

  // Helper method to format duration into mm:ss
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  // Get current position as a formatted string
  String getPositionString(VideoPlayerController controller) {
    final position = controller.value.position;
    return _formatDuration(position);
  }

  // Get total duration as a formatted string
  String getTotalDurationString(VideoPlayerController controller) {
    final duration = controller.value.duration ?? Duration.zero;
    return _formatDuration(duration);
  }

  // Toggle mute state
  void toggleMute(VideoPlayerController controller) {
    setState(() {
      _isMuted = !_isMuted;
      controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController.of(context);
    final videoPlayerController = chewieController.videoPlayerController;

    return GestureDetector(
      onTap: _onTap,
      child: Stack(
        children: [
          // Center Play/Pause Button
          Center(
            child: AnimatedOpacity(
              opacity: !_isControlsVisible && chewieController.isPlaying ? 0.0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: GestureDetector(
                onTap: () {
                  _cancelHideTimer();
                  if (chewieController.isPlaying) {
                    chewieController.pause();
                  } else {
                    chewieController.play();
                  }
                  _startHideTimer();
                },
                child: Icon(
                  chewieController.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Control Bar
          AnimatedOpacity(
            opacity: _isControlsVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: Positioned.fill(
              child: Container(
                color: Colors.black26,
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.replay_10, color: Colors.white),
                            onPressed: () {
                              _cancelHideTimer();
                              final currentPosition = videoPlayerController.value.position;
                              chewieController.seekTo(currentPosition - Duration(seconds: 10));
                              _startHideTimer();
                            },
                          ),
                          Expanded(
                            child: VideoProgressIndicator(
                              videoPlayerController,
                              allowScrubbing: true,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              colors: VideoProgressColors(
                                playedColor: Colors.blue,
                                bufferedColor: Colors.white38,
                                backgroundColor: Colors.white24,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.forward_10, color: Colors.white),
                            onPressed: () {
                              _cancelHideTimer();
                              final currentPosition = videoPlayerController.value.position;
                              chewieController.seekTo(currentPosition + Duration(seconds: 10));
                              _startHideTimer();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: videoPlayerController,
                            builder: (context, VideoPlayerValue value, child) {
                              return Text(
                                getPositionString(videoPlayerController),
                                style: TextStyle(color: Colors.white),
                              );
                            },
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  _isMuted ? Icons.volume_off : Icons.volume_up,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _cancelHideTimer();
                                  toggleMute(videoPlayerController);
                                  _startHideTimer();
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  chewieController.isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _cancelHideTimer();
                                  if (chewieController.isFullScreen) {
                                    chewieController.exitFullScreen();
                                  } else {
                                    chewieController.enterFullScreen();
                                  }
                                  _startHideTimer();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.aspect_ratio, color: Colors.white),
                                onPressed: () {
                                  _cancelHideTimer();
                                  widget.toggleFit?.call();
                                  _startHideTimer();
                                },
                              ),
                            ],
                          ),
                          ValueListenableBuilder(
                            valueListenable: videoPlayerController,
                            builder: (context, VideoPlayerValue value, child) {
                              return Text(
                                getTotalDurationString(videoPlayerController),
                                style: TextStyle(color: Colors.white),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          // Back Button (Top Left)
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                _cancelHideTimer();
                if (chewieController.isFullScreen) {
                  chewieController.exitFullScreen();
                } else {
                  Navigator.pop(context);
                }
                _startHideTimer();
              },
            ),
          ),
        ],
      ),
    );
  }
}