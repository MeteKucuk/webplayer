import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controller/playlist_controller.dart';
import '../modules/player/player.dart';
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
          Obx(
            () => Row(
              children: <Widget>[
                SideMenu(),
                _buildChild(),
              ],
            ),
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
    } else {
      return const CircularProgressIndicator();
    }
  }
}
