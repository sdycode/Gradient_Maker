import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gradient_maker/global.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/aignmnet_pair.dart';
import 'package:provider/provider.dart';

double h = 800;
double w = 800;
double colorListBoxW = w * 0.18;
double colorListBoxH = h * 0.4;
double sliderWidth = w * 0.7;
double sliderActualWidthFactor = 0.96;
double sliderActualWidthFactorWithPadding = 0.96;
double gradeSelectBoxW = h * 0.1;
double demoBoxSizeW = h * 0.4;
double demoBoxSizeH = h * 0.4;

double textBoxSizeW = w * 0.16;
double textBoxSizeH = h * 0.4;
double imageBoxW = w * 0.2;
double alignOptionsBoxW = w * 0.7;
double alignOptionsBoxH = h * 0.16;
const double tileModeW = 36;
//  h * 0.1;
double colorSliderBarH = h * 0.05;
double pointRad = 12;
double preSliderWidth = w * 0.7;
double imageBoxH = h * 0.4;
const double sliderPad = 20;
const double slidersBoxH = 40;
double mainBoxH = h - topbarH - colorSliderBarH - slidersBoxH;
double totalH = demoBoxSizeH + pointRad * 2;
double textBoxH = totalH * 0.18;
void main() {
  runApp(const MyApp());
}

int randomNo = 0;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    randomNo = Random().nextInt(colorsPairs.length );

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => GradProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gradient Maker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Builder(builder: (context) {
            w = MediaQuery.of(context).size.width;
            h = MediaQuery.of(context).size.height;

            colorSliderBarH = h * 0.05;
            colorListBoxW = tileModeW * 4 + 4 * (5 * 2);
            colorListBoxH = h * 0.6;
            double leftsideW = w - colorListBoxW;

            gradeSelectBoxW = h * 0.1;
            mainBoxH = h - topbarH - colorSliderBarH - slidersBoxH * 2 - 10;
            demoBoxSizeW = mainBoxH;
            demoBoxSizeH = mainBoxH;
            alignOptionsBoxW = w - colorListBoxW;
            alignOptionsBoxH = h * 0.1;

            pointRad = 12;
            sliderWidth = w - colorListBoxW - sliderPad;
            textBoxSizeW = leftsideW * 0.32;
            textBoxSizeH = h * 0.4;
            imageBoxH = leftsideW * 0.26;
            imageBoxW = leftsideW * 0.28;
            totalH = demoBoxSizeH + pointRad * 2;
            textBoxH = totalH * 0.3;
            GradProvider gradProvider = Provider.of(context, listen: false);
            gradProvider.resizeColorSliderPositions();
            preSliderWidth = w - colorListBoxW - sliderPad;
            gradProvider.updateLinearPointForSelectedAlignment(
              gradProvider.originalAlignmentPair,
            );
            return GradientCreator();
          })),
    );
  }
}
