import 'package:flutter/material.dart';

//Helper class to create Colors for hexcodes
//https://stackoverflow.com/questions/50081213/how-do-i-use-hexadecimal-color-strings-in-flutter

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
