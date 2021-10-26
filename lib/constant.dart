import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names

class Constant {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }

  static const headline2 = TextStyle(
    color: Colors.white,
    fontSize: 32.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
  );
  static const playlistHeader = TextStyle(
    color: Colors.white,
    fontSize: 45.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
  );

  static final headline4 = TextStyle(
    fontSize: 18.0,
    fontFamily: 'Montserrat',
    color: Colors.grey[300],
    fontWeight: FontWeight.w500,
    letterSpacing: 2.0,
  );
  static final bodyText1 = TextStyle(
    color: Colors.grey,
    fontSize: 14.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );
  static final bodySelectedText = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontFamily: 'Montserrat',
    letterSpacing: 1.0,
  );
  static final bodyText2 = TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.grey[300],
    letterSpacing: 1.0,
  );
}
