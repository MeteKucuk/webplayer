import 'package:http/http.dart' as http;
import 'package:music_player/model/playlist.dart';
import 'package:music_player/model/playlist_content.dart';

class DataServices {
  static var client = http.Client();

  static Future<List<PlaylistContent>?> fetchPlaylistContent(value) async {
    var response = await client.get(Uri.parse(
        'https://qrcodeapp-be484-default-rtdb.firebaseio.com/$value/.json'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return playlistContentFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<PlayList>?> fetchPlaylist() async {
    var response = await client.get(Uri.parse(
        'https://qrcodeapp-be484-default-rtdb.firebaseio.com/playlists/.json'));
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return playListFromJson(jsonString);
    } else {
      return null;
    }
  }
}
