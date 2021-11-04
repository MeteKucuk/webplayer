import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';

import '../../model/playlist.dart';
import '../../model/track.dart';
import 'controller.dart';
import 'custom_player/custom_player.dart';
import 'service/data.dart';
import 'view.dart';

///This class supplies audio player view and it's controls
class Player {
  static final Player _player = Player._init();

  final Data _data = Data();
  /* final Map<int, ConcatenatingAudioSource> _playlistSource = {}; */

  int? currentSourceID;

  late View _view;
  late CustomPlayer _customPlayer;
  late Controller _controller;
  late StreamSubscription<int?> playbackStream;

  Player._init() {
    _controller = Get.put(Controller());

    _customPlayer = CustomPlayer();
    _view = View(player: _customPlayer);

    //Log events on player pause
    _controller.isPlaying.listen((val) {
      _data.log(val.toString());
    });

    //Listen index changes and update ui using source tag.
    playbackStream = _customPlayer.currentIndexStream.listen((currentIndex) {
      if (currentIndex != null &&
          (currentIndex > _customPlayer.sequence!.length - 1 ||
              currentIndex < 0)) {
        return;
      }

      bool condition =
          _customPlayer.audioSource?.sequence[currentIndex!].tag != null;

      if (condition) {
        _controller.track.value =
            _customPlayer.audioSource?.sequence[currentIndex!].tag;
      }
    });
  }

  factory Player() {
    return _player;
  }

  ///Returns player widget
  View get view => _view;

  ///Changes currently playing track with new one.
  set track(Track track) {
    _customPlayer.stop().then((_) async {
      await _customPlayer.setUrl(track.url!);
      _customPlayer.play();
      _controller.track.value = track;
    });
  }

  void startPlayingList(Playlist list) async {
    if (Platform.isWindows && _customPlayer.playing) {
      await _customPlayer.pause();
    }

    await _customPlayer.setListSource(list);
    _customPlayer.play();

    //Update playing track on controller, this causes ui update before play
    _controller.track.value = list.tracks.first;
  }

  void playFromList(Playlist list, int index) async {
    if (index == 0) {
      _controller.track.value = list.tracks[index];
    }

    /*if (Platform.isWindows && _customPlayer.playing) {
      await _customPlayer.pause();
    }*/

    await _customPlayer.prepareForPlayingIndex(list, index, _customPlayer.play);
  }
}
