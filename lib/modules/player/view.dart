import "package:flutter/material.dart";
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:music_player/model/track.dart';
import 'package:music_player/modules/player/constants.dart';
import 'components/controls.dart';
import 'components/volume_controller.dart';
import 'controller.dart';
import '../../screens/components/blur.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GetX(
      init: Controller(),
      builder: (Controller _controller) {
        var track = _controller.track.value;

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
                              left: 100,
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
                                  disabled: _controller.disabled.value,
                                  track: track,
                                ),
                                VolumeController(
                                  onChange: _controller.disabled.value
                                      ? null
                                      : _handleVolume,
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

  _handleVolume(double value) {
    //TODO implement volume control logic
  }

  Widget _createTrackTexts(Track track) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          track.name ?? "",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.grey.shade400,
          ),
        ),
        Text(
          track.artist ?? "",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
