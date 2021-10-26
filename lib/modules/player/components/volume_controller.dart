import "package:flutter/material.dart";
import 'package:music_player/modules/player/components/control_button.dart';

class VolumeController extends StatefulWidget {
  const VolumeController({Key? key, this.onChange}) : super(key: key);
  final VolumeCallback? onChange;

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
          disabled: widget.onChange == null ? true : false,
          callback: () {
            setState(() {
              if (!_isMuted) {
                _lastValue = value;
                value = 0;
              } else {
                value = _lastValue;
              }

              _isMuted = !_isMuted;
            });
          },
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
              onChanged: widget.onChange == null ? null : _handleChange,
            ),
          ),
        )
      ],
    );
  }

  _handleChange(double value) {
    widget.onChange!(value);
    setState(() {
      _isMuted = value == 0 ? true : false;
      this.value = value;
    });
  }
}

typedef VolumeCallback = Function(double);
