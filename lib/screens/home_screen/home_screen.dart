import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constant.dart';
import 'package:music_player/controller/playlist.dart';
import 'package:music_player/screens/home_screen/widgets/home_screen_card.dart';
import 'package:music_player/widgets/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();
  final playlistController = CurrentTrackController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
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
                          title: '${playlistController.songList[index].name}  ',
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
                  Text(
                    'POP',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
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
                          title: '${playlistController.songList[index].name}  ',
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
                  Text(
                    'POP',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
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
                          title: '${playlistController.songList[index].name}  ',
                        );
                      }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'POP',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
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
                          title: '${playlistController.songList[index].name}  ',
                        );
                      }),
                ),
              ),
            ],
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
