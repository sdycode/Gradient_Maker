


import 'package:flutter/material.dart';
import 'package:gradient_maker/aignmnet_pair.dart';

const Color sliderBarColor = Color.fromARGB(255, 30, 16, 85);

class ColorStopModel {
  double colorStop;
  String hexColorString;
  double left;
  ColorStopModel(this.colorStop, this.hexColorString, this.left);
  ColorStopModel.withStopValue(this.colorStop,
      [this.hexColorString = "ffffffff", this.left = 0]);
  factory ColorStopModel.copy(ColorStopModel model) {
    return ColorStopModel(model.colorStop, model.hexColorString, model.left);
  }
}
List<AlignmentPair> alignmentPairList = [];