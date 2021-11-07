import 'dart:async';

import 'package:just_audio/just_audio.dart';

import '../../../model/playlist.dart';
import '../../../model/track.dart';
import "../utils/extensions.dart";
import 'player_interface.dart';

///Windows, web and android player implemetation
class WindowsPlayer extends AudioPlayer implements CustomPlayer {
  WindowsPlayer() {
    addNativeStream();
  }

  @override
  Playlist? listSource;

  Track? _lastEmited;
  final StreamController<Track> _trackController = StreamController();
  int _currentlyPlayingIndex = 0;

  @override
  get trackStream => _trackController.stream;

  ///Add tracks to stream when just_audio seek to next track
  ///without user interaction
  void addNativeStream() {
    sequenceStateStream.listen((state) {
      if (state != null &&
          state.currentSource != null &&
          state.currentSource!.tag != null) {
        var track = state.currentSource!.tag;

        if (_lastEmited?.id != track.id &&
            (state.currentIndex - _currentlyPlayingIndex).abs() == 1) {
          _trackController.add(track);
          _currentlyPlayingIndex = state.currentIndex;
        }
      }
    });
  }

  @override
  Future<void> seekToNext() async {
    if (listSource == null ||
        _currentlyPlayingIndex == listSource!.tracks.length - 1) {
      return;
    }

    if (audioSource != null) {
      var track = audioSource!.sequence[_currentlyPlayingIndex + 1].tag;

      _trackController.add(track);
      _lastEmited = track;

      await seek(Duration.zero, index: _currentlyPlayingIndex + 1);
      _currentlyPlayingIndex++;
    }
  }

  @override
  Future<void> seekToPrevious() async {
    if (listSource == null || currentIndex == 0) {
      return;
    }

    if (audioSource != null) {
      var track = audioSource!.sequence[_currentlyPlayingIndex - 1].tag;

      _trackController.add(track);
      _lastEmited = track;

      await seek(Duration.zero, index: _currentlyPlayingIndex - 1);
      _currentlyPlayingIndex--;
    }
  }

  @override
  Future<void> playByIndex(Playlist list, int index,
      [Callback? callback]) async {
    int sequenceIndex = 0;

    if (playing) {
      await pause();
    }

    if (listSource?.id == list.id) {
      sequenceIndex = await _seekWhere(list.tracks[index]);
    } else {
      await setListSource(list);
      await seek(Duration.zero, index: index);
      sequenceIndex = index;
    }

    _currentlyPlayingIndex = sequenceIndex;

    callback?.call();
  }

  @override
  Future<void> setListSource(Playlist list,
      {int startIndex = 0, FutureOr<dynamic> Function()? callback}) async {
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

    if (callback != null) {
      callback.call();
      _currentlyPlayingIndex = startIndex;
    }
  }

  ///Returns track index in sequence
  Future<int> _seekWhere(Track track) async {
    int index =
        audioSource!.sequence.indexWhere((source) => source.tag.id == track.id);
    await load();
    await seek(Duration.zero, index: index);

    return index;
  }
}

typedef Callback = FutureOr Function();
