import "package:flutter/material.dart";
import 'package:music_player/model/track.dart';

class TrackRow extends StatefulWidget {
  const TrackRow(
      {Key? key,
      required this.track,
      required this.callback,
      required this.isPlaying})
      : super(key: key);
  final Track track;
  final VoidCallback callback;
  final bool isPlaying;

  @override
  _TrackRowState createState() => _TrackRowState();
}

class _TrackRowState extends State<TrackRow> {
  bool _isEntered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isEntered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isEntered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          widget.callback.call();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height * 0.07,
          child: Material(
            elevation: 20,
            color: _isEntered
                ? Colors.red
                : const Color(0xff171717).withOpacity(.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  widget.isPlaying
                      ? const Expanded(
                          flex: 1,
                          child: Icon(Icons.play_arrow,
                              color: Colors.white, size: 30),
                        )
                      : const Spacer(),
                  Expanded(
                    child: Text(
                      widget.track.name!,
                    ),
                  ),
                  Expanded(
                    child: Text(widget.track.artist!),
                  ),
                  Expanded(
                    child: Text(widget.track.album!),
                  ),
                  Expanded(
                    child: Text(widget.track.duration!.toString()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
