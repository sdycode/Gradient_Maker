import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/laignmnet_pair.dart';
import 'package:gradient_maker/main.dart';

enum GradientType { linear, radial, sweep }

class GradProvider with ChangeNotifier {
  updateUi() {
    notifyListeners();
  }

  GradientType gradientType = GradientType.linear;
  TileMode selectedTileMode = TileMode.clamp;
  Alignment linearAlignStart = Alignment(-1, -1);
  Alignment linearAlignEnd = Alignment(1.0, 1.0);
  Offset linearAlignStartPoint = Offset(0, 0);
  Offset linearAlignEndPoint = Offset(0, 0);

  Alignment radialAlignCenter = Alignment(0, 0);
  Alignment radialAlignFocal = Alignment(1, 1);
  Offset radialAlignCenterPoint = Offset(0, 0);
  Offset radialAlignFocalPoint = Offset(0, 0);
  double radialRadius = 0.5;
  double radialFocalRadius = 0.0;

  Alignment sweepAlignCenter = Alignment(0, 0);
  Offset sweepAlignCenterPoint = Offset(0, 0);
  double sweepStartAngle = 0;
  double sweepEndAngle = m.pi * 2;
  bool continuousSweep = false;
  List<ColorStopModel> colorStopModels = [
    ColorStopModel(0.0, "fff8b249", 0),
    ColorStopModel(1.0, "fffee795", 0)
  ];
  AlignmentPair originalAlignmentPair =
      AlignmentPair(Alignment(-1, -1), Alignment(1.0, 1.0));
  updateoriginalAlignmentPair(AlignmentPair alignmentPair) {
    originalAlignmentPair = alignmentPair;
  }

  updateLinearPointForSelectedAlignment(AlignmentPair alignmentPair) {
    linearAlignEnd = alignmentPair.end;
    linearAlignStart = alignmentPair.start;
    // demoBoxSizeW

    linearAlignStartPoint = Offset(
        demoBoxSizeW * (linearAlignStart.x + 1) * 0.5,
        demoBoxSizeH * (linearAlignStart.y + 1) * 0.5);
    linearAlignEndPoint = Offset(demoBoxSizeW * (linearAlignEnd.x + 1) * 0.5,
        demoBoxSizeH * (linearAlignEnd.y + 1) * 0.5);
    log("linerpoint ${linearAlignStartPoint}/${linearAlignEndPoint} / $linearAlignStart / $linearAlignEnd");
  }

  updateAlignPointsForBoxSize(Size boxSize) {
    double bw = boxSize.width;
    double bh = boxSize.height;
    linearAlignEndPoint = Offset(bw, bh);
    log("linerpoint starte ${linearAlignStartPoint}/${linearAlignEndPoint} / $linearAlignStart / $linearAlignEnd");
    radialAlignFocalPoint = Offset(bw * 1, bh * 1);
    colorStopModels[1].left = sliderWidth * sliderActualWidthFactorWithPadding;
    radialAlignCenterPoint = Offset(bw * 0.5, bh * 0.5);
    sweepAlignCenterPoint = Offset(bw * 0.5, bh * 0.5);
    // radialAlignFocalPoint = Offset();
  }

  addNewColorStopModel(ColorStopModel colorStopModel) {
    colorStopModels.add(colorStopModel);
  }

  removeColorStopModel(ColorStopModel colorStopModel) {
    if (colorStopModels.contains(colorStopModel)) {
      colorStopModels.remove(colorStopModel);
    }
  }

  sortColorStopModelsAsPerStopValue(int ind, [bool ascending = true]) {
    // colorStopModels.sort((a, b) {
    //   return a.colorStop.compareTo(b.colorStop);
    // });

    ColorStopModel cmodel = ColorStopModel.copy(colorStopModels[ind]);
    int legthBeforeRemove = colorStopModels.length;
    log("bef remove aftersort $ind /ll ${colorStopModels.length}");
    colorStopModels.removeAt(ind);
//  return;
    log("bef aftersort $ind /ll ${colorStopModels.length} / ${cmodel.colorStop}");
    log("bef aftersort insert $ind / ${colorStopModels.length}");

    // return;
    for (var i = 0; i < colorStopModels.length; i++) {
      if (cmodel.colorStop < colorStopModels[i].colorStop) {
        if (i < ind) {
          colorStopModels.insert(
              i,
              ColorStopModel(
                  cmodel.colorStop,
                  cmodel.hexColorString,
                  sliderWidth *
                      sliderActualWidthFactorWithPadding *
                      cmodel.colorStop));
          // colorStopModels.removeAt(ind + 1);
        } else {
          colorStopModels.insert(
              i,
              ColorStopModel(
                  cmodel.colorStop,
                  cmodel.hexColorString,
                  sliderWidth *
                      sliderActualWidthFactorWithPadding *
                      cmodel.colorStop));
          // colorStopModels.removeAt(ind - 1);
        }
        break;
      }
    }
    if (colorStopModels.length != legthBeforeRemove) {
      colorStopModels.add(cmodel);
    }
    log("aftersort ${colorStopModels.map((e) => e.colorStop)}");
    log("aftersort ${colorStopModels.map((e) => e.hexColorString)}");
    return;
  }

  void resizeColorSliderPositions() {
    for (var i = 0; i < colorStopModels.length; i++) {
      colorStopModels[i].left =
          colorStopModels[i].left * (sliderWidth/preSliderWidth  );
    }
  }
}
