import 'package:flutter/material.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:music_player/model/track.dart';
import 'package:music_player/modules/player/player.dart';

class CreateTrackRow extends StatefulWidget {
  @override
  _CreateTrackRowState createState() => _CreateTrackRowState();
}

class _CreateTrackRowState extends State<CreateTrackRow> {
  final _controller = PlaylistController.to;
  final Player _player = Player();

  List<Widget> trackList() {
    List<Widget> _track = [];

    for (var tracks in _controller.active.value.tracks) {
      var newItem = Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Text("${tracks.name}"),
          ),
          Expanded(
            child: Text("${tracks.id}"),
          ),
          Expanded(
            child: Text("${tracks.artist}"),
          ),
          Expanded(
            child: Text(tracks.duration.toString()),
          ),
        ],
      );
      _track.add(newItem);
    }
    return _track;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _player.playFromList(
            _controller.active.value, _controller.active.value.id!);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.07,
        child: Material(
          elevation: 20,
          color: const Color(0xff171717).withOpacity(.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
            child: Flex(
              direction: Axis.horizontal,
              children: trackList(),
            ),
          ),
        ),
      ),
    );
  }
}
