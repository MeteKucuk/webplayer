import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/model/track.dart';
import 'package:music_player/modules/player/controller.dart';
import 'package:music_player/modules/player/service/data.dart';
import 'package:music_player/modules/player/view.dart';

///This class supplies audio player view and it's controls
class Player {
  static final Player _player = Player._init();

  final Data _data = Data();

  late View _view;
  late AudioPlayer _audioPlayer;
  late Controller _controller;

  Track lastTrack = Track();

  Player._init() {
    _controller = Get.put(Controller());

    _audioPlayer = AudioPlayer();
    _view = View(player: _audioPlayer);

    //Log events on player pause
    _controller.isPlaying.listen((val) {
      _data.log(val.toString());
    });
  }

  factory Player() {
    return _player;
  }

  ///Returns player widget
  View get view => _view;

  ///Changes currently playing track with new one.
  set track(Track track) {
    _audioPlayer.setUrl(track.url!).then((value) async {
      _audioPlayer.play();
      _controller.track.value = track;
    });
  }
}
