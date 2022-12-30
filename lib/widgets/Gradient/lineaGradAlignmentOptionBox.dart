import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gradient_maker/constants.dart';
import 'package:gradient_maker/global.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/main.dart';
import 'package:provider/provider.dart';

class LineaGradAlignmentOptionBox extends StatelessWidget {
  final int i;
  const LineaGradAlignmentOptionBox(this.i,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { GradProvider gradProvider = Provider.of(
      context,
    );
    return InkWell(
      onTap: () {
        selectedLinearGradOption = i;

        gradProvider.updateLinearPointForSelectedAlignment(
            i == 0 ? gradProvider.originalAlignmentPair : alignmentPairList[i]);
        log("linal @ $i :  ${gradProvider.linearAlignStart.x},${gradProvider.linearAlignStart.y}/ ${gradProvider.linearAlignEnd.x}/${gradProvider.linearAlignEnd.y}");

        log("linal point ${gradProvider.linearAlignStartPoint}/ ${gradProvider.linearAlignEndPoint} / ${demoBoxSizeH}");
        gradProvider.updateUi();
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        width: slidersBoxH,
        height: slidersBoxH,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.amber.shade100,
          border: Border.all(
              color: Colors.white,
              width: selectedLinearGradOption == i ? 3 : 0.1),
          gradient: i == 0
              ? null
              : LinearGradient(
                  colors: [ Color(int.parse("0x${gradProvider.colorStopModels.first.hexColorString}")), Color(int.parse("0x${gradProvider.colorStopModels.last.hexColorString}"))],
                  begin: alignmentPairList[i].start,
                  end: alignmentPairList[i].end,
                  stops: [0.4, 0.7],
                  tileMode: gradProvider.selectedTileMode,
                ),
        ),
        child: i == 0
            ? const FittedBox(
                child: const Text("None"),
              )
            : null,
      ),
    );
  }
}
