import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/services/data_service.dart';
import 'widgets/sidemenu_icontab.dart';

import '../../constant.dart';
import '../../controller/playlist_controller.dart';
import '../../data/data.dart';

class SideMenu extends StatelessWidget {
  final playlistController = PlaylistController.to;
  final dataTest = {
    "cover":
        "https://i.picsum.photos/id/893/200/200.jpg?hmac=MKUqbcyRrvAYoTmgHo74fEI3o9V4CH2kBrvWfmHkr7U",
    "duration": 75.7,
    "length": 0,
    "id": 6,
    "name": "NewONe",
    "owner": {"id": 123541235, "username": "Mete"}
  };

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
                child: Image.network(
                  'https://www.pngall.com/wp-content/uploads/2/Sound-Waves-PNG.png',
                  height: 65.0,
                  width: 200,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          ),
          // ignore: prefer_const_constructors
          Obx(
            () => SideMenuIconTab(
              colorIcon: playlistController.selectedPage.value == 0
                  ? Colors.white
                  : Colors.grey,
              textStyle: playlistController.selectedPage.value == 0
                  ? Constant.bodySelectedText
                  : Constant.bodyText1,
              onTap: () {
                playlistController.selectedPage.value = 0;
              },
              title: yourLibrary[0],
              iconData: Icons.home,
            ),
          ),
          Obx(
            () => SideMenuIconTab(
              colorIcon: playlistController.selectedPage.value == 1
                  ? Colors.white
                  : Colors.grey,
              textStyle: playlistController.selectedPage.value == 1
                  ? Constant.bodySelectedText
                  : Constant.bodyText1,
              onTap: () {
                playlistController.selectedPage.value = 1;
              },
              title: yourLibrary[1],
              iconData: Icons.search,
            ),
          ),
          Obx(
            () => SideMenuIconTab(
              colorIcon: playlistController.selectedPage.value == 2
                  ? Colors.white
                  : Colors.grey,
              textStyle: playlistController.selectedPage.value == 2
                  ? Constant.bodySelectedText
                  : Constant.bodyText1,
              onTap: () {
                Future.delayed(const Duration(seconds: 1), () {
                  playlistController.fetchPlaylist();
                });

                DataServices.postData(dataTest);
                playlistController.selectedPage.value = 2;
              },
              title: yourLibrary[2],
              iconData: Icons.playlist_add,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),

          const LibraryAndPlaylists(),
        ],
      ),
    );
  }
}

class LibraryAndPlaylists extends StatefulWidget {
  const LibraryAndPlaylists({Key? key}) : super(key: key);

  @override
  _LibraryAndPlaylistsState createState() => _LibraryAndPlaylistsState();
}

class _LibraryAndPlaylistsState extends State<LibraryAndPlaylists> {
  final playlistController = PlaylistController.to;
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
                      // ignore: unrelated_type_equality_checks
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
                      style: playlistController.selectedPage.value == 4
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
                  ...playlistController.playlists
                      .map(
                        (e) => Obx(
                          () => ListTile(
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
                            onTap: () async {
                              playlistController.selectedPage.value = 5;
                              await playlistController.updateActiveList(e);
                            },
                          ),
                        ),
                      )
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
