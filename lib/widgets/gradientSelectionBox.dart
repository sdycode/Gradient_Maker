import 'package:flutter/material.dart';
import 'package:gradient_maker/extension.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/main.dart';
import 'package:provider/provider.dart';

class GradientSelectionBox extends StatelessWidget {
  final int i;
  const GradientSelectionBox(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider = Provider.of(
      context,
    );
    return Transform.scale(
      scale: gradProvider.gradientType == GradientType.values[i] ? 1.04 : 1,
      child: InkWell(
        onTap: () {
          gradProvider.gradientType = GradientType.values[i];
          gradProvider.updateUi();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
          child: Column(
            children: [
              Container(
                height: tileModeW,
                width: tileModeW * 4 / 3,
                decoration: BoxDecoration(
                    color: Colors.green,
                    border: gradProvider.gradientType == GradientType.values[i]
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                    borderRadius: BorderRadius.circular(6),
                    gradient: getGradientForTileMode(
                        TileMode.values[i], i, gradProvider)),
              ),
              Container(
                width: tileModeW * 4 / 3,
                height: 20,
                child: Center(
                  child: Text(
                    GradientType.values[i].name.capitaliseFirstLetter(),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
