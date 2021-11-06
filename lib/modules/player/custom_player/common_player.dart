import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:music_player/model/playlist.dart';
import 'package:music_player/model/track.dart';
import 'package:music_player/modules/player/custom_player/player_interface.dart';
import "../utils/extensions.dart";

///Windows, web and android player implemetation
class CommonPlayer extends AudioPlayer implements CustomPlayer {
  @override
  Playlist? listSource;

  @override
  Future<void> playByIndex(Playlist list, int index,
      [Callback? callback]) async {
    if (playing) {
      await pause();
    }

    if (listSource?.id == list.id) {
      await seekWhere(list.tracks[index]);
    } else {
      await setListSource(list);
      await seek(Duration.zero, index: index);
    }

    callback?.call();
  }

  @override
  Future<void> setListSource(Playlist list, [int startIndex = 0]) async {
    if (listSource?.id == list.id) {
      seek(Duration.zero, index: 0);
      return;
    }

    if (playing) {
      await pause();
    }
    listSource = list;

    var source = ConcatenatingAudioSource(
      children: list.tracks.toSource,
    );

    await setAudioSource(source);
  }

  Future<void> seekWhere(Track track) async {
    int index =
        audioSource!.sequence.indexWhere((source) => source.tag.id == track.id);
    await load();
    await seek(Duration.zero, index: index);
  }
}

typedef Callback = FutureOr Function();
