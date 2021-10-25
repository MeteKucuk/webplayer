// To parse this JSON data, do
//
//     final playList = playListFromJson(jsonString);

import 'dart:convert';

List<PlayList> playListFromJson(String str) =>
    List<PlayList>.from(json.decode(str).map((x) => PlayList.fromJson(x)));

String playListToJson(List<PlayList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlayList {
  PlayList({
    this.cover,
    this.duration,
    this.id,
    this.length,
    this.name,
    this.owner,
  });

  String? cover;
  double? duration;
  int? id;
  int? length;
  String? name;
  Owner? owner;

  factory PlayList.fromJson(Map<String, dynamic> json) => PlayList(
        cover: json["cover"],
        duration: json["duration"].toDouble(),
        id: json["id"],
        length: json["length"],
        name: json["name"],
        owner: Owner.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "cover": cover,
        "duration": duration,
        "id": id,
        "length": length,
        "name": name,
        "owner": owner?.toJson(),
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
