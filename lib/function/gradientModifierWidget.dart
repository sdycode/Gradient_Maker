 import 'package:flutter/material.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/widgets/Gradient/linearGradientModifier.dart';
import 'package:gradient_maker/widgets/Gradient/radialGradientModifier.dart';
import 'package:gradient_maker/widgets/Gradient/sweepGradientModifier.dart';

gradientModifierWidget(GradProvider gradProvider) {
    switch (gradProvider.gradientType) {
      case GradientType.linear:
        return const LinearGradientModifier();
        
      case GradientType.radial:
        return const RadialGradientModifier();
      case GradientType.sweep:
        return const SweepGradientModifier();
      default:
        return Container();
    }
  }
