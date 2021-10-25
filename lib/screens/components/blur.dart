import 'dart:ui';

import "package:flutter/material.dart";

class Blur extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Blur({Key? key, required this.width, required this.height}) : super(key: key);
  late final double width;
  late final double height;
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        child: Container(
          width: width,
          height: height,
          decoration:
              BoxDecoration(color: Colors.grey.shade800.withOpacity(0.2)),
        ),
      ),
    );
  }
}
