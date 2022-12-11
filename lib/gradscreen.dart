import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gradient_maker/constants.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/laignmnet_pair.dart';
import 'package:gradient_maker/main.dart';
import 'package:provider/provider.dart';

List<AlignmentPair> alignmentPairList = [];

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

class GradientCreator extends StatefulWidget {
  const GradientCreator({Key? key}) : super(key: key);

  @override
  State<GradientCreator> createState() => _GradientCreatorState();
}

class _GradientCreatorState extends State<GradientCreator> {
  late GradProvider gradProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("ccc after init $colorListBoxW");
    GradProvider grad = Provider.of(context, listen: false);
    log("demoo beff inits ${demoBoxSizeW} / $demoBoxSizeH /");

    grad.updateAlignPointsForBoxSize(Size(demoBoxSizeW, demoBoxSizeH));
  }

  List<Color> pointColors = const [Colors.red, Color.fromARGB(255, 38, 10, 74)];
  ScrollController blendmodeslListCOntroller = ScrollController();
  ScrollController linearGradOptionsController = ScrollController();
  double topbarH = 40;
   final scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    gradProvider = Provider.of(context, listen: true);
    double left = demoBoxSizeW + pointRad * 2 + textBoxSizeW + w * 0.04;
    double right = tileModeW * 4 + 4 * (10 * 2);
    // log("what is diff LEFT ${left} / RIGHT ${right} / ${w} / ${(left + right) / w}");

    double top = h * 0.05 + demoBoxSizeH + pointRad * 2;
    double btm = alignOptionsBoxH + h * 0.08;
    // log("what is diff TOP top ${top} / btm ${btm} / ${h} / ${(top + btm) / h}");
    createAlignmentPairlist();

    return Scaffold(
      key: scaffoldKey,
        backgroundColor: Colors.black,
        body: Column(
          children: [
            _topBar(),
            Container(
              height: h - topbarH,
              child: Stack(fit: StackFit.expand, children: [
                _gradientDemo(),
                if ((top + btm) / h < 0.89) _colorSliderBar(),
                if ((left + right) / w < 0.94) _gradientTypesList(),
                // colorListBox()
              ]),
            ),
          ],
        ));
  }

  Color pickedColor = Colors.amber;

  _colorSliderBar() {
    return Positioned(
        bottom: 0,
        left: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            blendModesinRow(),
           const SizedBox(height: 8,),
            if (gradProvider.gradientType == GradientType.radial)
              _radiusSliders(),
            if (gradProvider.gradientType == GradientType.sweep)
              _sweepAngleSliders(),
            if (gradProvider.gradientType == GradientType.sweep) _sweepData(),
            if (gradProvider.gradientType == GradientType.linear)
              lineaGradAlignmentOptions(),
            ColorStopSlider(tw: sliderWidth, th: h * 0.08)
          ],
        ));
  }

  blendModesinRow() {
    double blendModeBoxItemH = alignOptionsBoxH + 30;
    return Container(
        // width: alignOptionsBoxW,
        height: blendModeBoxItemH,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            scrollButton(
              "leftblend",
            ),
            Container(
              width: alignOptionsBoxW - 100,
              // color: Colors.green,
              height: blendModeBoxItemH,
              child: RawScrollbar(
                trackColor: Colors.amber.shade100.withAlpha(180),
                controller: blendmodeslListCOntroller,
                radius: Radius.circular(4),
                // thumbVisibility: true,
                // trackVisibility: true,
               
                thickness: 10,
                scrollbarOrientation:ScrollbarOrientation.bottom,
                child: ListView.builder(
                    itemCount: BlendMode.values.length,
                    controller: blendmodeslListCOntroller,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, i) {
                      return
                      false?
                      Container(
                        width: 40,
                        height: 40,
                        color: Colors.primaries[i% Colors.primaries.length],
                      ):
                       blendModeBoxItem(i);
                    }),
              ),
            ),
            scrollButton(
              "rightblend",
            ),
          ],
        ));
  }

  _sweepData() {
    return Container(
        width: sliderWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Start - End Angles",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  gradProvider.continuousSweep = !gradProvider.continuousSweep;
                  gradProvider.updateUi();
                },
                icon: Icon(gradProvider.continuousSweep
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                label: const Text(
                  "Continuous Sweep",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ));
  }

  checkIsItValidHexString(String hex) {
    if (!(hex.length == 6 || hex.length == 8)) {
      return false;
    }

    int? dd = int.tryParse(hex, radix: 16);
    log("subb dd $dd");
    if (dd == null) {
      return false;
    } else {
      return true;
    }
    // RegExp _hexcolor = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
    // if (_hexcolor.hasMatch("#" + hex)) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  getHexColor(String colorString) {
    if (colorString.length == 6) {
      return Color(int.parse("0xff${colorString}"));
    }
    if (colorString.length == 8) {
      return Color(int.parse("0x${colorString}"));
    }
    return Colors.white;
  }

  _gradientTypesList() {
    double bh = 40;
    colorListBoxW = tileModeW * 4 + 4 * (10 * 2)-20;

    return Positioned(
        right: 20,
        top: 20,
        child: Container(
          color: Colors.transparent,
          height: h - topbarH - 20,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  // width: gradeSelectBoxW + w * 0.05 + 6,
                  // width: w * 0.,
                  width: colorListBoxW+20,
                  height: gradeSelectBoxW + 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...List.generate(GradientType.values.length,
                          (i) => _gradientSelectionBox(i))
                    ],
                  ),
                ),
                Container(
                  height: tileModeW * 2,
                  // width: w * 0.6,
                  // color: Colors.red,
                  width: colorListBoxW+20,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(
                            TileMode.values.length, (i) => tileModeSIngleBox(i))
                      ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: h - topbarH - 20 - tileModeW * 4,
                    ),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.5, 0.5),
                            color: Colors.white,
                            spreadRadius: 0.6,
                            blurRadius: 0.7)
                      ],
                      color: const Color.fromARGB(255, 252, 254, 255),
                    ),
                    width: colorListBoxW,
                    // height: 0.5*colorListBoxH,
                    child: Column(
                      children: [
                        const Text(
                          "Colors",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: gradProvider.colorStopModels.length,
                              itemBuilder: (c, i) {
                                double pad = colorListBoxW * 0.02;
                                ColorStopModel e =
                                    gradProvider.colorStopModels[i];
                                TextEditingController controller =
                                    TextEditingController(
                                  text: e.hexColorString,
                                );

                                return Container(
                                  width: colorListBoxW - 16,
                                  height: bh,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showColorPicker(context, (Color d) {
                                            // log("showColorPicker before ${gradProvider.colorStopModels[colorStopModel.colorStop]!.hexColorString}");
                                            gradProvider.colorStopModels[i] =
                                                ColorStopModel(
                                                    e.colorStop,
                                                    d
                                                        .toString()
                                                        .replaceAll(')', '')
                                                        .split('x')[1],
                                                    e.left);
                                            // .hexColorString = d.toString();
                                            // log("showColorPicker after ${gradProvider.colorStopModels[colorStopModel.colorStop]!.hexColorString}");
                                            gradProvider.updateUi();
                                          },
                                              Color(int.parse(
                                                  "0x${gradProvider.colorStopModels[i].hexColorString}")));
                                        },
                                        child: Container(
                                          height: bh - pad * 2,
                                          margin: EdgeInsets.all(
                                              colorListBoxW * 0.02),
                                          width: bh - pad * 2,
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: getHexColor(
                                                  e.hexColorString)),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            // border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        height: bh - pad * 2,
                                        margin: EdgeInsets.all(
                                            colorListBoxW * 0.02),
                                        width:
                                            colorListBoxW * 0.8 - bh - pad * 2,
                                        child: Center(
                                          child: true
                                              ? TextField(
                                                  textAlign: TextAlign.center,
                                                  controller: controller,
                                                  decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  onSubmitted: (d) {
                                                    // log("subb ${d}/ ${checkIsItValidHexString(d)}");
                                                    if (checkIsItValidHexString(
                                                        d)) {
                                                      e.hexColorString = d;
                                                    } else {
                                                      controller.text =
                                                          e.hexColorString;
                                                    }
                                                    gradProvider.updateUi();
                                                  },
                                                )
                                              : SelectableText(
                                                  e.hexColorString,
                                                  style: TextStyle(
                                                      fontSize: bh * 0.5),
                                                ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (gradProvider
                                                  .colorStopModels.length >
                                              2) {
                                            gradProvider.colorStopModels
                                                .removeAt(i);
                                            gradProvider.updateUi();
                                          }
                                        },
                                        child: Container(
                                          height: bh - pad * 2,
                                          margin: EdgeInsets.all(
                                              colorListBoxW * 0.02),
                                          padding: EdgeInsets.all(bh * 0.1),
                                          width: bh - pad * 2,
                                          // color: Colors.amber,
                                          child: const FittedBox(
                                              child: const Icon(Icons.close)),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _gradientSelectionBox(int i) {
    return InkWell(
      onTap: () {
        gradProvider.gradientType = GradientType.values[i];
        gradProvider.updateUi();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: gradeSelectBoxW,
              width: gradeSelectBoxW,
              decoration: BoxDecoration(
                  color: Colors.green,
                  border: gradProvider.gradientType == GradientType.values[i]
                      ? Border.all(color: Colors.white, width: 4)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                  gradient: getGradientForTileMode(TileMode.values[i], i)),
            ),
            Container(
              width: w * 0.05,
              height: 40,
              child: Center(
                child: Text(
                  GradientType.values[i].toString().split('.')[1].toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  tileModeSIngleBox(int i) {
    return InkWell(
      onTap: () {
        gradProvider.selectedTileMode = TileMode.values[i];
        gradProvider.updateUi();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: tileModeW,
              height: tileModeW,
              decoration: BoxDecoration(
                  border: gradProvider.selectedTileMode == TileMode.values[i]
                      ? Border.all(
                          width: 3,
                          color: Colors.white,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(10),
                  gradient: getGradientForTileMode(TileMode.values[i],
                      GradientType.values.indexOf(gradProvider.gradientType))
                  // gradients[GradientType.values.indexOf(gradProvider.gradientType)].
                  ),
            ),
            Container(
              height: tileModeW * 0.3,
              child: Center(
                child: Text(
                  TileMode.values[i].name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Gradient getGradientForTileMode(TileMode tileMode, int gradIndex) {
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

  lineaGradAlignmentOptions() {
    return Container(
        // width: alignOptionsBoxW,
        height: alignOptionsBoxH,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            scrollButton(
              "left",
            ),
            Container(
              width: alignOptionsBoxW - 100,
              // color: Colors.green,
              height: alignOptionsBoxH,
              child: ListView.builder(
                  itemCount: alignmentPairList.length,
                  controller: linearGradOptionsController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, i) {
                    return lineaGradAlignmentOptionBox(i);
                  }),
            ),
            scrollButton(
              "right",
            ),
          ],
        ));
  }

  scrollButton(String dir) {
    return InkWell(
      onTap: () {
        switch (dir) {
          case "left":
            if (linearGradOptionsController.offset - alignOptionsBoxH >=
                -alignOptionsBoxH) {
              linearGradOptionsController.animateTo(
                  linearGradOptionsController.offset - alignOptionsBoxH,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.decelerate);
            }
            break;
          case "right":
            if (linearGradOptionsController.offset + alignOptionsBoxH <
                linearGradOptionsController.position.maxScrollExtent +
                    alignOptionsBoxH) {
              linearGradOptionsController.animateTo(

                  // offset:
                  linearGradOptionsController.offset + alignOptionsBoxH,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.decelerate);
            }
            break;
          case "leftblend":
            if (blendmodeslListCOntroller.offset - alignOptionsBoxH >=
                -alignOptionsBoxH) {
              blendmodeslListCOntroller.animateTo(
                  blendmodeslListCOntroller.offset - alignOptionsBoxH,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.decelerate);
            }
            break;
          case "rightblend":
            if (blendmodeslListCOntroller.offset + alignOptionsBoxH <
                blendmodeslListCOntroller.position.maxScrollExtent +
                    alignOptionsBoxH) {
              blendmodeslListCOntroller.animateTo(

                  // offset:
                  blendmodeslListCOntroller.offset + alignOptionsBoxH,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.decelerate);
            }
            break;
          default:
        }
      },
      child: Container(
        height: alignOptionsBoxH,
        width: 40,
        // color: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 3),

        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              boxShadow:const  [
                 BoxShadow(
                    color: Colors.white,
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset:  Offset(0.2, 0.2))
              ],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey)),
          child: Center(
            child: Icon(
              dir.contains("left")  ? Icons.arrow_left : Icons.arrow_right,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
   
  }

  int selectedLinearGradOption = 0;
  int selectedBlendModeOption = 13;
  blendModeBoxItem(int i) {
    double blendModeBoxItemH = alignOptionsBoxH + 30;
    return InkWell(
        onTap: () {
          selectedBlendModeOption = i;
          log("blend ${BlendMode.values[i].name} /$i");

          gradProvider.updateUi();
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              width: alignOptionsBoxH,
              height: alignOptionsBoxH,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.amber.shade100,
                border: Border.all(
                    color: Colors.white,
                    width: selectedBlendModeOption == i ? 3 : 0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ShaderMask(
                    blendMode: BlendMode.values[i],
                    shaderCallback: (Rect rect) {
                      return getGradientForTileMode(
                              gradProvider.selectedTileMode,
                              GradientType.values
                                  .indexOf(gradProvider.gradientType))
                          .createShader(rect);
                    },
                    child: Image.asset(
                      "nature.jpg",
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Text(
              BlendMode.values[i].name,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ));
  }

  lineaGradAlignmentOptionBox(int i) {
    // int j = i - 1;
    return InkWell(
      onTap: () {
        selectedLinearGradOption = i;

        gradProvider.updateLinearPointForSelectedAlignment(
            i == 0 ? gradProvider.originalAlignmentPair : alignmentPairList[i]);
        log("linal @ $i :  ${gradProvider.linearAlignStart.x},${gradProvider.linearAlignStart.y}/ ${gradProvider.linearAlignEnd.x}/${gradProvider.linearAlignEnd.y}");

        log("linal point ${gradProvider.linearAlignStartPoint}/ ${gradProvider.linearAlignEndPoint} / ${demoBoxSizeH}");
        gradProvider.updateUi();
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        width: alignOptionsBoxH,
        height: alignOptionsBoxH,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.amber.shade100,
          border: Border.all(
              color: Colors.white,
              width: selectedLinearGradOption == i ? 3 : 0.1),
          gradient: i == 0
              ? null
              : LinearGradient(
                  colors: [const Color(0xfff8b249), const Color(0xfffee795)],
                  begin: alignmentPairList[i].start,
                  end: alignmentPairList[i].end,
                  stops: [0.4, 0.7],
                  tileMode: gradProvider.selectedTileMode,
                ),
        ),
        child: i == 0
            ? const FittedBox(
                child: const Text("None"),
              )
            : null,
      ),
    );
  }

  _radiusSliders() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: sliderWidth,
            child: Row(
              children: [
                Container(
                  width: sliderWidth * 0.08,
                  child: const Text(
                    "Radius",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                      data: const SliderThemeData(
                          activeTrackColor: Colors.purple,
                          thumbColor: Colors.deepPurple),
                      child: Slider(
                        value: gradProvider.radialRadius,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (d) {
                          gradProvider.radialRadius = d;
                          gradProvider.updateUi();
                        },
                      )),
                ),
              ],
            )),
        Container(
          width: sliderWidth,
          child: Row(children: [
            Container(
              width: sliderWidth * 0.08,
              child: const Text(
                "Focal Radius",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
                child: SliderTheme(
                    data: const SliderThemeData(
                        activeTrackColor: Colors.orange,
                        thumbColor: Colors.deepOrange),
                    child: Slider(
                      value: gradProvider.radialFocalRadius,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (d) {
                        gradProvider.radialFocalRadius = d;
                        gradProvider.updateUi();
                      },
                    ))),
          ]),
        ),
      ],
    );
  }

  _sweepAngleSliders() {
    RangeValues values =
        RangeValues(gradProvider.sweepStartAngle, gradProvider.sweepEndAngle);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: sliderWidth,
            child: SliderTheme(
              data: SliderThemeData(
                  activeTrackColor: Colors.amber.shade200,
                  thumbColor: Colors.red),
              child: RangeSlider(
                  min: 0,
                  max: m.pi * 2,
                  values: values,
                  labels: const RangeLabels("Start Angle", "End Angle"),
                  onChanged: (d) {
                    log("dd $d");
                    gradProvider.sweepStartAngle = d.start;
                    gradProvider.sweepEndAngle = d.end;
                    gradProvider.updateUi();
                  }),
            ))
      ],
    );
  }

  _textBox() {
    return Container(
      width: textBoxSizeW,
      height: textBoxSizeH,
      color: Colors.transparent,
      child: ShaderMask(
          blendMode: BlendMode.values[selectedBlendModeOption],
          shaderCallback: ((bounds) {
            // log("boundd  / $textBoxSizeW / $textBoxSizeH / $bounds /");
            return getGradientForTileMode(gradProvider.selectedTileMode,
                    GradientType.values.indexOf(gradProvider.gradientType))
                .createShader(bounds);
          }),
          child: Center(
            child: Text(
              "Gradient",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: textBoxSizeW * 0.22),
            ),
          )),
    );
  }

  _imageBox() {
    return Container(
      width: imageBoxW,
      height: imageBoxH,
      // color: Colors.red,
      child: Column(
        children: [
          ClipRRect
          
        
          (


            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: imageBoxW,
              height: imageBoxH,
              
              child: ShaderMask(
                  blendMode: BlendMode.values[selectedBlendModeOption],
                  shaderCallback: (Rect rect) {
                    return getGradientForTileMode(
                            gradProvider.selectedTileMode,
                            GradientType.values
                                .indexOf(gradProvider.gradientType))
                        .createShader(rect);
                  },
                  child: Image.asset(
                    "nature.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          )
        ],
      ),
    );
  }

  _gradientDemo() {
    log("demoo ${demoBoxSizeW}");

    return Positioned(
        left: w * 0.01,
        top: h * 0.05,
        child: Container(
          color: Colors.transparent,
          width: m.max(
              sliderWidth - w * 0.02,
              demoBoxSizeW +
                  pointRad * 2 +
                  textBoxSizeW +
                  imageBoxW +
                  w * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: demoBoxSizeW + pointRad * 2,
                height: demoBoxSizeH + pointRad * 2,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(color: Colors.white),
                    gradient: getGradientForTileMode(
                        gradProvider.selectedTileMode,
                        GradientType.values
                            .indexOf(gradProvider.gradientType))),
                child: Center(
                  child: gradientModifierWidget(),
                ),
              ),
              _textBox(),
              _imageBox(),
            ],
          ),
        ));
  }

  gradientModifierWidget() {
    switch (gradProvider.gradientType) {
      case GradientType.linear:
        return linearGradientModifier();
        break;
      case GradientType.radial:
        return radialGradientModifier();
      case GradientType.radial:
        return sweepGradientModifier();
      default:
        return Container();
    }
  }

  linearGradientModifier() {
    gradProvider.linearAlignEnd = Alignment(
        gradProvider.linearAlignEndPoint.dx / demoBoxSizeW,
        (gradProvider.linearAlignEndPoint.dy / demoBoxSizeH));
    gradProvider.linearAlignStart = Alignment(
        gradProvider.linearAlignStartPoint.dx / demoBoxSizeW,
        (gradProvider.linearAlignStartPoint.dy / demoBoxSizeH));
    // log("alpoints ${gradProvider.linearAlignStartPoint}/ ${gradProvider.linearAlignEndPoint}");

    return Container(
      color: Colors.white,
      width: demoBoxSizeW + pointRad * 2,
      height: demoBoxSizeH + pointRad * 2,
      // padding: EdgeInsets.all(4),
      child: Center(
        child: Stack(

            // fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Container(
                  width: demoBoxSizeW,
                  height: demoBoxSizeH,
                  decoration: BoxDecoration(
                      gradient: getGradientForTileMode(
                          gradProvider.selectedTileMode,
                          GradientType.values
                              .indexOf(gradProvider.gradientType))),
                ),
              ),
              circlePoint(gradProvider.linearAlignStartPoint,
                  gradProvider.linearAlignStart, 0),
              circlePoint(gradProvider.linearAlignEndPoint,
                  gradProvider.linearAlignEnd, 1),
            ]),
      ),
    );
  }

  circlePoint(Offset point, Alignment alignment, int i) {
    return Positioned(
      left: point.dx,
      top: point.dy,
      child: GestureDetector(
        onPanUpdate: (d) {
          updatePoint(alignment, d, point);
        },
        child: CircleAvatar(
          radius: pointRad,
          backgroundColor: Colors.white,
          child: CircleAvatar(
              radius: pointRad - 2, backgroundColor: pointColors[i]),
        ),
      ),
    );
  }

  updatePoint(Alignment alignment, DragUpdateDetails d, Offset point) {
    if (alignment == gradProvider.linearAlignStart) {
      Offset updatePoint = Offset(gradProvider.linearAlignStartPoint.dx,
          gradProvider.linearAlignStartPoint.dy);
      gradProvider.linearAlignStartPoint = Offset(
          gradProvider.linearAlignStartPoint.dx + d.delta.dx,
          gradProvider.linearAlignStartPoint.dy + d.delta.dy);
      double x = gradProvider.linearAlignStartPoint.dx;
      double y = gradProvider.linearAlignStartPoint.dy;
      if (x < -pointRad * 0.25 ||
          y < -pointRad * 0.25 ||
          x + pointRad * 0.25 > demoBoxSizeW ||
          y + pointRad * 0.25 > demoBoxSizeW) {
        gradProvider.linearAlignStartPoint = updatePoint;
      }
    }
    if (alignment == gradProvider.linearAlignEnd) {
      Offset updatePoint = Offset(gradProvider.linearAlignEndPoint.dx,
          gradProvider.linearAlignEndPoint.dy);
      gradProvider.linearAlignEndPoint = Offset(
          gradProvider.linearAlignEndPoint.dx + d.delta.dx,
          gradProvider.linearAlignEndPoint.dy + d.delta.dy);
      double x = gradProvider.linearAlignEndPoint.dx;
      double y = gradProvider.linearAlignEndPoint.dy;

      // log("x $x")
      if (x < -pointRad * 0.5 ||
          y < -pointRad * 0.5 ||
          x + pointRad * 0.5 > demoBoxSizeW + pointRad ||
          y + pointRad * 0.5 > demoBoxSizeW + pointRad) {
        gradProvider.linearAlignEndPoint = updatePoint;
      }
    }

    if (alignment == gradProvider.radialAlignCenter) {
      Offset updatePoint = Offset(gradProvider.radialAlignCenterPoint.dx,
          gradProvider.radialAlignCenterPoint.dy);
      gradProvider.radialAlignCenterPoint = Offset(
          gradProvider.radialAlignCenterPoint.dx + d.delta.dx,
          gradProvider.radialAlignCenterPoint.dy + d.delta.dy);
      double x = gradProvider.radialAlignCenterPoint.dx;
      double y = gradProvider.radialAlignCenterPoint.dy;

      // log("x $x")
      if (x < -pointRad * 0.5 ||
          y < -pointRad * 0.5 ||
          x + pointRad * 0.5 > demoBoxSizeW + pointRad ||
          y + pointRad * 0.5 > demoBoxSizeW + pointRad) {
        gradProvider.radialAlignCenterPoint = updatePoint;
      }
    }

    if (alignment == gradProvider.radialAlignFocal) {
      Offset updatePoint = Offset(gradProvider.radialAlignFocalPoint.dx,
          gradProvider.radialAlignFocalPoint.dy);
      gradProvider.radialAlignFocalPoint = Offset(
          gradProvider.radialAlignFocalPoint.dx + d.delta.dx,
          gradProvider.radialAlignFocalPoint.dy + d.delta.dy);
      double x = gradProvider.radialAlignFocalPoint.dx;
      double y = gradProvider.radialAlignFocalPoint.dy;

      // log("x $x")
      if (x < -pointRad * 0.5 ||
          y < -pointRad * 0.5 ||
          x + pointRad * 0.5 > demoBoxSizeW + pointRad ||
          y + pointRad * 0.5 > demoBoxSizeW + pointRad) {
        gradProvider.radialAlignCenterPoint = updatePoint;
      }
    }

    if (alignment == gradProvider.sweepAlignCenter) {
      Offset updatePoint = Offset(gradProvider.sweepAlignCenterPoint.dx,
          gradProvider.sweepAlignCenterPoint.dy);
      gradProvider.sweepAlignCenterPoint = Offset(
          gradProvider.sweepAlignCenterPoint.dx + d.delta.dx,
          gradProvider.sweepAlignCenterPoint.dy + d.delta.dy);
      double x = gradProvider.sweepAlignCenterPoint.dx;
      double y = gradProvider.sweepAlignCenterPoint.dy;

      // log("x $x")
      if (x < -pointRad * 0.5 ||
          y < -pointRad * 0.5 ||
          x + pointRad * 0.5 > demoBoxSizeW + pointRad ||
          y + pointRad * 0.5 > demoBoxSizeW + pointRad) {
        gradProvider.sweepAlignCenterPoint = updatePoint;
      }
    }
    gradProvider.updateUi();
  }

  radialGradientModifier() {
    gradProvider.radialAlignCenter = Alignment(
        gradProvider.radialAlignCenterPoint.dx / demoBoxSizeW - 0.5,
        (gradProvider.radialAlignCenterPoint.dy / demoBoxSizeH - 0.5));
    gradProvider.radialAlignFocal = Alignment(
        gradProvider.radialAlignFocalPoint.dx / demoBoxSizeW - 0.5,
        (gradProvider.radialAlignFocalPoint.dy / demoBoxSizeH - 0.5));

    return Container(
      color: Colors.white,
      width: demoBoxSizeW + pointRad * 2,
      height: demoBoxSizeH + pointRad * 2,
      // padding: EdgeInsets.all(4),
      child: Center(
        child: Stack(

            // fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Container(
                  width: demoBoxSizeW,
                  height: demoBoxSizeH,
                  decoration: BoxDecoration(
                      gradient: getGradientForTileMode(
                          gradProvider.selectedTileMode,
                          GradientType.values
                              .indexOf(gradProvider.gradientType))),
                ),
              ),
              circlePoint(gradProvider.radialAlignFocalPoint,
                  gradProvider.radialAlignFocal, 0),
              circlePoint(gradProvider.radialAlignCenterPoint,
                  gradProvider.radialAlignCenter, 1),
            ]),
      ),
    );
  }

  sweepGradientModifier() {
    gradProvider.sweepAlignCenter = Alignment(
        gradProvider.sweepAlignCenterPoint.dx / demoBoxSizeW - 0.5,
        (gradProvider.sweepAlignCenterPoint.dy / demoBoxSizeH - 0.5));

    return Container(
      color: Colors.red.shade100,
      width: demoBoxSizeW + pointRad * 2,
      height: demoBoxSizeH + pointRad * 2,
      // padding: EdgeInsets.all(4),
      child: Center(
        child: Stack(

            // fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Container(
                  width: demoBoxSizeW,
                  height: demoBoxSizeH,
                  decoration: BoxDecoration(
                      gradient: getGradientForTileMode(
                          gradProvider.selectedTileMode,
                          GradientType.values
                              .indexOf(gradProvider.gradientType))),
                ),
              ),
              circlePoint(gradProvider.sweepAlignCenterPoint,
                  gradProvider.sweepAlignCenter, 0),
            ]),
      ),
    );
  }

  _topBar() {
    return Container(
        color: const Color.fromARGB(255, 225, 195, 150),
        width: w,
        height: topbarH,
        child: Row(
          children: [
            const Spacer(),
            TextButton.icon(
                onPressed: () async {
                  showCodeInDialog();
                },
                icon: const Icon(Icons.data_object, color: Colors.black),
                label: const Text(
                  "Get Code",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ))
          ],
        )

        // Text(
        //     "w : h  : ${w} / $h /  ${(w / h).toDouble().toStringAsFixed(2)}"),
        );
  }

  void createAlignmentPairlist() {
    alignmentPairList = [
      AlignmentPair(
        gradProvider.originalAlignmentPair.start,
        gradProvider.originalAlignmentPair.end,
      ),
      AlignmentPair(
        Alignment.centerLeft,
        Alignment.centerRight,
      ),
      AlignmentPair(
        Alignment.topCenter,
        Alignment.bottomCenter,
      ),
      AlignmentPair(
        Alignment.topLeft,
        Alignment.bottomRight,
      ),
      AlignmentPair(
        Alignment.bottomLeft,
        Alignment.topRight,
      ),
      AlignmentPair(
        Alignment.centerLeft,
        Alignment.topRight,
      ),
      AlignmentPair(
        Alignment.centerRight,
        Alignment.topLeft,
      ),
      AlignmentPair(
        Alignment.centerLeft,
        Alignment.bottomRight,
      ),
      AlignmentPair(
        Alignment.centerRight,
        Alignment.bottomLeft,
      ),
    ];
  }

  void showCodeInDialog() async {
    String code = "code";
    code = getGradientForTileMode(gradProvider.selectedTileMode,
        GradientType.values.indexOf(gradProvider.gradientType)).toString();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Spacer(),
                  IconButton(onPressed: () {
                   Clipboard.setData( ClipboardData(text: code));
                    scaffoldKey.currentState!.showSnackBar(
                 const    SnackBar(content:  Text("Code Copied to Clipboard"),));
                  }, icon:const Icon(Icons.copy_all)),
                  IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.red,
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                constraints: BoxConstraints(maxHeight: h * 0.7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(),
                  color: Colors.black87,
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    code ,
                    style: TextStyle(fontSize: 25, color: Colors.grey.shade200),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

showColorPicker(BuildContext context, Function fun, Color prevColor) async {
  log("showColorPicker $fun");
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: prevColor,
              onColorChanged: (color) {
                fun(color);
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                // setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

class ColorStopSlider extends StatelessWidget {
  final double tw;
  final double th;

  const ColorStopSlider({Key? key, required this.tw, required this.th})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double actualW = tw * sliderActualWidthFactor;
    double barH = th * 0.5;
    GradProvider gradProvider = Provider.of(context, listen: true);
    log("didff / ${tw - actualW} / ${actualW}/ $tw");
    return Container(
        width: tw,
        height: th,
        margin: const EdgeInsets.all(15),
        color: Colors.amber.shade100.withAlpha(0),
        child: Center(
          child: Container(
            width: actualW,
            height: th,
            child: Stack(clipBehavior: Clip.none, children: [
              Padding(
                padding: EdgeInsets.only(top: th * 0.3),
                child: Center(
                  child: GestureDetector(
                    onTapUp: (d) {
                      log("onadd $d / ${gradProvider.colorStopModels.length}");
                      double stopValue = d.localPosition.dx / (actualW);
                      gradProvider.colorStopModels.add(ColorStopModel(
                          stopValue, "ffffffff", d.localPosition.dx));
                      log("bef remove aftersort after add /ll ${gradProvider.colorStopModels.length}");
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
              height: iconH - 4,
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
                height: barH + 4 * 2,
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
