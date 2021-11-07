import 'dart:async';

import 'package:just_audio/just_audio.dart';

import '../../../model/playlist.dart';
import '../../../model/track.dart';

abstract class CustomPlayer implements AudioPlayer {
  Playlist? listSource;

  ///Returns current track as stream
  Stream<Track> get trackStream;

  Future<void> setListSource(Playlist list,
      {int startIndex = 0, FutureOr Function()? callback});

  ///Plays a track from a list
  Future<void> playByIndex(Playlist list, int index,
      [FutureOr Function()? callback]);
}
