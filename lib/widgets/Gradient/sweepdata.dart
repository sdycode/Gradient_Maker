import 'package:flutter/material.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/widgets/blendModesinRow.dart';
import 'package:provider/provider.dart';
class SweepData extends StatelessWidget {
  const SweepData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { GradProvider gradProvider = Provider.of(
      context,
    );
      return Container(
        width: sliderWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Start - End Angles",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  gradProvider.continuousSweep = !gradProvider.continuousSweep;
                  gradProvider.updateUi();
                },
                icon: Icon(gradProvider.continuousSweep
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                label: const Text(
                  "Continuous Sweep",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ));
 
  }
}