import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/model/playlist.dart';

abstract class CustomPlayer implements AudioPlayer {
  Playlist? listSource;

  @required
  Future<void> setListSource(Playlist list, [int startIndex = 0]);

  ///Plays a track from a list
  @required
  Future<void> playByIndex(Playlist list, int index,
      [FutureOr Function()? callback]);
}
