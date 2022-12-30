import 'package:flutter/material.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/widgets/blendModeBoxItem.dart';
import 'package:gradient_maker/widgets/scrollButton.dart';

class BlendModesInRow extends StatelessWidget {
  const BlendModesInRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double blendModeBoxItemH = alignOptionsBoxH + 30;
    return Container(
        // width: alignOptionsBoxW,
        height: blendModeBoxItemH,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ScrollButton(
              "leftblend",
            ),
            Container(
              width: alignOptionsBoxW - 100,
              // color: Colors.green,
              height: blendModeBoxItemH,
              child: RawScrollbar(
                trackColor: Colors.amber.shade100.withAlpha(180),
                controller: blendmodeslListCOntroller,
                radius: Radius.circular(4),
               
                thickness: 10,
                scrollbarOrientation: ScrollbarOrientation.bottom,
                child: ListView.builder(
                    itemCount: BlendMode.values.length,
                    controller: blendmodeslListCOntroller,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, i) {
                      return BlendModeBoxItem(i);
                    }),
              ),
            ),
            const ScrollButton(
              "rightblend",
            ),
          ],
        ));
  }
}
