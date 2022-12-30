
  import 'package:flutter/material.dart';

getHexColor(String colorString) {
    if (colorString.length == 6) {
      return Color(int.parse("0xff${colorString}"));
    }
    if (colorString.length == 8) {
      return Color(int.parse("0x${colorString}"));
    }
    return Colors.white;
  }
