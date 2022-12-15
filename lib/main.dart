import 'dart:developer';

import 'package:flutter/material.dart';
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
double tileModeW = h * 0.1;
double pointRad = 12;
double preSliderWidth = w * 0.7;
double imageBoxH = h * 0.4;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => GradProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gradient Maker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Builder(builder: (context) {
            log("ccc bef dd $colorListBoxW / $demoBoxSizeW /$h");
            w = MediaQuery.of(context).size.width;
            h = MediaQuery.of(context).size.height;
            log("ccc dd $colorListBoxW / $demoBoxSizeW /$h");
            colorListBoxW = w * 0.18;
            colorListBoxH = h * 0.6;
            double leftsideW = w - (tileModeW * 4 + 20 * 4 + 30);

            gradeSelectBoxW = h * 0.1;
            demoBoxSizeW = leftsideW * 0.26;
            demoBoxSizeH = leftsideW * 0.26;
            alignOptionsBoxW = w - (tileModeW * 4 + 20 * 4 + 30);
            alignOptionsBoxH = h * 0.1;
            tileModeW = h * 0.1;
            pointRad = 12;
            sliderWidth = w - (tileModeW * 4 + 20 * 4 + 30);
            textBoxSizeW = leftsideW * 0.32;
            textBoxSizeH = h * 0.4;
            imageBoxH = leftsideW * 0.26;
            imageBoxW = leftsideW * 0.28;
            log("ccc dd after $colorListBoxW / $demoBoxSizeW");
            log("demoo demo ${w} / $h");
            GradProvider gradProvider = Provider.of(context, listen: false);
            gradProvider.resizeColorSliderPositions();
            preSliderWidth = w - (tileModeW * 4 + 20 * 4 + 30);
            gradProvider.updateLinearPointForSelectedAlignment(
              gradProvider.originalAlignmentPair,
            );
            return GradientCreator();
          })),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
