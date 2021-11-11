import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/model/track.dart';
import 'package:music_player/screens/playlist_screen/widgets/createtrackrow.dart';

import '../../../controller/playlist_controller.dart';
import '../../../modules/player/player.dart';

import 'playlistLoader.dart';
import 'playlist_emptyscreen.dart';

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
                child: CreateTrackRow(),
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

//   List<Widget> _createTrackRow(List<Track> tracks) {
//     List<Widget> trackRows = [];
//
//     for (var track in tracks) {
//       trackRows.add(
//         GestureDetector(
//           onTap: () {
//             _player.playFromList(_controller.active.value, track.order! - 1);
//           },
//           child: Container(
//             margin: const EdgeInsets.only(top: 10),
//             height: MediaQuery.of(context).size.height * 0.07,
//             child: Material(
//               elevation: 20,
//               color: const Color(0xff171717).withOpacity(.9),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
//                 child: Flex(
//                   direction: Axis.horizontal,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         track.name!,
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(track.artist!),
//                     ),
//                     Expanded(
//                       child: Text(track.album!),
//                     ),
//                     Expanded(
//                       child: Text(track.duration!.toString()),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//
//     trackRows.add(const SizedBox(
//       height: 80,
//     ));
//
//     return trackRows;
//   }
// }

}
