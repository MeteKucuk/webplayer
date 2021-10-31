import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controller/playlist_controller.dart';
import '../modules/player/player.dart';
import 'create_playlist_screen/create_playlist_screen.dart';
import 'home_screen/home_screen.dart';
import 'playlist_screen/playlist_screen.dart';
import 'side_menu/side_menu.dart';
import 'suggestion_screen/suggestion_playlist_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final Player _player = Player();

  final playlistController = PlaylistController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              SideMenu(),
              Obx(() => _buildChild()),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _player.view,
          ),
        ],
      ),
    );
  }

  Widget _buildChild() {
    if (playlistController.selectedPage.value == 5) {
      return const Expanded(
        child: PlayListScreen(),
      );
    } else if (playlistController.selectedPage.value == 3) {
      return const Expanded(child: SuggestionScreen());
    } else if (playlistController.selectedPage.value == 0) {
      return const Expanded(child: HomePage());
    } else if (playlistController.selectedPage.value == 2) {
      return const Expanded(child: CreatePlaylist());
    } else {
      return const CircularProgressIndicator();
    }
  }
}
