import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPlaylist extends StatefulWidget {
  @override
  _EditPlaylistState createState() => _EditPlaylistState();
}

class _EditPlaylistState extends State<EditPlaylist> {
  bool isHover = false;

  Offset mousPos = const Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Color(0xff34465D),
      ),
      width: 500,
      child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  ' Playlist Düzenle',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
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
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        width: 200,
                        height: 200,
                        child: GestureDetector(
                          onTap: () async {
                            final result = await FilePicker.platform.pickFiles(
                              allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: [
                                'jpg',
                                'png',
                              ],
                            );
                            if (result != null) {
                              PlatformFile? file = result.files.first;

                              print(file.name);
                              print(file.bytes);
                              print(file.size);
                              // ignore: avoid_print
                              print(file.extension);
                              print(file.path);
                            }
                            if (result == null) {
                              return;
                            }
                          },
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
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Çalma Listesi Adı",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Çalma Listesi Açıklaması",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 52),
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Kaydet'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color(0xff36676b),
                    primary: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
