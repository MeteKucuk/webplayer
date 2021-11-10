import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../controller/playlist_controller.dart';
import 'widgets/home_screen_card.dart';
import '../../widgets/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();
  ScrollController? _scrollController;
  final playlistController = PlaylistController.to;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff34465D),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'POP',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Hepsini Gör',
                          style: Constant.bodySelectedText,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200.0,
                  alignment: Alignment.center,
                  child: ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: ListView.builder(
                        itemCount: playlistController.songList.length,
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeScreenCard(
                            title:
                                '${playlistController.songList[index].name}  ',
                          );
                        }),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'POP',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Hepsini Gör',
                          style: Constant.bodySelectedText,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  // Another fixed-height child.
                  // Green
                  height: 200.0,
                  alignment: Alignment.center,
                  child: ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: ListView.builder(
                        itemCount: playlistController.songList.length,
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeScreenCard(
                            title:
                                '${playlistController.songList[index].name}  ',
                          );
                        }),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'POP',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Hepsini Gör',
                          style: Constant.bodySelectedText,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  // Another fixed-height child.
                  // Green
                  height: 200.0,
                  alignment: Alignment.center,
                  child: ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: ListView.builder(
                        itemCount: playlistController.songList.length,
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeScreenCard(
                            title:
                                '${playlistController.songList[index].name}  ',
                          );
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'POP',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Hepsini Gör',
                          style: Constant.bodySelectedText,
                        )),
                  ],
                ),
                Container(
                  // Another fixed-height child.
                  // Green
                  height: 200.0,
                  alignment: Alignment.center,
                  child: ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: ListView.builder(
                        itemCount: playlistController.songList.length,
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeScreenCard(
                            title:
                                '${playlistController.songList[index].name}  ',
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
