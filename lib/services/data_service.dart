import 'package:http/http.dart' as http;

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

      return playListFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<void> createPlaylist() async {
    await client.post(
      Uri.parse(
          'https://qrcodeapp-be484-default-rtdb.firebaseio.com/playlists/.json'),
      body: {},
      headers: {},
    );
  }
}
