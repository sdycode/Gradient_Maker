

import 'package:flutter/material.dart';
import 'package:gradient_maker/constants.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/styles/textStyles.dart';
import 'package:gradient_maker/widgets/Gradient/lineaGradAlignmentOptionBox.dart';
import 'package:gradient_maker/widgets/scrollButton.dart';

class LineaGradAlignmentOptions extends StatelessWidget {
  const LineaGradAlignmentOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: alignOptionsBoxW,
        height: slidersBoxH,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const ScrollButton(
            //   "left",
            // ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text("Linear Gradient",style: whiteText.copyWith(fontSize: 20),),
      ),
            Container(
              width: sliderWidth ,
              // color: Colors.green,
              height: slidersBoxH,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: RawScrollbar(
                trackColor: Colors.amber.shade100.withAlpha(180),
                controller: linearGradOptionsController,
                radius: Radius.circular(4),
               
                thickness: 10,
                scrollbarOrientation: ScrollbarOrientation.bottom,
                child: ListView.builder(
                    itemCount: alignmentPairList.length,
                    controller: linearGradOptionsController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, i) {
                      return LineaGradAlignmentOptionBox(i);
                    }),
              ),
            ),
            // const ScrollButton(
            //   "right",
            // ),
          ],
        ));
  }
}