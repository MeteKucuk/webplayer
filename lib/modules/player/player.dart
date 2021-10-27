import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/modules/player/controller.dart';
import 'package:music_player/modules/player/view.dart';

///This class supplies audio player view and it's controls.
class Player {
  static final Player _player = Player._init();
  final View _view = const View();
  final audioPlayer = AudioPlayer();
  late Controller controller;

  Player._init() {
    controller = Get.put(Controller());
  }

  factory Player() {
    return _player;
  }

  ///Returns player widget
  View get view => _view;
}
