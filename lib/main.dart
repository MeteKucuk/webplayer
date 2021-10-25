import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/screens/login_screen/login_screen.dart';
import 'package:music_player/screens/suggestion_screen/suggestion_playlist_screen.dart';

import 'controller/playlist.dart';
import 'screens/playlist_screen/playlist_screen.dart';
import 'services/data_service.dart';
import 'widgets/side_menu.dart';

void main() async {
  Get.put(CurrentTrackController());
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb &&
      (Platform.isMacOS ||
          Platform.isAndroid ||
          Platform.isLinux ||
          Platform.isWindows)) {
    await DesktopWindow.setMinWindowSize(Size(600, 800));

    await DesktopWindow.setMinWindowSize(
      const Size(600, 800),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Spotify UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        iconTheme: const IconThemeData().copyWith(color: Colors.white),
      ),
      home: Main(),
    );
  }
}

class Main extends StatelessWidget {
  Main({Key? key}) : super(key: key);
  final playlistController = CurrentTrackController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                SideMenu(),
                Obx(() => _buildChild()),
              ],
            ),
          ),
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: 84,
          )
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
      return CircularProgressIndicator();
    }
  }
}
