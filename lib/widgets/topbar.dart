import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/global.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/styles/textStyles.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    controller.repeat();
  }
final  topbarColor = Color.fromARGB(255, 226, 243, 245);
  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider = Provider.of(
      context,
    );
    return Container(
        color: topbarColor,
        width: w,
        height: topbarH,
        child: Row(
          children: [
            const Spacer(),
            SizedBox(
              width: 8,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                // color:topbarColor,
                 borderRadius: BorderRadius.circular(30.0),
                //  boxShadow: [BoxShadow(color: Colors.blue, spreadRadius: 1, blurRadius: 3, offset: Offset(0,0))]
              ),
              child: TextButton.icon(
                  // style: ButtonStyle(
                  //   shadowColor:MaterialStateProperty.all(Colors.orange) ,
                  //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30.0),
                  //         side: BorderSide(
                        
                  //         )))),
                  onPressed: () async {
                    html.window.open(
                        'https://www.youtube.com/watch?v=jHOHo_xu9f4', "_blank");
                  },
                  icon: Container(
                      height: topbarH * 0.8,
                      child: Image.asset(
                        "assets/youtube.png",
                        fit: BoxFit.contain,
                      )),
                  label: const Text(
                    "Tutorial",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )),
            ),
            SizedBox(
              width: 8,
            ),
            TextButton.icon(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide()))),
                onPressed: () async {
                  showCodeInDialog(gradProvider, context);
                },
                icon: Container(
                    height: topbarH * 0.8,
                    child: const Icon(Icons.data_object, color: Colors.black)),
                label: const Text(
                  "Get Code",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )),
            IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openEndDrawer();
                },
                icon: Icon(Icons.menu)),
            SizedBox(
              width: 8,
            ),
          ],
        )

        // Text(
        //     "w : h  : ${w} / $h /  ${(w / h).toDouble().toStringAsFixed(2)}"),
        );
  }

  void showCodeInDialog(GradProvider gradProvider, BuildContext context) async {
    String containerCode = getGradientForTileMode(
            gradProvider.selectedTileMode,
            GradientType.values.indexOf(gradProvider.gradientType),
            gradProvider)
        .toString();
    String textCode = '''
ShaderMask(
            blendMode:${BlendMode.values[selectedBlendModeOption]},
            shaderCallback: ((bounds) {             
              return ${(getGradientForTileMode(gradProvider.selectedTileMode, GradientType.values.indexOf(gradProvider.gradientType), gradProvider))}
                  .createShader(bounds);
            }),
            child: Center(
              child: Text(
                "Gradient",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: textBoxSizeW * 0.22),
              ),
            )),''';

    String imageCode = '''
ShaderMask(
                  blendMode: ${BlendMode.values[selectedBlendModeOption]},
                  shaderCallback: (Rect rect) {
                    return ${getGradientForTileMode(gradProvider.selectedTileMode, GradientType.values.indexOf(gradProvider.gradientType), gradProvider)}
                        .createShader(rect);
                  },
                  child: Image.asset("imagePath")),''';

    String codeForAll = [containerCode, textCode, imageCode].join("\n");
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
          backgroundColor: Color.fromARGB(255, 238, 231, 231),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Spacer(),
                  // TextButton(
                  //     onPressed: () {
                  //       Clipboard.setData(ClipboardData(text: codeForAll));
                  //     },
                  //     child: Text(
                  //       "Copy All",
                  //       style: blackText.copyWith(fontSize: 18),
                  //     )),
                  IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.red,
                  ),
                ],
              ),
              Divider(),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    CopyButtonWithCodeTitle(
                      code: containerCode,
                      title: "Container",
                    ),
                    CodeSelectableTextBox(
                      code: containerCode,
                    ),
                    Divider(),
                    CopyButtonWithCodeTitle(
                      code: textCode,
                      title: "Text",
                    ),
                    CodeSelectableTextBox(
                      code: textCode,
                    ),
                    Divider(),
                    CopyButtonWithCodeTitle(
                      code: imageCode,
                      title: "Image",
                    ),
                    CodeSelectableTextBox(
                      code: imageCode,
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )),
              Container(
                // width: colorListBoxW,
                // height: 30,
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 6),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 4, 16, 38),
                    borderRadius: BorderRadius.circular(30)),
                child: InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: codeForAll));
                    },
                    child: Center(
                      child: Text(
                        "Copy All",
                        style: whiteText.copyWith(fontSize: 22),
                      ),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CopyButtonWithCodeTitle extends StatelessWidget {
  final String title;
  final String code;
  const CopyButtonWithCodeTitle({
    Key? key,
    required this.title,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(title, style: blackText.copyWith(fontSize: 18)),
          Spacer(),
          IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: code));
              },
              icon: const Icon(Icons.copy_all)),
        ],
      ),
    );
  }
}

class CodeSelectableTextBox extends StatelessWidget {
  final String code;
  const CodeSelectableTextBox({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      constraints: BoxConstraints(maxHeight: h * 0.7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
        color: Colors.black87,
      ),
      child: SingleChildScrollView(
        child: SelectableText(
          code,
          style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
        ),
      ),
    );
  }
}
