import 'package:flutter/material.dart';

class PlaylistEmptyScreen extends StatefulWidget {
  @override
  _PlaylistEmptyScreenState createState() => _PlaylistEmptyScreenState();
}

class _PlaylistEmptyScreenState extends State<PlaylistEmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const Text(
                'Çalma listesine ekleyeceğin şarkıyı seç',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 500,
                height: 40,
                color: Color(0xff36676b).withOpacity(0.4),
                child: Row(
                  children: const [
                    Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Icon(
                          Icons.search,
                        )),
                    SizedBox(
                      width: 11,
                    ),
                    Expanded(
                        child: TextField(
                      cursorColor: Colors.white,
                      autofocus: true,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration.collapsed(
                        hintText: "Şarkı ve Sanatçı Arama",
                        border: InputBorder.none,
                      ),
                    ))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
