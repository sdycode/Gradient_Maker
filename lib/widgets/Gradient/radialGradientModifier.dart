
import 'package:flutter/material.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/widgets/circlePoint.dart';
import 'package:provider/provider.dart';
class RadialGradientModifier extends StatelessWidget {
  const RadialGradientModifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { GradProvider gradProvider = Provider.of(
      context,
    );
    gradProvider.radialAlignCenter = Alignment(
        gradProvider.radialAlignCenterPoint.dx / demoBoxSizeW - 0.5,
        (gradProvider.radialAlignCenterPoint.dy / demoBoxSizeH - 0.5));
    gradProvider.radialAlignFocal = Alignment(
        gradProvider.radialAlignFocalPoint.dx / demoBoxSizeW - 0.5,
        (gradProvider.radialAlignFocalPoint.dy / demoBoxSizeH - 0.5));

    return Container(
    color: Colors.transparent,
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
                              .indexOf(gradProvider.gradientType),
                          gradProvider)),
                ),
              ),
              CirclePoint(gradProvider.radialAlignFocalPoint,
                  gradProvider.radialAlignFocal, 0),
              CirclePoint(gradProvider.radialAlignCenterPoint,
                  gradProvider.radialAlignCenter, 1),
            ]),
      ),
    );
  }
}