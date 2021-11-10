import 'package:flutter/material.dart';
import '../../controller/playlist_controller.dart';
import 'widgets/Suggestion_PlaylistCard.dart';
import '../../widgets/appbar.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  final playlistController = PlaylistController.to;
  bool isHover = false;
  Offset mousPos = const Offset(0, 0);

  ScrollController? _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController(initialScrollOffset: 50.0);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Scrollbar(
        isAlwaysShown: true,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff34465D), Color(0xff34465D)],
                stops: [0, 0.3]),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Önerilen Çalma Listeleri',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Container(
                    child: GridView.builder(
                      itemCount: playlistController.songList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                              // ignore: dead_code
                              crossAxisCount: 4,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: 3,
                              crossAxisSpacing: 5),
                      itemBuilder: (context, index) => SuggestionPlaylist_Card(
                        title: '${playlistController.songList[index].name}  ',
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
