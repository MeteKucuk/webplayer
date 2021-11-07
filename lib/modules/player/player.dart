import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../model/playlist.dart';
import '../../model/track.dart';
import 'controller.dart';
import 'custom_player/apple_player.dart';
import 'custom_player/common_player.dart';
import 'custom_player/player_interface.dart';
import 'custom_player/windows_player.dart';
import 'service/data.dart';
import 'view.dart';

///This class supplies audio player view and it's controls
class Player {
  static final Player _player = Player._init();
  factory Player() => _player;

  final Data _data = Data();

  late View _view;
  late CustomPlayer _customPlayer;
  late Controller _controller;

  Player._init() {
    _controller = Get.put(Controller());

    _customPlayer = _getPlayer();

    //Create player view
    _view = View(player: _customPlayer);

    //Log events on player pause
    _controller.isPlaying.listen((val) {
      _data.log(val.toString());
    });

    //Listen index changes and update ui using source tag.
    _customPlayer.trackStream.listen((track) {
      _controller.track.value = track;
    });
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
    await _customPlayer.setListSource(list, callback: _customPlayer.play);

    //Update playing track on controller, this causes ui update
    _controller.track.value = list.tracks.first;
  }

  void playFromList(Playlist list, int index) async {
    await _customPlayer.playByIndex(list, index, _customPlayer.play);

    //if index is same despite source change just_audio cannot detect source change
    _controller.track.value = list.tracks[index];
  }

  ///Returns player according to the host platform
  CustomPlayer _getPlayer() {
    CustomPlayer _player;

    if (!kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS) {
        _player = ApplePlayer();
      } else if (defaultTargetPlatform == TargetPlatform.windows) {
        _player = WindowsPlayer();
      } else {
        _player = CommonPlayer();
      }
    } else {
      _player = CommonPlayer();
    }

    return _player;
  }
}
