
import 'package:flutter/material.dart';

SliderThemeData sliderThemeData = const SliderThemeData(
    trackHeight: 1,
    rangeThumbShape: RoundRangeSliderThumbShape(
        enabledThumbRadius: 8, disabledThumbRadius: 6, pressedElevation: 8),
    // tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 8),
    // thumbShape:  RoundSliderThumbShape(
    //     enabledThumbRadius: 4, disabledThumbRadius: 6, pressedElevation: 2)
    overlayShape:  RoundSliderThumbShape(
        enabledThumbRadius: 8, disabledThumbRadius: 6, pressedElevation: 8),
    // tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 8),
    thumbShape:  RoundSliderThumbShape(
        enabledThumbRadius: 4, disabledThumbRadius: 6, pressedElevation: 2));
