import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import "package:flutter/material.dart";

import '../../../model/track.dart';
import '../custom_player/custom_player.dart';
import 'control_button.dart';

class Controls extends StatefulWidget {
  const Controls({
    Key? key,
    required this.player,
    required this.track,
    required this.onPause,
    this.disabled = false,
  }) : super(key: key);
  final CustomPlayer player;
  final Track track;
  final bool disabled;
  final VoidCallback onPause;

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  IconData _playPause = Icons.play_arrow;
  Duration position = const Duration(milliseconds: 0);
  bool shouldUpdateProgress = true;

  @override
  void didUpdateWidget(covariant Controls oldWidget) {
    if (widget.player.playing) {
      widget.player.playingStream.listen((isPlaying) {
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            _playPause = widget.player.playing ? Icons.pause : Icons.play_arrow;
          });
        });
      });

      widget.player.positionStream.listen((position) {
        if (shouldUpdateProgress) {
          setState(() {
            this.position = position;
          });
        }
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    int? trackDuration = widget.track.duration;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ControlButton(
                    icon: Icons.skip_previous,
                    disabled: widget.disabled,
                    callback: _handlePrevious),
                ControlButton(
                  icon: _playPause,
                  autoFocus: true,
                  callback: _handlePlayPause,
                ),
                ControlButton(
                    icon: Icons.skip_next,
                    disabled: widget.disabled,
                    callback: _handleNext),
              ],
            ),
          ),
          SizedBox(
            height: 15,
            child: Stack(
              children: [
                ProgressBar(
                  progress: position,
                  total: trackDuration != null
                      ? Duration(seconds: trackDuration)
                      : const Duration(milliseconds: 0),
                  timeLabelLocation: TimeLabelLocation.sides,
                  timeLabelTextStyle: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12,
                  ),
                  thumbRadius: 6,
                  onSeek: _handleSeek,
                  onDragUpdate: _handleDrag,
                  onDragStart: _handleDrag,
                ),
                //Block progress bar when controls are disabled
                if (widget.disabled)
                  Container(
                    height: 15,
                    color: Colors.transparent,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext() {
    widget.player.seekToNext();
  }

  void _handlePrevious() {
    widget.player.seekToPrevious();
  }

  void _handlePlayPause() {
    if (widget.track.id != null) {
      if (_playPause == Icons.play_arrow) {
        widget.player.play();
        widget.onPause.call();
      } else {
        widget.player.pause();
      }
    }
  }

  void _handleSeek(duration) async {
    //Allow player position stream updates
    shouldUpdateProgress = true;

    await widget.player.seek(duration);
    setState(() {
      position = duration;
    });
  }

  void _handleDrag(details) {
    //Progress bar should show dragged position on seek, prevent player position stream updates
    shouldUpdateProgress = false;

    setState(() {
      position = details.timeStamp;
    });
  }
}
