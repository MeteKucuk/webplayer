import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';

import 'widgets/playlist_header.dart';
import 'widgets/tracks_list.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  ScrollController? _scrollController;
  bool isHeaderOpen = true;
  double lastOffset = 0;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    // ignore: avoid_print
    // ignore: avoid_print
    _scrollController?.addListener(() {
      print(isHeaderOpen);
      if (_scrollController?.offset == lastOffset) {
        isHeaderOpen = true;
      } else {
        isHeaderOpen = false;
      }
      setState(() {
        lastOffset == _scrollController?.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black54,
        ),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
            children: [
              PlayListHeader(),
              const SizedBox(
                height: 10,
              ),
              const TracksList()
            ],
          ),
        ),
      ),
    );
  }
}
