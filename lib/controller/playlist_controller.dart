import 'package:collection/collection.dart';
import 'package:get/get.dart';

import '../model/playlist.dart';
import '../model/track.dart';
import '../services/data_service.dart';

class PlaylistController extends GetxController {
  static PlaylistController get to => Get.find<PlaylistController>();

  final songList = <Track>[].obs;

  final playlists = <Playlist>[].obs;

  var active = Playlist().obs;

  final duration = 0.obs;

  final selectedPage = 0.obs;

  Future<void> fetchContent(int id) async {
    var playlist = playlists.firstWhereOrNull((element) => element.id == id);

    if (playlist != null && playlist.tracks.isNotEmpty) {
      return;
    }

    var songListContent = await DataServices.fetchPlaylistContent(id);
    if (songListContent != null) {
      songList.value = songListContent;

      //Add content to playlist to use in player module
      active.update((val) {
        val!.tracks = songListContent;
      });

      //Find list in all user lists
      var list = playlists.firstWhere((list) => list.id == id);
      //Add tracks to list
      list.tracks = songListContent;
    }
  }

  Future<void> fetchPlaylist() async {
    var response = await DataServices.fetchPlaylist();
    if (response != null) {
      playlists.value = response;
    }
  }

  Future<void> updateActiveList(Playlist list) async {
    active.value = list;
    fetchContent(list.id!);
  }

  String durationCover(double? hour) {
    int num = hour!.truncate();
    double decimal = hour - num;
    int minute = (decimal * 60).round();

    return "$num saat $minute dakika";
  }

  @override
  void onInit() async {
    await fetchPlaylist();
    super.onInit();
  }
}
