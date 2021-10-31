import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/playlist_controller.dart';
import '../../../modules/player/player.dart';

class TracksList extends StatelessWidget {
  TracksList({Key? key}) : super(key: key);
  final _controller = PlaylistController.to;
  final Player _player = Player();

  //Hoş bir spinner/loader/loading ekranı oluştur
  //Şarkı içermeyen playlistler için bir ekran oluştur
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var active = _controller.active.value;
        if (active.tracks.isEmpty && active.length != 0) {
          //Loading ekranını döndür
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              child: const CircularProgressIndicator(),
            ),
          );
        }
        // active.length == 0 ? şarkı içermeyen playlistler için oluşturduğun ekranı döndür.
        else {
          return DataTable(
            columns: const [
              DataColumn(label: Text('Şarkıcı')),
              DataColumn(label: Text('Şarkı')),
              DataColumn(label: Text('Albüm ')),
              DataColumn(label: Icon(Icons.access_time)),
            ],
            rows: active.tracks.mapIndexed((i, e) {
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
