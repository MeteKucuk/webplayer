import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import "package:flutter/material.dart";
import 'package:music_player/model/track.dart';
import 'package:music_player/modules/player/components/control_button.dart';

class Controls extends StatefulWidget {
  const Controls({
    Key? key,
    this.disabled = false,
    required this.track,
  }) : super(key: key);
  final bool disabled;
  final Track track;

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  IconData _playPause = Icons.pause;
  Duration _duration = const Duration(milliseconds: 0);

  @override
  Widget build(BuildContext context) {
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
                  callback: () {
                    //TODO implement player logic
                  },
                ),
                ControlButton(
                  icon: _playPause,
                  autoFocus: true,
                  callback: () {
                    setState(() {
                      _playPause = _playPause == Icons.play_arrow
                          ? Icons.pause
                          : Icons.play_arrow;
                    });
                    //TODO implement player logic
                  },
                ),
                ControlButton(
                  icon: Icons.skip_next,
                  disabled: widget.disabled,
                  callback: () {
                    //TODO implement player logic
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
            child: Stack(
              children: [
                ProgressBar(
                  progress: _duration,
                  total: Duration(milliseconds: widget.track.duration ?? 0),
                  timeLabelLocation: TimeLabelLocation.sides,
                  timeLabelTextStyle: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12,
                  ),
                  thumbRadius: 6,
                  onSeek: (duration) {
                    //TODO: implement track seek logic
                    setState(() {
                      _duration = duration;
                    });
                  },
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

  void _handleDrag(details) {
    setState(() {
      _duration = details.timeStamp;
    });
  }
}
