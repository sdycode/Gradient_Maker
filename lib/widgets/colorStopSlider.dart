


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gradient_maker/constants.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/main.dart';
import 'package:provider/provider.dart';

class ColorStopSlider extends StatelessWidget {
  final double tw;
  final double th;

  const ColorStopSlider({Key? key, required this.tw, required this.th})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double actualW = tw * sliderActualWidthFactor;
    double barH = th * 0.7;
    GradProvider gradProvider = Provider.of(context, listen: true);
    log("didff / ${tw - actualW} / ${actualW}/ $tw");
    return Container(
        width: tw,
        height: th,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        color: Colors.amber.shade100.withAlpha(0),
        child: Center(
          child: Container(
            width: actualW,
            height: th,
            child: Stack(clipBehavior: Clip.none, children: [
              Center(
                child: GestureDetector(
                  onTapUp: (d) {
                    // log("onadd $d / ${gradProvider.colorStopModels.length}");
                    double stopValue = d.localPosition.dx / (actualW);
                    gradProvider.colorStopModels.add(ColorStopModel(
                        stopValue, "ffffffff", d.localPosition.dx));
                    // log("bef remove aftersort after add /ll ${gradProvider.colorStopModels.length}");
                    gradProvider.sortColorStopModelsAsPerStopValue(
                        gradProvider.colorStopModels.length - 1);
                    gradProvider.updateUi();
                  },
                  child: Container(
                    width: actualW,
                    height: barH,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: sliderBarColor,
                        borderRadius: BorderRadius.circular(barH * 0.4)),
                  ),
                ),
              ),
              ...List.generate(
                  gradProvider.colorStopModels.length,
                  (i) => ColorStopSliderItemWidget(
                        tw: actualW,
                        th: th,
                        colorStopModel: gradProvider.colorStopModels[i],
                        i: i,
                      ))
            ]),
          ),
        ));
  }
}

class ColorStopSliderItemWidget extends StatelessWidget {
  final double tw;
  final double th;

  final ColorStopModel colorStopModel;
  final int i;
  const ColorStopSliderItemWidget(
      {Key? key,
      required this.tw,
      required this.th,
      required this.colorStopModel,
      required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int colorCode = 0xfffffff;
    double barH = th * 0.5;
    double iconH = th * 0.4;
    // double boxH = th * 0.3;
    double totalItemW = iconH + 18;
    // double left = colorStopModel.colorStop * tw - totalItemW * 0.5;
    GradProvider gradProvider = Provider.of(context, listen: true);
    log("co ${colorStopModel.hexColorString}");
    return Positioned(
      left: colorStopModel.left - totalItemW * 0.5,
      child: Container(
        height: th,
        width: totalItemW,
        child: Column(
          children: [
            SizedBox(
              // height: iconH - 4,
            ),

            GestureDetector(
              onHorizontalDragEnd: (d) {
                gradProvider.sortColorStopModelsAsPerStopValue(i);
                gradProvider.updateUi();
              },
              onHorizontalDragUpdate: (d) {
                double updatedLeft = ((d.delta.dx) / tw);
                // colorStopModel.colorStop * tw - totalItemW * 0.5;
                double stop = colorStopModel.colorStop + (updatedLeft);

                double modfStopValue =
                    (gradProvider.colorStopModels[i].left + d.delta.dx) /
                        (sliderWidth * sliderActualWidthFactorWithPadding);
                log("stopp $stop / $modfStopValue");
                // double updatedPos = colorStopModel.left + d.delta.dx;
                // log("horzd ${d.delta.dx} / $stop / $tw");
                // log("colorr $i  : ${gradProvider.colorStopModels[i].hexColorString} / ${colorStopModel.hexColorString}");
                if (gradProvider.colorStopModels[i].left + d.delta.dx >= 0.0 &&
                    gradProvider.colorStopModels[i].left + d.delta.dx <=
                        sliderWidth * sliderActualWidthFactorWithPadding) {
                  gradProvider.colorStopModels[i] = ColorStopModel(
                      modfStopValue,
                      colorStopModel.hexColorString,
                      gradProvider.colorStopModels[i].left + d.delta.dx);

                  gradProvider.updateUi();
                }
              },
              onTap: () {
                showColorPicker(context, (Color d) {
                  // log("showColorPicker before ${gradProvider.colorStopModels[colorStopModel.colorStop]!.hexColorString}");
                  gradProvider.colorStopModels[i] = ColorStopModel(
                      colorStopModel.colorStop,
                      d.toString().replaceAll(')', '').split('x')[1],
                      colorStopModel.left);
                  // .hexColorString = d.toString();
                  // log("showColorPicker after ${gradProvider.colorStopModels[colorStopModel.colorStop]!.hexColorString}");
                  gradProvider.updateUi();
                },
                    Color(int.parse(
                        "0x${gradProvider.colorStopModels[i].hexColorString}")));
              },
              child: Container(
                height:th,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Color(int.parse("0x${colorStopModel.hexColorString}")),
                ),
                width: 18,
              ),
            ),
            // Container(
            //   height: boxH,
            //   width: boxH,
            //   child: Center(
            //       child: CircleAvatar(
            //     radius: boxH * 0.35,
            //     backgroundColor:
            //         Color(int.parse("0x${colorStopModel.hexColorString}")),
            //   )),
            // ),
          ],
        ),
      ),
    );
  }
}
