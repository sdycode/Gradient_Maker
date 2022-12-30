import 'package:flutter/material.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/widgets/Gradient/lineaGradAlignmentOptions.dart';
import 'package:gradient_maker/widgets/Gradient/sweepdata.dart';
import 'package:gradient_maker/widgets/blendModesinRow.dart';
import 'package:gradient_maker/widgets/colorStopSlider.dart';
import 'package:gradient_maker/widgets/radiusSliders.dart';
import 'package:gradient_maker/widgets/sweepAngleSliders.dart';
import 'package:provider/provider.dart';

class ColorSliderBar extends StatelessWidget {
  const ColorSliderBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider = Provider.of(
      context,
    );
    return Positioned(
        bottom: 0,
        left: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  const  BlendModesInRow(),
            const SizedBox(
              height: 8,
            ),
            if (gradProvider.gradientType == GradientType.radial)
              const RadiusSliders(),
            if (gradProvider.gradientType == GradientType.sweep)
              SweepAngleSliders(),
            // if (gradProvider.gradientType == GradientType.sweep) SweepData(),
            if (gradProvider.gradientType == GradientType.linear)
              const LineaGradAlignmentOptions(),
            ColorStopSlider(tw: sliderWidth, th: colorSliderBarH)
          ],
        ));
  }
}
