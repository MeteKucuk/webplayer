import 'package:get/get.dart';
import '../model/playlist.dart';
import '../model/playlist_content.dart';
import '../services/data_service.dart';

class CurrentTrackController extends GetxController {
  static CurrentTrackController get to => Get.find<CurrentTrackController>();

  final songList = <PlaylistContent>[].obs;

  final playlist = <PlayList>[].obs;

  var active = PlayList().obs;

  final duration = 0.obs;

  final selectedPage = 0.obs;

  Future fetchContent() async {
    var songListContent =
        await DataServices.fetchPlaylistContent(active.value.id);
    if (songListContent != null) {
      songList.value = songListContent;
    } else {
      return null;
    }
  }

  fetchPlaylist() async {
    var response = await DataServices.fetchPlaylist();
    if (response != null) {
      playlist.value = response;
    } else {
      return null;
    }
  }

  void updatePlaylistId(PlayList value) {
    active.value = value;
  }

  String durationCover(double? hour) {
    int num = hour!.truncate();
    double decimal = hour - num;
    int minute = (decimal * 60).round();

    return "$num saat $minute dakika";
  }

  @override
  void onInit() {
    fetchPlaylist();
    super.onInit();
  }
}
