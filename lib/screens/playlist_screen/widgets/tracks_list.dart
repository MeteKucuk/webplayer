import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/playlist_controller.dart';
import '../../../model/track.dart';
import '../../../modules/player/player.dart';
import 'playlistLoader.dart';
import 'playlist_emptyscreen.dart';
import 'track_row.dart';

class TracksList extends StatefulWidget {
  const TracksList({Key? key}) : super(key: key);

  @override
  State<TracksList> createState() => _TracksListState();
}

class _TracksListState extends State<TracksList> {
  final _controller = PlaylistController.to;
  bool isHover = false;
  Offset mousPos = const Offset(0, 0);
  final Player _player = Player();
  int _selectedTrackID = -1;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var active = _controller.active.value;

        if (active.tracks.isEmpty && active.length != 0) {
          return const PlaylistLoader();
        } else if (active.length == 0) {
          return const PlaylistEmptyScreen();
        } else {
          return Column(
            children: [
              _createTrackListHeader(),
              SingleChildScrollView(
                child: Column(
                  children: _createTrackRow(active.tracks),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _createTrackListHeader() {
    return Material(
      elevation: 10,
      color: const Color(0xff171717),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 1),
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.horizontal,
          children: const [
            Expanded(
              child: Text("Şarkı"),
            ),
            Expanded(
              child: Text("Şarkıcı"),
            ),
            Expanded(
              child: Text("Albüm"),
            ),
            Expanded(
              child: Text("Süre"),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _createTrackRow(List<Track> tracks) {
    List<Widget> trackRows = [];

    for (var track in tracks) {
      trackRows.add(
        TrackRow(
          track: track,
          isPlaying: _selectedTrackID == track.id,
          callback: () {
            setState(() {
              _selectedTrackID = track.id!;
            });
            _player.playFromList(_controller.active.value, track.order! - 1);
          },
        ),
      );
    }

    trackRows.add(const SizedBox(
      height: 80,
    ));

    return trackRows;
  }
}
