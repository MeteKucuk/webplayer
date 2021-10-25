// To parse this JSON data, do
//
//     final album = albumFromJson(jsonString);

import 'dart:convert';

List<Album> albumFromJson(String str) =>
    List<Album>.from(json.decode(str).map((x) => Album.fromJson(x)));

String albumToJson(List<Album> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Album {
  Album({
    this.album,
    this.artist,
    this.duration,
    this.genre,
    this.id,
    this.length,
    this.url,
  });

  String? album;
  String? artist;
  double? duration;
  String? genre;
  int? id;
  int? length;
  String? url;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        album: json["album"],
        artist: json["artist"],
        duration: json["duration"].toDouble(),
        genre: json["genre"],
        id: json["id"],
        length: json["length"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "album": album,
        "artist": artist,
        "duration": duration,
        "genre": genre,
        "id": id,
        "length": length,
        "url": url,
      };
}
