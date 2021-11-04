import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";

class ControlButton extends StatefulWidget {
  const ControlButton({
    Key? key,
    required this.icon,
    required this.callback,
    this.disabled = false,
    this.tip,
    this.autoFocus = false,
  }) : super(key: key);

  final String? tip;
  final IconData icon;
  final VoidCallback callback;
  final bool autoFocus;
  final bool disabled;

  @override
  _ControlButtonState createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  Color background = Colors.white70;
  Color bottomBorder = Colors.transparent;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    String? tip =
        widget.disabled ? "Şarkı seçildi, kontroller kullanılamaz" : widget.tip;

    return MouseRegion(
      onEnter: widget.disabled ? null : _handleHover,
      onExit: widget.disabled ? null : _handleHover,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, y, 1),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: bottomBorder,
              width: 2,
            ),
          ),
        ),
        child: IconButton(
          mouseCursor: widget.disabled
              ? SystemMouseCursors.disappearing
              : SystemMouseCursors.click,
          autofocus: widget.autoFocus,
          tooltip: tip,
          onPressed: widget.disabled ? null : widget.callback,
          splashRadius: 1,
          splashColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          icon: Icon(
            widget.icon,
            color: widget.disabled ? Colors.grey.shade800 : background,
          ),
        ),
      ),
    );
  }

  _handleHover(PointerEvent event) {
    setState(() {
      if (event is PointerEnterEvent) {
        background = Colors.white.withOpacity(.8);
        bottomBorder = Colors.white.withOpacity(.9);
        y = -4;
      } else {
        background = Colors.white70;
        bottomBorder = Colors.transparent;
        y = 0;
      }
    });
  }
}
