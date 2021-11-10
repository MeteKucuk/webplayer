import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/screens/playlist_screen/widgets/playlistLoader.dart';
import 'package:music_player/screens/playlist_screen/widgets/playlist_emptyscreen.dart';

import '../../../controller/playlist_controller.dart';
import '../../../modules/player/player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TracksList extends StatefulWidget {
  TracksList({Key? key}) : super(key: key);

  @override
  State<TracksList> createState() => _TracksListState();
}

class _TracksListState extends State<TracksList> {
  final _controller = PlaylistController.to;

  final Player _player = Player();
  final bool selectedIndex = false;
  final int number = 1;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var active = _controller.active.value;

        if (active.tracks.isEmpty && active.length != 0) {
          //Loading ekranını döndür
          return const PlaylistLoader();
        }
        // active.length == 0 ? şarkı içermeyen playlistler için oluşturduğun ekranı döndür.
        else if (active.length == 0) {
          return PlaylistEmptyScreen();
        } else {
          return DataTable(
            columns: const [
              DataColumn(label: Text('Şarkı')),
              DataColumn(label: Text('Şarkıcı')),
              DataColumn(label: Text('Albüm ')),
              DataColumn(label: Icon(Icons.access_time)),
            ],
            rows: active.tracks.mapIndexed((i, e) {
              return DataRow(
                  cells: [
                    DataCell(Row(
                      children: [
                        Icon(Icons.play_arrow_sharp),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('${e.name}'),
                      ],
                    )),
                    DataCell(
                      Text('${e.artist}'),
                    ),
                    DataCell(
                      Text('${e.album}'),
                    ),
                    DataCell(
                      Text(_controller.trackDurationCover(e.duration!)),
                    ),
                  ],
                  onSelectChanged: (selected) {
                    _player.playFromList(active, i);
                  });
            }).toList(),
            showCheckboxColumn: false,
          );
        }
      },
    );
  }
}
