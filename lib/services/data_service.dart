import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_player/controller/playlist_controller.dart';

import '../model/playlist.dart';
import '../model/track.dart';

class DataServices {
  static var client = http.Client();

  static Future<List<Track>?> fetchPlaylistContent(value) async {
    var response = await client.get(Uri.parse(
        'https://qrcodeapp-be484-default-rtdb.firebaseio.com/$value/.json'));

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return trackFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<Playlist>?> fetchPlaylist() async {
    var response = await client.get(Uri.parse(
        'https://qrcodeapp-be484-default-rtdb.firebaseio.com/playlists/.json'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);

      return playListFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<void> postData(dynamic data) async {
    final _controller = PlaylistController.to;

    List allPlaylist = [];

    for (var element in _controller.playlists) {
      allPlaylist.add(element.toJson());
    }
    allPlaylist.add(data);
    var map = jsonEncode(allPlaylist);
    print(map);
    http.Response response = await http.put(
        Uri.parse(
            "https://qrcodeapp-be484-default-rtdb.firebaseio.com/playlists/.json"),
        body: map);

    if (response.statusCode == 201) {
      print(" created");
    } else {
      print(response.statusCode);
    }
  }
}
