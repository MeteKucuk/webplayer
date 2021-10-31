import 'package:flutter/material.dart';

import 'package:music_player/controller/playlist_controller.dart';

class SideMenuIconTab extends StatelessWidget {
  final playlistController = PlaylistController.to;

  SideMenuIconTab({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onTap,
    required this.textStyle,
    required this.colorIcon,
  }) : super(key: key);
  final IconData iconData;
  final String title;

  final VoidCallback onTap;
  final Color colorIcon;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: colorIcon,
        size: 28.0,
      ),
      title: Text(
        title,
        style: textStyle,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}
