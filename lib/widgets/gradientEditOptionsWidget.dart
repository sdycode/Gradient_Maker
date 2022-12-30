import 'dart:developer' as de;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gradient_maker/constants.dart';
import 'package:gradient_maker/function/checkIsItValidHexString.dart';
import 'package:gradient_maker/function/getHexColor.dart';
import 'package:gradient_maker/global.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/widgets/blendModeInGridForm.dart';
import 'package:gradient_maker/widgets/gradientSelectionBox.dart';
import 'package:gradient_maker/widgets/tileModeSingleBox.dart';
import 'package:provider/provider.dart';

class GradientEditOptionsWidget extends StatelessWidget {
  const GradientEditOptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider = Provider.of(
      context,
    );
    double bh = 28;

    return Positioned(
        right: 0,
        top: 0,
        child: Container(
          width: colorListBoxW,
          color: Color.fromARGB(255, 29, 28, 28),
          height: h - topbarH,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: colorListBoxW,
                // height: gradeSelectBoxW + 40,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...List.generate(GradientType.values.length,
                        (i) => GradientSelectionBox(i))
                  ],
                ),
              ),
              Container(
                width: colorListBoxW,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List.generate(
                          TileMode.values.length, (i) => TileModeSingleBox(i))
                    ]),
              ),
              Expanded(
                  child: RawScrollbar(
                trackVisibility: true,
                thumbColor: Colors.amber.shade100.withAlpha(150),
                thickness: 10,
                radius: Radius.circular(4),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    ExpansionTile(
                      iconColor: Colors.white,
                      backgroundColor: Colors.black,
                      collapsedBackgroundColor: Colors.black,
                      title: Text(
                        "Colors",
                        style: TextStyle(color: Colors.white),
                      ),
                      collapsedTextColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      children: [
                        Container(
                          height: bh *
                              (min(gradProvider.colorStopModels.length, 8) + 1),
                          constraints: BoxConstraints(maxHeight: bh * 8),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: bh,
                                child: Text(
                                  "Colors",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: bh * 0.6,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount:
                                        gradProvider.colorStopModels.length,
                                    itemBuilder: (c, i) {
                                      double pad = 3;
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showColorPicker(context,
                                                    (Color d) {
                                                  gradProvider
                                                          .colorStopModels[i] =
                                                      ColorStopModel(
                                                          e.colorStop,
                                                          d
                                                              .toString()
                                                              .replaceAll(
                                                                  ')', '')
                                                              .split('x')[1],
                                                          e.left);
                                                  gradProvider.updateUi();
                                                },
                                                    Color(int.parse(
                                                        "0x${gradProvider.colorStopModels[i].hexColorString}")));
                                              },
                                              child: Container(
                                                height: bh - pad * 2,
                                                margin: EdgeInsets.all(pad),
                                                width: bh - pad * 2,
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: getHexColor(
                                                        e.hexColorString)),
                                              ),
                                            ),
                                            Container(
                                                height: bh,
                                                // margin:
                                                //     EdgeInsets.symmetric(horizontal: 4),
                                                width: colorListBoxW -
                                                    (16 + 8 + bh * 2),
                                                child: TextField(
                                                  onSubmitted: (d) {
                                                    if (checkIsItValidHexString(
                                                        d)) {
                                                      e.hexColorString = d;
                                                    } else {
                                                      controller.text =
                                                          e.hexColorString;
                                                    }
                                                    gradProvider.updateUi();
                                                  },
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: bh - 14),
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    border: InputBorder.none,
                                                  ),
                                                  controller: controller,
                                                )),
                                            InkWell(
                                              onTap: () {
                                                if (gradProvider.colorStopModels
                                                        .length >
                                                    2) {
                                                  gradProvider.colorStopModels
                                                      .removeAt(i);
                                                  gradProvider.updateUi();
                                                }
                                              },
                                              child: Container(
                                                height: bh - pad * 2,
                                                margin: EdgeInsets.all(pad),
                                                padding:
                                                    EdgeInsets.all(bh * 0.1),
                                                width: bh - pad * 2,
                                                // color: Colors.amber,
                                                child: const FittedBox(
                                                    child: const Icon(
                                                        Icons.close)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade100,
                      indent: 10,
                      endIndent: 10,
                    ),
                    BlendModesInGridForm(),
                  ],
                )),
              )),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.blue.shade100))),
                    ),
                    onPressed: () {
                      randomNo++;
                      randomNo = randomNo % colorsPairs.length;

                      gradProvider.colorStopModels = [
                        ColorStopModel(0.0, colorsPairs[randomNo][0],
                            gradProvider.colorStopModels.first.left),
                        ColorStopModel(1.0, colorsPairs[randomNo][1],
                            gradProvider.colorStopModels.last.left)
                      ];

                      de.log(
                          "gradProvider.colorStopModels ${gradProvider.colorStopModels[1].left}");

                      gradProvider.updateUi();
                      // colorMo
                    },
                    child: Text(
                      "Random",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 8,
              )
            ],
          ),
        ));
  }
}
