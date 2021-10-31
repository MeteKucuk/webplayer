import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../model/playlist.dart';
import '../../model/track.dart';
import 'controller.dart';
import 'custom_player/custom_player.dart';
import 'service/data.dart';
import 'service/file_supplier.dart';
import 'view.dart';

///This class supplies audio player view and it's controls
class Player {
  static final Player _player = Player._init();

  final Data _data = Data();
  final FileSupplier _fileSupplier = FileSupplier();
  final Map<int, ConcatenatingAudioSource> _playlistSource = {};

  int? currentSourceID;

  late View _view;
  late CustomPlayer _customPlayer;
  late Controller _controller;
  late StreamSubscription<PlaybackEvent> playbackStream;

  Player._init() {
    _controller = Get.put(Controller());

    _customPlayer = CustomPlayer();
    _view = View(player: _customPlayer);

    //Log events on player pause
    _controller.isPlaying.listen((val) {
      _data.log(val.toString());
    });

    playbackStream =
        _customPlayer.playbackEventStream.listen((PlaybackEvent event) {
      if (event.currentIndex != null &&
          _customPlayer.audioSource?.sequence[event.currentIndex!].tag !=
              null) {
        _controller.track.value =
            _customPlayer.audioSource?.sequence[event.currentIndex!].tag;
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
    //Update playing track on controller, this causes ui update before play
    _controller.track.value = list.tracks.first;
    await _customPlayer.setListSource(list);
    _customPlayer.play();
  }

  void playFromList(Playlist list, int index) {}
}
