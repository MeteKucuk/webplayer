import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import '../controller/playlist.dart';
import '../data/data.dart';

class SideMenu extends StatelessWidget {
  final playlistController = CurrentTrackController.to;

  SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff34465D),
      height: double.infinity,
      width: 280.0,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/trt.png',
                  height: 55.0,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          ),
          // ignore: prefer_const_constructors
          SideMenuIconTab(
            onTap: () {
              playlistController.selectedPage.value = 0;
            },
            title: yourLibrary[0],
            iconData: Icons.home,
          ),
          SideMenuIconTab(
            onTap: () {
              playlistController.selectedPage.value = 1;
            },
            title: yourLibrary[1],
            iconData: Icons.search,
          ),
          SideMenuIconTab(
            onTap: () {
              playlistController.selectedPage.value = 2;
            },
            title: yourLibrary[2],
            iconData: Icons.playlist_add,
          ),
          const SizedBox(
            height: 12.0,
          ),

          const SuggestionPlaylist(),
        ],
      ),
    );
  }
}

class SideMenuIconTab extends StatelessWidget {
  const SideMenuIconTab({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.white,
        size: 28.0,
      ),
      title: Text(
        title,
        style: Constant.bodyText1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}

class SuggestionPlaylist extends StatefulWidget {
  const SuggestionPlaylist({Key? key}) : super(key: key);

  @override
  _SuggestionPlaylistState createState() => _SuggestionPlaylistState();
}

class _SuggestionPlaylistState extends State<SuggestionPlaylist> {
  final playlistController = CurrentTrackController.to;
  ScrollController? _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    'Kitaplığın',
                    style: Constant.headline4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Obx(
                  () => ListTile(
                    dense: true,
                    title: Text(
                      yourLibrary[3],
                      style: playlistController.selectedPage == 3
                          ? const TextStyle(
                              color: Colors.white,
                            )
                          : const TextStyle(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      playlistController.selectedPage.value = 3;
                    },
                  ),
                ),
                Obx(
                  () => ListTile(
                    dense: true,
                    title: Text(
                      yourLibrary[4],
                      style: playlistController.selectedPage == 4
                          ? const TextStyle(
                              color: Colors.white,
                            )
                          : const TextStyle(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      playlistController.selectedPage.value = 4;
                    },
                  ),
                ),
              ],
            ),
            Obx(
              () => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'Playlistlerin',
                      style: Constant.headline4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ...playlistController.playlist
                      .map((e) => Obx(() => ListTile(
                            dense: true,
                            title: Text(
                              '${e.name}',
                              style: TextStyle(
                                  color: e.id ==
                                              playlistController
                                                  .active.value.id &&
                                          playlistController
                                                  .selectedPage.value ==
                                              5
                                      ? Colors.white
                                      : Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              playlistController.selectedPage.value = 5;
                              playlistController.updatePlaylistId(e);
                              playlistController.fetchContent();
                              playlistController.fetchPlaylist();
                            },
                          )))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
