import 'package:flutter/material.dart';
import 'package:gradient_maker/gradscreen.dart';
import 'package:gradient_maker/main.dart';

class ScrollButton extends StatelessWidget {
  final String dir;
  const ScrollButton(this.dir,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (dir) {
          case "left":
            if (linearGradOptionsController.offset - alignOptionsBoxH >=
                -alignOptionsBoxH) {
              linearGradOptionsController.animateTo(
                  linearGradOptionsController.offset - alignOptionsBoxH,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.decelerate);
            }
            break;
          case "right":
            if (linearGradOptionsController.offset + alignOptionsBoxH <
                linearGradOptionsController.position.maxScrollExtent +
                    alignOptionsBoxH) {
              linearGradOptionsController.animateTo(

                  // offset:
                  linearGradOptionsController.offset + alignOptionsBoxH,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.decelerate);
            }
            break;
          case "leftblend":
            if (blendmodeslListCOntroller.offset - alignOptionsBoxH >=
                -alignOptionsBoxH) {
              blendmodeslListCOntroller.animateTo(
                  blendmodeslListCOntroller.offset - alignOptionsBoxH,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.decelerate);
            }
            break;
          case "rightblend":
            if (blendmodeslListCOntroller.offset + alignOptionsBoxH <
                blendmodeslListCOntroller.position.maxScrollExtent +
                    alignOptionsBoxH) {
              blendmodeslListCOntroller.animateTo(

                  // offset:
                  blendmodeslListCOntroller.offset + alignOptionsBoxH,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.decelerate);
            }
            break;
          default:
        }
      },
      child: Container(
        height: alignOptionsBoxH,
        width: 40,
        // color: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 3),

        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: const [
                BoxShadow(
                    color: Colors.white,
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: Offset(0.2, 0.2))
              ],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey)),
          child: Center(
            child: Icon(
              dir.contains("left") ? Icons.arrow_left : Icons.arrow_right,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
