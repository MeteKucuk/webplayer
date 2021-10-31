// To parse this JSON data, do
//
//     final playList = playListFromJson(jsonString);

import 'dart:convert';

import 'package:music_player/model/track.dart';

List<Playlist> playListFromJson(String str) =>
    List<Playlist>.from(json.decode(str).map((x) => Playlist.fromJson(x)));

String playListToJson(List<Playlist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Playlist {
  Playlist({
    this.cover,
    this.duration,
    this.id,
    this.length,
    this.name,
    this.owner,
    this.tracks = const <Track>[],
  });

  String? cover;
  double? duration;
  int? id;
  int? length;
  String? name;
  Owner? owner;
  List<Track> tracks;

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        cover: json["cover"],
        duration: json["duration"].toDouble(),
        id: json["id"],
        length: json["length"],
        name: json["name"],
        owner: Owner.fromJson(json["owner"]),
        tracks: json['tracks'] ?? <Track>[],
      );

  Map<String, dynamic> toJson() => {
        "cover": cover,
        "duration": duration,
        "id": id,
        "length": length,
        "name": name,
        "owner": owner?.toJson(),
        "tracks": trackToJson(tracks),
      };
}

class Owner {
  Owner({
    this.id,
    this.username,
  });

  int? id;
  String? username;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}
