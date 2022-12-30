import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as m;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gradient_maker/constants.dart';
import 'package:gradient_maker/function/createAlignmentPairlist.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/function/getHexColor.dart';
import 'package:gradient_maker/function/gradientModifierWidget.dart';
import 'package:gradient_maker/global.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/main.dart';

import 'package:gradient_maker/widgets/colorSliderBar.dart';
import 'package:gradient_maker/widgets/drawer.dart';
import 'package:gradient_maker/widgets/gradientEditOptionsWidget.dart';
import 'package:gradient_maker/widgets/gradientMainBox.dart';
import 'package:gradient_maker/widgets/textAndImageWithGradient.dart';
import 'package:gradient_maker/widgets/topbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
 final scaffoldKey = GlobalKey<ScaffoldState>();
ScrollController blendmodeslListCOntroller = ScrollController();
ScrollController linearGradOptionsController = ScrollController();

class GradientCreator extends StatefulWidget {
  const GradientCreator({Key? key}) : super(key: key);

  @override
  State<GradientCreator> createState() => _GradientCreatorState();
}

class _GradientCreatorState extends State<GradientCreator> {
  late GradProvider gradProvider;
  File? vimage;
  File? tempVimage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage();
    GradProvider grad = Provider.of(context, listen: false);
    grad.updateAlignPointsForBoxSize(Size(demoBoxSizeW, demoBoxSizeH));
  }

 
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    gradProvider = Provider.of(context, listen: true);
    double left = demoBoxSizeW + pointRad * 2 + textBoxSizeW + w * 0.04;
    double right = tileModeW * 4 + 4 * (10 * 2);
    // log("what is diff LEFT ${left} / RIGHT ${right} / ${w} / ${(left + right) / w}");

    double top = h * 0.05 + demoBoxSizeH + pointRad * 2;
    double btm = alignOptionsBoxH + h * 0.08;
    // log("what is diff TOP top ${top} / btm ${btm} / ${h} / ${(top + btm) / h}");
    createAlignmentPairlist(gradProvider);

    return Scaffold(
      endDrawer: AppDrawer(),
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: Column(
          children: [
            TopBar(),
            Container(
              height: h - topbarH,
              child: Stack(fit: StackFit.expand, children: const [
                GradientMainBox(),
                // if ((top + btm) / h < 0.89)
                ColorSliderBar(),
                // if ((left + right) / w < 0.94)
                GradientEditOptionsWidget(),
              ]),
            ),
          ],
        ));
  }

  Color pickedColor = Colors.amber;

  void loadImage() async {
    ByteData data = await rootBundle.load("assets/nature.jpg");

    defaultImageUint8List =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    pickedImageUint8List =
        Uint8List.fromList(defaultImageUint8List!.toList());
  }
}

showColorPicker(BuildContext context, Function fun, Color prevColor) async {
  log("showColorPicker $fun");
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: prevColor,
              onColorChanged: (color) {
                fun(color);
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                // setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
