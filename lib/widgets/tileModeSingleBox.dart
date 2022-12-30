import 'package:flutter/material.dart';
import 'package:gradient_maker/extension.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/main.dart';
import 'package:provider/provider.dart';

class TileModeSingleBox extends StatelessWidget {
  final int i;
  const TileModeSingleBox(this.i,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider = Provider.of(
      context,
    );
    return Transform.scale(
      scale: gradProvider.selectedTileMode == TileMode.values[i] ? 1.04 : 1,
      child: InkWell(
        onTap: () {
          gradProvider.selectedTileMode = TileMode.values[i];
          gradProvider.updateUi();
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: tileModeW,
                height: tileModeW,
                decoration: BoxDecoration(
                    border: gradProvider.selectedTileMode == TileMode.values[i]
                        ? Border.all(
                            width: 3,
                            color: Colors.white,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(6),
                    gradient: getGradientForTileMode(
                        TileMode.values[i],
                        GradientType.values.indexOf(gradProvider.gradientType),
                        gradProvider)
                    // gradients[GradientType.values.indexOf(gradProvider.gradientType)].
                    ),
              ),
              Container(
                height:20,
                width: tileModeW,
                child: Center(
                  child: Text(
                    TileMode.values[i].name.capitaliseFirstLetter(),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(color: Colors.white, fontSize: 8),
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
