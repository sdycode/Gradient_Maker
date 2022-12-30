import 'package:flutter/material.dart';
import 'package:gradient_maker/function/updatePoint.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:provider/provider.dart';
import 'package:gradient_maker/main.dart';

List<Color> pointColors = const [Colors.red, Color.fromARGB(255, 38, 10, 74)];
class CirclePoint extends StatelessWidget {
  final Offset point;
  final Alignment alignment;
  final int i;
  const CirclePoint(this.point, this.alignment, this.i, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider = Provider.of(
      context,
    );
    return Positioned(
      left: point.dx,
      top: point.dy,
      child: GestureDetector(
        onPanUpdate: (d) {
          updatePoint(alignment, d, point, gradProvider);
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
}
