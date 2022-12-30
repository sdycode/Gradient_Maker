import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
// import 'package:universal_io/io.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/global.dart';
import 'package:gradient_maker/gradprovder.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/widgets/buttons/LightBorderElevatedButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class TextAndImageWithGradient extends StatelessWidget {
  const TextAndImageWithGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    imageBoxH = totalH * 0.8;
    return Container(
      // height: demoBoxSizeH + pointRad * 2,
      width: imageBoxW,
      child: Column(
        children: [TextBoxGrad(), ImageBox()],
      ),
    );
  }
}

// BoxFit imgBoxFit = BoxFit.cover;
int imgBoxFitNo = 0;

class ImageBox extends StatelessWidget {
  ImageBox({Key? key}) : super(key: key);
  late GradProvider gradProvider;
  final GlobalKey globalKey = GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    gradProvider = Provider.of(
      context,
    );

    // FilePickerCross? filePickerCross;
    return Container(
      width: imageBoxW,
      height: imageBoxH,
      // color: Colors.red,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 2, color: Colors.white)),
              width: imageBoxW,
              height: imageBoxH - 30 - 16,
              child: InkWell(
                onTap: () {
                  imgBoxFitNo++;
                  gradProvider.updateUi();
                },
                child: RepaintBoundary(
                  key: globalKey,
                  child: ShaderMask(
                    blendMode: BlendMode.values[selectedBlendModeOption],
                    shaderCallback: (Rect rect) {
                      return getGradientForTileMode(
                              gradProvider.selectedTileMode,
                              GradientType.values
                                  .indexOf(gradProvider.gradientType),
                              gradProvider)
                          .createShader(rect);
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            //  true
                            //     ? Image.asset("assets/youtube.png")
                            //     :
                            pickedImageUint8List != null
                                ? Image.memory(
                                    pickedImageUint8List!,
                                    fit: BoxFit.values[
                                        imgBoxFitNo % BoxFit.values.length],
                                  )
                                : Image.network(
                                    "https://raw.githubusercontent.com/sdycode/Gradient_Maker/main/assets/nature.jpg",
                                    // "https://github.com/sdycode/Gradient_Maker/blob/main/assets/nature.jpg?raw=true",
                                    // "nature.jpg",
                                    fit: BoxFit.values[
                                        imgBoxFitNo % BoxFit.values.length],
                                  )),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.all(8),
            // color: Colors.red,
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LightBorderElevatedButton(
                    buttonName: "Change Image",
                    onTap: () async {
                      ImagePicker _picker = ImagePicker();
                      XFile? pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        pickedImageUint8List = await pickedFile.readAsBytes();
                        gradProvider.updateUi();
                      }
                    },
                  ),
                  LightBorderElevatedButton(
                    buttonName: "Reset",
                    onTap: () {
                      pickedImageUint8List =
                          Uint8List.fromList(defaultImageUint8List!.toList());
                      gradProvider.updateUi();
                    },
                  ),
                  LightBorderElevatedButton(
                    buttonName: "Save Image",
                    onTap: () async {
                      try {
                        if (kIsWeb) {
                          final img = await captureWidget();
            
                          await FileSaver.instance.saveFile(
                              "GradientImage", img, ".png",
                              mimeType: MimeType.PNG);
                        }
                      } catch (e) {
                        log("dirpath ee ${e}");
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<Uint8List> captureWidget() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage();

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    return pngBytes;
  }

  ImageWithGradientForImage() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 2, color: Colors.white)),
        width: imageBoxW,
        height: imageBoxH - 30 - 16,
        // height: double.infinity,
        child: ShaderMask(
          blendMode: BlendMode.values[selectedBlendModeOption],
          shaderCallback: (Rect rect) {
            return getGradientForTileMode(
                    gradProvider.selectedTileMode,
                    GradientType.values.indexOf(gradProvider.gradientType),
                    gradProvider)
                .createShader(rect);
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: pickedImageUint8List != null
                  ? Image.memory(
                      pickedImageUint8List!,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "https://raw.githubusercontent.com/sdycode/Gradient_Maker/main/assets/nature.jpg",
                      // "https://github.com/sdycode/Gradient_Maker/blob/main/assets/nature.jpg?raw=true",
                      // "nature.jpg",
                      fit: BoxFit.cover,
                    )),
        ));
  }
}

class TextBoxGrad extends StatelessWidget {
  const TextBoxGrad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider = Provider.of(
      context,
    );
    textBoxH = totalH * 0.2;
    return Container(
      width: imageBoxW,
      height: textBoxH - 16,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ShaderMask(
            blendMode: BlendMode.values[selectedBlendModeOption],
            shaderCallback: ((bounds) {
              return getGradientForTileMode(
                      gradProvider.selectedTileMode,
                      GradientType.values.indexOf(gradProvider.gradientType),
                      gradProvider)
                  .createShader(bounds);
            }),
            child: FittedBox(
              child: Text(
                "Gradient",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // fontSize: textBoxSizeW * 0.22
                ),
              ),
            )),
      ),
    );
  }
}
