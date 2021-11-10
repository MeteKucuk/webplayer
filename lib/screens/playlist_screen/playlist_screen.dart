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
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
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
          color: Color(0xff34465D),
        ),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
            children: [PlayListHeader(), TracksList()],
          ),
        ),
      ),
    );
  }
}
