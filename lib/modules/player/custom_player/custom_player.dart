import 'dart:async';

import 'package:just_audio/just_audio.dart';

import '../../../model/playlist.dart';
import '../../../model/track.dart';

class CustomPlayer extends AudioPlayer {
  static final CustomPlayer _customPlayer = CustomPlayer._init();
  CustomPlayer._init();
  factory CustomPlayer() => _customPlayer;

  List<Track> _originalSource = [];
  late ConcatenatingAudioSource _concatedSource;
  StreamSubscription? _sequenceStateStream;

  @override
  Future<void> seek(Duration? position, {int? index}) {
    if (index != null && index < _concatedSource.sequence.length - 1) {
      /* _concatedSource.add(audioSource); */
    }

    return super.seek(position, index: index);
  }

  Future<void> setListSource(Playlist playlist) async {
    if (playlist.tracks.length > 2) {
      //Keep original sources
      _originalSource = playlist.tracks;

      List<AudioSource> sourceList = _createSource(playlist.tracks.take(2));

      //Create source using first three source
      _concatedSource = ConcatenatingAudioSource(
        children: sourceList,
      );

      //Listen player sequence to add new sources when required
      _sequenceStateStream ??= sequenceStateStream.listen(
        (state) {
          if (state != null &&
              state.currentIndex == state.sequence.length - 1) {
            _concatedSource.addAll(
              _createSource([_originalSource[state.currentIndex + 1]]),
            );
          }
        },
      );
    } else {
      _sequenceStateStream?.cancel();
      _sequenceStateStream = null;
      _concatedSource =
          ConcatenatingAudioSource(children: _createSource(playlist.tracks));
    }

    await setAudioSource(_concatedSource, preload: false);
  }

  /* @override
  Future<Duration?> setAudioSource(
    AudioSource source, {
    bool preload = true,
    int? initialIndex,
    Duration? initialPosition,
  }) {
     if (source.sequence.length > 3) {
      //Keep original sources
      _originalSource = source.sequence;

      //Create source using first three source
      _concatedSource = ConcatenatingAudioSource(
        children: source.sequence.take(3).toList(),
      );

      //Listen player sequence to add new sources when required
      _sequenceStateStream ??= sequenceStateStream.listen((state) {
        if (state != null && state.currentIndex == state.sequence.length - 1) {
          _concatedSource.add(_originalSource[state.currentIndex + 1]);
        }
      });
    } else {
      _sequenceStateStream?.cancel();
      _sequenceStateStream = null;
      _concatedSource = ConcatenatingAudioSource(children: source.sequence);
    }

    return super.setAudioSource(
      _concatedSource,
      preload: preload,
      initialIndex: initialIndex,
      initialPosition: initialPosition,
    );
  } */

  List<AudioSource> _createSource(Iterable<Track> trackList) {
    return trackList
        .map((e) => AudioSource.uri(Uri.parse(e.url!), tag: e))
        .toList();
  }
}
