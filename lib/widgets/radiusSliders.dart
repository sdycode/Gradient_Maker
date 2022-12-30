import 'package:flutter/material.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/styles/sliderThemeData.dart';
import 'package:gradient_maker/widgets/blendModesinRow.dart';
import 'package:provider/provider.dart';

class RadiusSliders extends StatelessWidget {
  const RadiusSliders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider = Provider.of(
      context,
    );
    return Container(
      height: slidersBoxH,
      // color: Colors.green.shade100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: sliderWidth,
              child: Row(
                children: [
                  Container(
                    width: sliderWidth * 0.08,
                    child: const Text(
                      "Radius",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: SliderTheme(
                        data: sliderThemeData.copyWith(
                            activeTrackColor: Colors.purple,
                            thumbColor: Colors.deepPurple),
                        child: Slider(
                          value: gradProvider.radialRadius,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (d) {
                            gradProvider.radialRadius = d;
                            gradProvider.updateUi();
                          },
                        )),
                  ),
                ],
              )),
          Container(
            width: sliderWidth,
            child: Row(children: [
              Container(
                width: sliderWidth * 0.08,
                child: const Text(
                  "Focal Radius",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                  child: SliderTheme(
                      data: sliderThemeData.copyWith(
                          activeTrackColor: Colors.orange,
                          thumbColor: Colors.deepOrange),
                      child: Slider(
                        value: gradProvider.radialFocalRadius,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (d) {
                          gradProvider.radialFocalRadius = d;
                          gradProvider.updateUi();
                        },
                      ))),
            ]),
          ),
        ],
      ),
    );
  }
}
