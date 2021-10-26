import 'package:flutter/material.dart';
import 'package:music_player/controller/playlist.dart';
import 'package:music_player/screens/suggestion_screen/widgets/Suggestion_PlaylistCard.dart';
import 'package:music_player/widgets/appbar.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  final playlistController = CurrentTrackController.to;
  bool isHover = false;
  Offset mousPos = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.all(
          15,
        ),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff34465D), Color(0xff34465D)],
              stops: [0, 0.3]),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Expanded(
            child: Text(
              'Önerilen Çalma Listeleri',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 7,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: playlistController.songList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(

                            // ignore: dead_code
                            crossAxisCount: 4,
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 50),
                    itemBuilder: (context, index) => SuggestionPlaylist_Card(
                      title: '${playlistController.songList[index].name}  ',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
