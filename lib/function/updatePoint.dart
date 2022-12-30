
  import 'package:flutter/material.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/main.dart';

updatePoint(Alignment alignment, DragUpdateDetails d, Offset point, GradProvider gradProvider) {
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
