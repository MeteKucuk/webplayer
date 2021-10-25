// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:music_player/controller/playlist.dart';

class SuggestionPlaylist_Card extends StatefulWidget {
  final String? title;

  SuggestionPlaylist_Card({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<SuggestionPlaylist_Card> createState() =>
      _SuggestionPlaylist_CardState();
}

class _SuggestionPlaylist_CardState extends State<SuggestionPlaylist_Card> {
  bool isHover = false;

  Offset mousPos = new Offset(0, 0);

  final playlistHeaderController = CurrentTrackController.to;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: MouseRegion(
          onEnter: (e) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (e) {
            setState(() {
              isHover = false;
            });
          },
          onHover: (e) {
            setState(() {
              mousPos += e.delta;
              mousPos *= 0.12;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            // height: 180,
            // width: 160,
            decoration: BoxDecoration(
                gradient: isHover
                    ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff34465D0), Color(0xff67D9C6)],
                        stops: [0, 0.1])
                    : const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff67D9C6), Color(0xff34465D)],
                        stops: [0, 1]),
                borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Image.network('${playlistHeaderController.playlist[1].cover}'),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${widget.title}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}
