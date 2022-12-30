import 'package:flutter/material.dart';
import 'package:gradient_maker/function/getGradient.dart';
import 'package:gradient_maker/global.dart';
import 'package:gradient_maker/main.dart';
import 'package:gradient_maker/styles/textStyles.dart';
import 'package:provider/provider.dart';

import '../gradprovder.dart';

class BlendModesInGridForm extends StatelessWidget {
  const BlendModesInGridForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {  double gridBoxSize = colorListBoxW * 0.5 - (4 * 4);
    ScrollController gridScrollController = ScrollController(initialScrollOffset:gridBoxSize * 7, );
  
    GradProvider gradProvider = Provider.of(
      context,
    );
    return Container(
      width: colorListBoxW,
      color: Colors.black,
      child: ExpansionTile(
        title: Text(
          "BlendModes",
          style: TextStyle(color: Colors.white),
        ),
        iconColor: Colors.white,
        collapsedTextColor: Colors.white,
        collapsedIconColor: Colors.white,
        children: [
          Container(
            width: colorListBoxW,
            height: 30,
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 70, 68, 68),
                borderRadius: BorderRadius.circular(30)),
            child: InkWell(
                onTap: () {
                  selectedBlendModeOption = 13;
                  if(gridScrollController.hasClients){
    gridScrollController.animateTo(gridBoxSize * 7,
                      duration: Duration(seconds: 1), curve: Curves.decelerate);
                  }
              
                  gradProvider.updateUi();
                },
                child: Center(
                  child: Text(
                    "Reset",
                    style: whiteText.copyWith(fontSize: 20),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: h * 0.46,
            width: double.infinity,
            child: GridView.builder(
                controller: gridScrollController,
                itemCount: BlendMode.values.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.9, crossAxisCount: 2),
                itemBuilder: (c, i) {
                  return InkWell(
                    onTap: () {
                      selectedBlendModeOption = i;

                      gradProvider.updateUi();
                    },
                    child: Container(
                        width: double.infinity,
                        // color: Colors.primaries[i % Colors.primaries.length],
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(4),
                              width: gridBoxSize,
                              height: gridBoxSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.amber.shade100,
                                border: Border.all(
                                    color: Colors.white,
                                    width:
                                        selectedBlendModeOption == i ? 5 : 0.1),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: ShaderMask(
                                    blendMode: BlendMode.values[i],
                                    shaderCallback: (Rect rect) {
                                      return getGradientForTileMode(
                                              gradProvider.selectedTileMode,
                                              GradientType.values.indexOf(
                                                  gradProvider.gradientType),
                                              gradProvider)
                                          .createShader(rect);
                                    },
                                    child: Image.network(
                                      "https://raw.githubusercontent.com/sdycode/Gradient_Maker/main/assets/nature.jpg",
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Text(
                              BlendMode.values[i].name,
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
