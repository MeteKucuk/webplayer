// To parse this JSON data, do
//
//     final playlistContent = playlistContentFromJson(jsonString);

import 'dart:convert';

List<Track> trackFromJson(String str) =>
    List<Track>.from(json.decode(str).map((x) => Track.fromJson(x)));

String trackToJson(List<Track> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Track {
  Track({
    this.album,
    this.artist,
    this.duration,
    this.explict,
    this.genre,
    this.id,
    this.name,
    this.url,
    this.cover,
    this.order,
  });

  String? album;
  String? artist;
  String? cover;
  int? duration;
  bool? explict;
  String? genre;
  int? id;
  String? name;
  String? url;
  int? order;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        album: json["album"],
        artist: json["artist"],
        duration: json["duration"],
        explict: json["explict"],
        genre: json["genre"],
        id: json["id"],
        name: json["name"],
        url: json["url"],
        cover: json["cover"],
        order: json["order"] ?? 0,
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
        "cover": cover,
        "order": order,
      };
}
