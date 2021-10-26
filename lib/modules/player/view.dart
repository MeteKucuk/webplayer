import "package:flutter/material.dart";
import 'package:get/get_state_manager/get_state_manager.dart';
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
                        child: GetX(
                          init: Controller(),
                          builder: (Controller _controller) {
                            return Flex(
                              direction: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _createTrackTexts(),
                                Controls(
                                  disabled: _controller.disabled.value,
                                ),
                                VolumeController(
                                  onChange: _controller.disabled.value
                                      ? null
                                      : _handleVolume,
                                ),
                              ],
                            );
                          },
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
              child: const CircleAvatar(
                radius: 35,
                foregroundImage: NetworkImage(
                    "https://cdns-images.dzcdn.net/images/cover/024b1eb2785058a2cf11a8d52f76a96a/264x264.jpg"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleVolume(double value) {
    //TODO implement volume control logic
  }

  Widget _createTrackTexts() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Whoopty",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.grey.shade400,
          ),
        ),
        Text(
          "CJ",
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
