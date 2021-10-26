import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/screens/home.dart';
import 'package:music_player/screens/login_screen/login_screen.dart';
import 'package:music_player/screens/side_menu/side_menu.dart';
import 'package:music_player/screens/suggestion_screen/suggestion_playlist_screen.dart';

import 'controller/playlist.dart';
import 'screens/playlist_screen/playlist_screen.dart';
import 'services/data_service.dart';

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
      home: Home(),
    );
  }
}
