import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/global.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/main.dart';
import 'package:provider/provider.dart';

class BlendModeBoxItem extends StatelessWidget {
  final int i;
  const BlendModeBoxItem(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider = Provider.of(
      context,
    );
    double blendModeBoxItemH = alignOptionsBoxH + 30;
    return Transform.scale(
      scale: 1,
      child: InkWell(
          onTap: () {
            selectedBlendModeOption = i;
            log("blend ${BlendMode.values[i].name} /$i");

            gradProvider.updateUi();
          },
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(4),
                width: alignOptionsBoxH,
                height: alignOptionsBoxH,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.amber.shade100,
                  border: Border.all(
                      color: Colors.white,
                      width: selectedBlendModeOption == i ? 5 : 0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ShaderMask(
                      blendMode: BlendMode.values[i],
                      shaderCallback: (Rect rect) {
                        return getGradientForTileMode(
                                gradProvider.selectedTileMode,
                                GradientType.values
                                    .indexOf(gradProvider.gradientType),
                                gradProvider)
                            .createShader(rect);
                      },
                      child: Image.network(
                        "https://raw.githubusercontent.com/sdycode/Gradient_Maker/main/assets/nature.jpg",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Text(
                BlendMode.values[i].name,
                style: const TextStyle(color: Colors.white),
              )
            ],
          )),
    
    
    );
  }
}
