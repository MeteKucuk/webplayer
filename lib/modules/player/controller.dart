import 'package:get/get.dart';
import 'package:music_player/model/track.dart';

class Controller extends GetxController {
  var disabled = false.obs;
  var track = Track().obs;
}
