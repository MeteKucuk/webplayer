import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:music_player/modules/player/player.dart';

import '../controller/playlist.dart';
import '../services/data_service.dart';
import '../widgets/side_menu.dart';
import 'playlist_screen/playlist_screen.dart';
import 'suggestion_screen/suggestion_playlist_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final Player _player = Player();

  final playlistController = CurrentTrackController.to;

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
      return Obx(
        () => FutureBuilder(
          future: DataServices.fetchPlaylistContent(
              playlistController.active.value.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Expanded(
                child: PlayListScreen(),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: const Color(0xff34465D),
                  ),
                );
              } else {
                return Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color(0xff34465D),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Yükleniyor...',
                            style: TextStyle(fontSize: 40),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
          },
        ),
      );
    } else if (playlistController.selectedPage.value == 3) {
      return Expanded(child: SuggestionScreen());
    } else {
      return const CircularProgressIndicator();
    }
  }
}
