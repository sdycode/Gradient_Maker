


import 'package:flutter/material.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'dart:developer';
import 'dart:math' as m;
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/styles/sliderThemeData.dart';
import 'package:gradient_maker/styles/textStyles.dart';
import 'package:gradient_maker/widgets/blendModesinRow.dart';
import 'package:provider/provider.dart';
class SweepAngleSliders extends StatelessWidget {
  const SweepAngleSliders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {GradProvider gradProvider = Provider.of(
      context,
    );
    RangeValues values =
        RangeValues(gradProvider.sweepStartAngle, gradProvider.sweepEndAngle);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: sliderWidth,
            height: slidersBoxH,
            child:
            
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:  SliderTheme(
                              data:
                              
                             sliderThemeData.copyWith( activeTrackColor: Colors.amber.shade200,
                    thumbColor: Colors.red,
                    inactiveTrackColor: Colors.amber.shade100.withAlpha(150)
                    ) ,
                              
                              child: RangeSlider(
                    min: 0,
                    max: m.pi * 2,
                    values: values,
                    labels: const RangeLabels("Start Angle", "End Angle"),
                    onChanged: (d) {
                  
                      gradProvider.sweepStartAngle = d.start;
                      gradProvider.sweepEndAngle = d.end;
                      gradProvider.updateUi();
                    }),
                            ),
                  ),
                ),
            Container(height: slidersBoxH,
            child: InkWell(
              onTap: () {
                  gradProvider.continuousSweep = !gradProvider.continuousSweep;
                  gradProvider.updateUi();
              },
              child: Row(children: [
                      Text(
                          "Continuous Sweep",
                          style: whiteText.copyWith(fontSize: 15),
                        ),
                        SizedBox(width: 8,)
                        ,Icon(
                         !gradProvider.continuousSweep 
                              ? Icons.check_circle_outline
                              : Icons.check_circle,
                              size: 18,
                          color: Colors.white,
                        )
              ],),
            )
            )
              ],
            )
          )
      ],
    );
 
  }
}