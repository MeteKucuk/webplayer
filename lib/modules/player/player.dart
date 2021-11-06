import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../model/playlist.dart';
import '../../model/track.dart';
import 'controller.dart';
import 'custom_player/apple_player.dart';
import 'custom_player/common_player.dart';
import 'custom_player/player_interface.dart';
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
  int _previousIndex = 0;

  Player._init() {
    _controller = Get.put(Controller());

    //Assign player according to host platform
    _customPlayer = !kIsWeb &&
            ((defaultTargetPlatform == TargetPlatform.macOS ||
                defaultTargetPlatform == TargetPlatform.iOS))
        ? ApplePlayer()
        : CommonPlayer();

    //Create player view
    _view = View(player: _customPlayer);

    //Log events on player pause
    _controller.isPlaying.listen((val) {
      _data.log(val.toString());
    });

    //Listen index changes and update ui using source tag.
    _customPlayer.sequenceStateStream.listen((state) {
      if (state == null ||
          state.currentSource == null ||
          state.currentSource!.tag == null) {
        return;
      }

      if ((state.currentIndex - _previousIndex).abs() == 1) {
        _controller.track.value = state.currentSource!.tag;
        _previousIndex = state.currentIndex;
      }
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
    await _customPlayer.setListSource(list);

    _customPlayer.play();

    //Update playing track on controller, this causes ui update
    _controller.track.value = list.tracks.first;
  }

  void playFromList(Playlist list, int index) async {
    _previousIndex = index;
    await _customPlayer.playByIndex(list, index, _customPlayer.play);

    //if index is same despite source change just_audio cannot detect source change
    _controller.track.value = list.tracks[index];
  }
}
