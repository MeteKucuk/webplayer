import "package:flutter/material.dart";
import 'package:just_audio/just_audio.dart';
import 'package:music_player/modules/player/components/control_button.dart';

class VolumeController extends StatefulWidget {
  const VolumeController({
    Key? key,
    required this.player,
    required this.disabled,
  }) : super(key: key);

  final AudioPlayer player;
  final bool disabled;

  @override
  _VolumeControllerState createState() => _VolumeControllerState();
}

class _VolumeControllerState extends State<VolumeController> {
  double value = 100;
  double _lastValue = 0;
  bool _isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ControlButton(
          icon: _isMuted ? Icons.volume_off : Icons.volume_up,
          disabled: widget.disabled ? true : false,
          callback: _handleMuteButton,
          tip: _isMuted ? "Sesi Aç" : "Sesi Kapat",
        ),
        Container(
          constraints: const BoxConstraints(
            minWidth: 150,
          ),
          width: MediaQuery.of(context).size.width * 0.12,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackShape: const RoundedRectSliderTrackShape(),
              trackHeight: 3.0,
              thumbColor: Colors.blueGrey,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
              activeTickMarkColor: Colors.transparent,
              inactiveTickMarkColor: Colors.transparent,
              disabledActiveTickMarkColor: Colors.transparent,
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 100,
              divisions: 20,
              label: value.round().toString(),
              onChanged: widget.disabled ? null : _handleChange,
            ),
          ),
        )
      ],
    );
  }

  _handleMuteButton() {
    setState(() {
      if (!_isMuted) {
        _lastValue = value;
        value = 0;
      } else {
        value = _lastValue;
      }

      _isMuted = !_isMuted;
    });

    widget.player.setVolume(value / 100.0);
  }

  _handleChange(double value) async {
    await widget.player.setVolume(value / 100.0);

    setState(() {
      _isMuted = value == 0 ? true : false;
      this.value = value;
    });
  }
}

typedef VolumeCallback = Function(double);
