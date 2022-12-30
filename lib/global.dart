import 'package:flutter/services.dart';

int selectedLinearGradOption = 0;
int selectedBlendModeOption = 13;
double topbarH = 40;
List<List<String>> colorsPairs = [
  ["ffee9ca7", "ffffdde1"],
  ["ff2193b0", "ff6dd5ed"],
  ["ffFBD786", "fff7797d"],
  ["ffc471ed", "fff7797d"],
  ["ff373B44", "ff4286f4"],
  ["ff6DD5FA", "ffFFFFFF"],
  ["ff2980B9", "ff6DD5FA"],
  ["ffFF0099", "ff493240"],
  ["ff1f4037", "ff99f2c8"],
  ["fff12711", "fff5af19"],
  ["ff005AA7", "ffFFFDE4"],
  ["ffa8c0ff", "ff3f2b96"],
  ["fffffbd5", "ffb20a2c"]
];

Uint8List? defaultImageUint8List;
Uint8List? pickedImageUint8List;