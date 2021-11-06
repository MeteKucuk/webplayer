import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/playlist_controller.dart';
import 'screens/home.dart';

void main() async {
  Get.put(PlaylistController());
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb &&
      ((defaultTargetPlatform == TargetPlatform.macOS) ||
          (defaultTargetPlatform == TargetPlatform.windows))) {
    await DesktopWindow.setMinWindowSize(const Size(600, 800));

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
