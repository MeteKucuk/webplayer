import 'package:flutter/material.dart';
import '../../../controller/playlist_controller.dart';

class HomeScreenCard extends StatefulWidget {
  final String? title;

  const HomeScreenCard({Key? key, this.title}) : super(key: key);
  @override
  _HomeScreenCardState createState() => _HomeScreenCardState();
}

class _HomeScreenCardState extends State<HomeScreenCard> {
  bool isHover = false;

  Offset mousPos = const Offset(0, 0);

  final playlistHeaderController = PlaylistController.to;
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
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            height: 220,
            width: 150,
            decoration: BoxDecoration(
                gradient: isHover
                    ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff36676b), Color(0xff34465D)],
                        stops: [1, 1])
                    : const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0xff34465D), Color(0xff36676b)],
                        stops: [0.1, 1]),
                borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(1000)),
                  child: Image.network(
                      '${playlistHeaderController.playlists[1].cover}')),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Text(
                  '${widget.title}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}
