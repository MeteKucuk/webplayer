// ignore_for_file: unnecessary_this

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/model/track.dart';

extension TrackSource on Track {
  get toSource => AudioSource.uri(Uri.parse(this.url!), tag: this);
}

extension TrackListSource on Iterable<Track> {
  get toSource =>
      this.map((e) => AudioSource.uri(Uri.parse(e.url!), tag: e)).toList();
}

//When preparing player to play a specific index in a list, sequence should lock to
//add new tracks until player start. Otherwise index changing.
extension SequenceLock on ValueNotifier {
  Future<void> get waitUnlock async {
    Completer<void> _completer = Completer();
    if (this.value) {
      log("Operation not allowed, waiting for releasing", name: "CustomPlayer");
      late VoidCallback callback;

      callback = () {
        if (!this.value) {
          _completer.complete();
          this.removeListener(callback);
        }
      };

      this.addListener(callback);
    } else {
      log("Sequence available, adding new source", name: "CustomPlayer");
      _completer.complete();
    }

    return _completer.future;
  }

  ///Prevents adding new sources to sequence
  get lock {
    log("Sequence locked, preventing operations", name: "CustomPlayer");
    this.value = true;
  }

  ///Allows adding new sources to sequence.
  get release {
    log("Sequence released", name: "CustomPlayer");
    this.value = false;
  }
}
