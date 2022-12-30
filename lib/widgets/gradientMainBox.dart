import 'package:flutter/material.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/function/gradientModifierWidget.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/widgets/textAndImageWithGradient.dart';
import 'package:provider/provider.dart';
import 'dart:math' as m;
class GradientMainBox extends StatelessWidget {
  const GradientMainBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     GradProvider gradProvider = Provider.of(
      context,
    );
    return Positioned(
        left: 10,
        top: 10,
        child: Container(
          // color: Colors.green.shade100,
          width: m.max(
              sliderWidth - w * 0.02,
              demoBoxSizeW +
                  pointRad * 2 +
                  // textBoxSizeW +
                  imageBoxW +
                  w * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: demoBoxSizeW + pointRad * 2,
                height: demoBoxSizeH + pointRad * 2,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.transparent),
                    gradient: getGradientForTileMode(
                        gradProvider.selectedTileMode,
                        GradientType.values.indexOf(gradProvider.gradientType),
                        gradProvider)),
                child: Center(
                  child: gradientModifierWidget(gradProvider),
                ),
              ),
              TextAndImageWithGradient()
            
            ],
          ),
        ));

  }
}