import 'package:get/get.dart';

import '../../model/playlist.dart';
import '../../model/track.dart';

class Controller extends GetxController {
  //Player data goes here
  var playlist = Playlist().obs;
  var track = Track().obs;

  //Player controls goes here
  var disabled = false.obs;
  var isPlaying = false.obs;
}
