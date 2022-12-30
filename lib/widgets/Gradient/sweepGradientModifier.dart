import 'package:flutter/material.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/widgets/circlePoint.dart';
import 'package:provider/provider.dart';
class SweepGradientModifier extends StatelessWidget {
  const SweepGradientModifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {   GradProvider gradProvider = Provider.of(
      context,
    );
    gradProvider.sweepAlignCenter = Alignment(
        gradProvider.sweepAlignCenterPoint.dx / demoBoxSizeW - 0.5,
        (gradProvider.sweepAlignCenterPoint.dy / demoBoxSizeH - 0.5));

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
              CirclePoint(gradProvider.sweepAlignCenterPoint,
                  gradProvider.sweepAlignCenter, 0),
            ]),
      ),
    );
  }
}