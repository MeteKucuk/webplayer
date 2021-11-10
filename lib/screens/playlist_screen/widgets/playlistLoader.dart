// ignore_for_file: unused_import, file_names
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class PlaylistLoader extends StatefulWidget {
  const PlaylistLoader({Key? key}) : super(key: key);

  @override
  _PlaylistLoaderState createState() => _PlaylistLoaderState();
}

class _PlaylistLoaderState extends State<PlaylistLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.3,
        child: SpinKitCircle(
            size: 150,
            itemBuilder: (context, int index) {
              return const DecoratedBox(
                  decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff36676b),
              ));
            }),
      ),
    );
  }
}
