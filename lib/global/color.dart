import 'package:flutter/material.dart';

class ColorApp {
  static Color colorBlack = const Color(0xFF1a1e21);
  static Color colorBlackFont = const Color(0xFF24282b);
  static Color kPrimaryColor = const Color.fromARGB(255, 196, 143, 31);

  static Color getColorFromName(String nameColor) {
    return Colors.primaries[myColors.indexWhere((element) {
      return element == nameColor;
    })];
  }

  static final myColors = [
    "red",
    "pink",
    "purple",
    "deepPurple",
    "indigo",
    "blue",
    "lightBlue",
    "cyan",
    "teal",
    "green",
    "lightGreen",
    "lime",
    "yellow",
    "amber",
    "orange",
    "deepOrange",
    "brown",
    "blueGrey",
  ];
}
