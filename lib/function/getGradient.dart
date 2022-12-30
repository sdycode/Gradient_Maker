

  import 'package:flutter/material.dart';
import 'package:gradient_maker/gradprovder.dart';

Gradient getGradientForTileMode(TileMode tileMode, int gradIndex,GradProvider gradProvider) {
    // log("tilemode $tileMode / grdi $gradIndex");

    return [
      LinearGradient(
        colors: [
          ...gradProvider.colorStopModels
              .map((e) => Color(int.parse("0x${e.hexColorString}")))
        ],
        begin: gradProvider.linearAlignStart,
        end: gradProvider.linearAlignEnd,
        stops: [...gradProvider.colorStopModels.map((e) => e.colorStop)],
        tileMode: tileMode,
      ),
      RadialGradient(
          focalRadius: gradProvider.radialFocalRadius,
          focal: gradProvider.radialAlignFocal,
          center: gradProvider.radialAlignCenter,
          colors: [
            ...gradProvider.colorStopModels
                .map((e) => Color(int.parse("0x${e.hexColorString}")))
          ],
          radius: gradProvider.radialRadius,
          tileMode: tileMode),
      SweepGradient(
        center: gradProvider.sweepAlignCenter,
        startAngle: gradProvider.sweepStartAngle,
        endAngle: gradProvider.sweepEndAngle,
        colors: (gradProvider.continuousSweep)
            ? [
                ...gradProvider.colorStopModels
                    .map((e) => Color(int.parse("0x${e.hexColorString}"))),
                Color(int.parse(
                    "0x${gradProvider.colorStopModels.first.hexColorString}"))
              ]
            : [
                ...gradProvider.colorStopModels
                    .map((e) => Color(int.parse("0x${e.hexColorString}"))),
              ],
        stops: (gradProvider.continuousSweep)
            ? [
                0.0,
                ...gradProvider.colorStopModels
                    .sublist(1, gradProvider.colorStopModels.length - 1)
                    .map((e) {
                  return e.colorStop;
                }),
                gradProvider.colorStopModels.last.colorStop,
                1.0
              ]
            : [
                ...gradProvider.colorStopModels.map((e) => e.colorStop),
              ],
        tileMode: tileMode,
      ),
    ][gradIndex];
  }
