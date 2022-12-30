
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/widgets/circlePoint.dart';
import 'package:provider/provider.dart';
class LinearGradientModifier extends StatelessWidget {
  const LinearGradientModifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { GradProvider gradProvider = Provider.of(
      context,
    );
       gradProvider.linearAlignEnd = Alignment(
        gradProvider.linearAlignEndPoint.dx / demoBoxSizeW,
        (gradProvider.linearAlignEndPoint.dy / demoBoxSizeH));
    gradProvider.linearAlignStart = Alignment(
        gradProvider.linearAlignStartPoint.dx / demoBoxSizeW,
        (gradProvider.linearAlignStartPoint.dy / demoBoxSizeH));
    // log("alpoints ${gradProvider.linearAlignStartPoint}/ ${gradProvider.linearAlignEndPoint}");

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
              CirclePoint(gradProvider.linearAlignStartPoint,
                  gradProvider.linearAlignStart, 0),
              CirclePoint(gradProvider.linearAlignEndPoint,
                  gradProvider.linearAlignEnd, 1),
            ]),
      ),
    );
 
  }
}