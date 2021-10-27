import 'package:get/get.dart';
import 'package:music_player/model/track.dart';

class Controller extends GetxController {
  //Player data goes here
  var track = Track().obs;
  var duration = 0.0.obs;

  //Player controls goes here
  var disabled = false.obs;
  var isPlaying = false.obs;
}
