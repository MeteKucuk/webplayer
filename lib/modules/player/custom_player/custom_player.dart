import 'dart:async';
import 'dart:developer';
import "dart:math" as math;

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../model/playlist.dart';
import '../../../model/track.dart';
import "../utils/extensions.dart";

class CustomPlayer extends AudioPlayer {
  static final CustomPlayer _customPlayer = CustomPlayer._init();
  CustomPlayer._init();
  factory CustomPlayer() => _customPlayer;

  Playlist? _originalSource;
  ConcatenatingAudioSource? _concatedSource;
  StreamSubscription? _sequenceStateStream;
  ValueNotifier<bool> sequenceLockStatus = ValueNotifier(false);

  Future<void> setListSource(Playlist list, [int startIndex = 0]) async {
    //If user press play button for same playlist start playing first song.
    //Do not change sequence.
    if (list.id == _originalSource?.id) {
      //Replace original source with new one with more track.
      //This step is required for lazy loaded playlist from ui.
      _originalSource = _originalSource!.tracks.length != list.tracks.length
          ? list
          : _originalSource;

      await _locateTrack(list.tracks[0]);
      seek(Duration.zero, index: 0);
      return;
    }

    //Keep original sources
    _originalSource = list;

    if (list.tracks.length > 3) {
      int lastIndex = math.min(startIndex + 3, list.tracks.length);

      List<AudioSource> sourceList =
          list.tracks.getRange(startIndex, lastIndex).toSource;

      //Create source using three source
      _concatedSource = ConcatenatingAudioSource(
        children: sourceList,
      );

      _handleSequence();
      await setAudioSource(_concatedSource!, preload: true);
    } else {
      _sequenceStateStream?.cancel();
      _sequenceStateStream = null;
      var source = ConcatenatingAudioSource(children: list.tracks.toSource);

      await setAudioSource(source, preload: true);
    }
  }

  Future<void> prepareForPlayingIndex(Playlist list, int index,
      [Callback? callback]) async {
    //Lock sequence for adding new sources until player starts playing
    sequenceLockStatus.lock;

    //Check if playing from currently loaded list
    if (_originalSource?.id == list.id) {
      int sourceIndex = await _locateTrack(list.tracks[index]);

      //Jump to track
      await seek(Duration.zero, index: sourceIndex);
    } else {
      await setListSource(list, index);
    }

    callback?.call();

    late StreamSubscription<bool> playingStatusStream;

    playingStatusStream = playingStream.listen((isPlaying) {
      //Release sequence, player is playing and all set!
      sequenceLockStatus.release;
      playingStatusStream.cancel();
    });
  }

  ///Insert a track to suitable location in sequence, if track is already in
  ///sequence return it's index.
  ///
  ///Example: assume that there are tracks in sequence with order = 5 and
  /// order = 10 if given track order is 6, this method locates new track between
  /// these two track.
  Future<int> _locateTrack(Track track) async {
    //Check if source added to sequence before
    var sourceIndex =
        audioSource!.sequence.indexWhere((source) => source.tag.id == track.id);

    log("Track founded in sequnce($sourceIndex), seeking.",
        name: "CustomPlayer");

    //Add source if not added
    if (sourceIndex == -1) {
      //Locate to first index if list is not started playing from start
      if (audioSource!.sequence.first.tag.order > track.order) {
        await _concatedSource!.insert(0, track.toSource);
        return 0;
      }

      //Locate to last index if source is further from the all sources.
      if (audioSource!.sequence.last.tag.order < track.order) {
        await _concatedSource!.add(track.toSource);
        return _concatedSource!.length - 1;
      }

      //Find position and locate
      for (int i = 1; i < audioSource!.sequence.length - 1; i++) {
        if (audioSource!.sequence[i].tag.order < track.order &&
            audioSource!.sequence[i + 1].tag.order > track.order) {
          _concatedSource!.insert(i + 1, track.toSource);
          sourceIndex = i + 1;

          break;
        }
      }
    }

    return sourceIndex;
  }

  ///Add tracks to sequence when needed. This method supplies lazy loading feature to player.
  _handleSequence() {
    currentIndexStream.listen((index) async {
      if (_originalSource == null || index == null) return;

      //Player will play specific index, wait to start playing if required
      await sequenceLockStatus.waitUnlock;

      //Check if previous track is in audio source sequence add it if necessary
      await _addPreviousSource(index);

      //Check if next track is in audio source sequence add it if necessary.
      bool isAdded = await _addNextSource(index + 1);
      //Try to add next second track if first one is added successfully. This step speeds up things.
      isAdded ? _addNextSource(index + 2) : {};
    });
  }

  //Order 2 means index 1 is playing, check and add index 2(required index is 2, order = 2)
  Future<bool> _addNextSource(int index) async {
    if (index >= audioSource!.sequence.length) return false;

    int order = audioSource!.sequence[index].tag.order;
    //Last track playing, do not continue adding
    if (order >= _originalSource!.tracks.length) return false;

    bool containsNext = audioSource?.sequence.any(
            (source) => source.tag.id == _originalSource!.tracks[order].id) ??
        true;

    if (!containsNext) {
      await _concatedSource!
          .insert(index + 1, _originalSource!.tracks[order].toSource);

      return true;
    }

    return false;
  }

  //Order 2 means index 1 is playing, check and add index 0(required index is order - 2 = 0)
  Future<void> _addPreviousSource(int index) async {
    int order = audioSource!.sequence[index].tag.order;

    //First track playing, do not continue to adding
    if (order <= 1) return;

    bool containsPrevious = audioSource?.sequence.any((source) =>
            source.tag.id == _originalSource!.tracks[order - 2].id) ??
        true;

    if (!containsPrevious) {
      await _concatedSource!
          .insert(index, _originalSource!.tracks[order - 2].toSource);
    }

    return;
  }
}

typedef Callback = FutureOr Function();
