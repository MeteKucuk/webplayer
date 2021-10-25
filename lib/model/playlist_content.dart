// To parse this JSON data, do
//
//     final playlistContent = playlistContentFromJson(jsonString);

import 'dart:convert';

List<PlaylistContent> playlistContentFromJson(String str) =>
    List<PlaylistContent>.from(
        json.decode(str).map((x) => PlaylistContent.fromJson(x)));

String playlistContentToJson(List<PlaylistContent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaylistContent {
  PlaylistContent({
    this.album,
    this.artist,
    this.duration,
    this.explict,
    this.genre,
    this.id,
    this.name,
    this.url,
  });

  String? album;
  String? artist;
  int? duration;
  bool? explict;
  String? genre;
  int? id;
  String? name;
  String? url;

  factory PlaylistContent.fromJson(Map<String, dynamic> json) =>
      PlaylistContent(
        album: json["album"],
        artist: json["artist"],
        duration: json["duration"],
        explict: json["explict"],
        genre: json["genre"],
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "album": album,
        "artist": artist,
        "duration": duration,
        "explict": explict,
        "genre": genre,
        "id": id,
        "name": name,
        "url": url,
      };
}
