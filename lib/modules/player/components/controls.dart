import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import "package:flutter/material.dart";
import 'package:music_player/modules/player/components/control_button.dart';

class Controls extends StatefulWidget {
  const Controls({
    Key? key,
    this.disabled = false,
  }) : super(key: key);
  final bool disabled;

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
                    print("prev");
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
                    print("next");
                    //TODO implement player logic
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
            child: ProgressBar(
              progress: _duration,
              buffered: Duration(milliseconds: 100000),
              total: Duration(milliseconds: 100000),
              timeLabelLocation: TimeLabelLocation.sides,
              timeLabelTextStyle: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 12,
              ),
              thumbRadius: 6,
              onSeek: (duration) {
                if (!widget.disabled) {
                  print('User selected a new time: $duration');
                  setState(() {
                    _duration = duration;
                  });
                }
              },
              onDragUpdate: _handleDrag,
              onDragStart: _handleDrag,
            ),
          ),
        ],
      ),
    );
  }

  void _handleDrag(details) {
    if (!widget.disabled) {
      setState(() {
        _duration = details.timeStamp;
      });
    }
  }
}
