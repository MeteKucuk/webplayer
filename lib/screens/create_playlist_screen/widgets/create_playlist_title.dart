import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:music_player/screens/create_playlist_screen/widgets/edit_playlist.dart';

import '../../../constant.dart';

class CreatePlaylistTitle extends StatefulWidget {
  const CreatePlaylistTitle({Key? key}) : super(key: key);

  @override
  _CreatePlaylistTitleState createState() => _CreatePlaylistTitleState();
}

class _CreatePlaylistTitleState extends State<CreatePlaylistTitle> {
  bool isHover = false;

  Offset mousPos = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            MouseRegion(
              onEnter: (e) {
                setState(() {
                  isHover = true;
                });
              },
              onExit: (e) {
                setState(() {
                  isHover = false;
                });
              },
              onHover: (e) {
                setState(() {
                  mousPos += e.delta;
                  mousPos *= 0.12;
                });
              },
              child: GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                      title: '',
                      backgroundColor: Color(0xff34465D),
                      content: EditPlaylist());
                },
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xff36676b).withOpacity(0.3),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff36676b).withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  width: 200,
                  height: 200,
                  child: isHover
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.edit,
                              size: 50,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Fotoğraf Seç',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        )
                      : const Icon(
                          Icons.person,
                          size: 55,
                        ),
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Çalma Listesi',
                    style: Theme.of(context)
                        .textTheme
                        .overline!
                        .copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      '3. Çalma Listem',
                      style: Constant.playlistHeader,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(children: const [
                    Text(
                      '',
                      style: Constant.bodyText1,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ]),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
