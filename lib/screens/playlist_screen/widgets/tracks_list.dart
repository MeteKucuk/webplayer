import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/modules/player/player.dart';

import '../../../controller/playlist.dart';

class TracksList extends StatelessWidget {
  TracksList({Key? key}) : super(key: key);
  final playlistContentController = CurrentTrackController.to;
  final Player _player = Player();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DataTable(
        columns: const [
          DataColumn(label: Text('Şarkıcı')),
          DataColumn(label: Text('Şarkı')),
          DataColumn(label: Text('Albüm ')),
          DataColumn(label: Icon(Icons.access_time)),
        ],
        rows: playlistContentController.songList.map((e) {
          return DataRow(
              cells: [
                DataCell(
                  Text('${e.artist}'),
                ),
                DataCell(
                  Text('${e.name}'),
                ),
                DataCell(
                  Text('${e.album}'),
                ),
                DataCell(
                  Text('${e.duration}'),
                ),
              ],
              onSelectChanged: (selected) {
                _player.track = e;
              });
        }).toList(),
        showCheckboxColumn: false,
      ),
    );
  }
}
