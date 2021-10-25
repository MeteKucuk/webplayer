import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../../../controller/playlist.dart';

class PlayListHeader extends StatelessWidget {
  final playlistHeaderController = CurrentTrackController.to;

  PlayListHeader({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Row(
            children: [
              Image.network(
                '${playlistHeaderController.active.value.cover}',
                height: 200,
                width: 200.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 16,
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
                    Text(
                      '${playlistHeaderController.active.value.name}',
                      style: Constant.playlistHeader,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(children: [
                      Text(
                        ' ${playlistHeaderController.active.value.owner!.username} ',
                        style: Constant.bodyText1,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        '${playlistHeaderController.active.value.length} Şarkı , ',
                        style: Constant.bodyText1,
                      ),
                      Text(
                        '${playlistHeaderController.durationCover(playlistHeaderController.active.value.duration)}',
                        style: Constant.bodyText1,
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const _PlayListButtons(),
        ],
      );
    });
  }
}

class _PlayListButtons extends StatelessWidget {
  const _PlayListButtons({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Çal'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.green,
            primary: Colors.white,
          ),
        )
      ],
    );
  }
}
