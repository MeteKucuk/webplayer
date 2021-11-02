import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../../model/track.dart';
import '../../screens/components/blur.dart';
import 'components/controls.dart';
import 'components/volume_controller.dart';
import 'constants/constants.dart';
import 'controller.dart';
import 'custom_player/custom_player.dart';

class View extends StatefulWidget {
  const View({Key? key, required this.player}) : super(key: key);
  final CustomPlayer player;

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  final Controller _controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GetX<Controller>(
      init: _controller,
      builder: (_controller) {
        var track = _controller.track.value;
        bool disabled = _controller.disabled.value;

        return Padding(
          padding: EdgeInsets.only(
            bottom: 10,
            left: width * 0.018,
            right: width * 0.018,
          ),
          child: SizedBox(
            width: width,
            height: 110,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          Blur(
                            width: width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              right: width * 0.07,
                              left: width * 0.1,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _createTrackTexts(track),
                                Controls(
                                  player: widget.player,
                                  disabled: disabled,
                                  track: track,
                                  onPause: _onPause,
                                ),
                                VolumeController(
                                  player: widget.player,
                                  disabled: disabled,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    radius: 35,
                    foregroundImage: NetworkImage(track.cover ?? defaultCover),
                    backgroundImage: const NetworkImage(defaultCover),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///Update player state on contoller,
  ///this is for logging about player state while a song selected
  _onPause() {
    _controller.isPlaying.value = false;
  }

  Widget _createTrackTexts(Track track) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            track.name ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),
          Text(
            track.artist ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
