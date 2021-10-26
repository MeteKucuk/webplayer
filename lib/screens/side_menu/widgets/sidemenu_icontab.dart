import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:music_player/constant.dart';
import 'package:music_player/controller/playlist.dart';

class SideMenuIconTab extends StatelessWidget {
  final playlistController = CurrentTrackController.to;

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
