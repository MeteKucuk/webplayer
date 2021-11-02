import 'package:flutter/material.dart';
import 'widgets/create_playlist_title.dart';
import 'package:music_player/widgets/appbar.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({Key? key}) : super(key: key);

  @override
  _CreatePlaylistState createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  ScrollController? _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff34465D),
          ),
          child: Scrollbar(
            controller: _scrollController,
            isAlwaysShown: true,
            child: SizedBox(
              child: ListView(
                controller: _scrollController,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                          const Color(0xff34465D),
                          const Color(0xff36676b).withOpacity(0.1),
                        ])),
                    height: 60,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                            const Color(0xff34465D),
                            const Color(0xff36676b).withOpacity(0.1),
                          ])),
                      height: 250,
                      child: const CreatePlaylistTitle())
                ],
              ),
            ),
          )),
    );
  }
}
