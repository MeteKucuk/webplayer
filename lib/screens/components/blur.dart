import 'dart:ui';

import "package:flutter/material.dart";

class Blur extends StatelessWidget {
  const Blur({
    Key? key,
    required this.width,
    required this.height,
    this.color,
  }) : super(key: key);
  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 7.0,
          sigmaY: 7.0,
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? Colors.grey.shade800.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
