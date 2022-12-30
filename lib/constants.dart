


import 'package:flutter/material.dart';
import 'package:gradient_maker/aignmnet_pair.dart';

const Color sliderBarColor = Color.fromARGB(255, 30, 16, 85);

class ColorStopModel {
  double colorStop;
  String hexColorString;
  double left;
  ColorStopModel(this.colorStop, this.hexColorString, this.left);
  ColorStopModel.withStopValue(this.colorStop,
      [this.hexColorString = "ffffffff", this.left = 0]);
  factory ColorStopModel.copy(ColorStopModel model) {
    return ColorStopModel(model.colorStop, model.hexColorString, model.left);
  }
}
List<AlignmentPair> alignmentPairList = [];


String commonSeparator ='__';
class C {



        static String appsharelink =
      'https://play.google.com/store/apps/details?id=com.sdyapps22.flutternotes';
  static String playstorelink =
      'https://play.google.com/store/apps/developer?id=Shubham+Yeole';
  static String linkedinlink =
      'https://www.linkedin.com/in/shubham-yeole-344307109/';
  static String youtubevideolink =
      "https://www.youtube.com/watch?v=SjwGtnPkjEw";
static String gitlink ="https://github.com/sdycode/Notes-App";

  static Color titleColor = Colors.pink;
  
  static String noTitlenoNotenoTag =
      'Please enter Title, Note & select Technology';
  static String noTitlenoNote = 'Please enter Title & Note';
  static String noTitlenoTag = 'Please enter Title & select Technology';
  static String noNotenoTag = 'Please enter Note & select Technology';
  static String noTag = 'Please select Technology';
  static SnackBar getSnackBar(String msg) {
    final snackBar = SnackBar(
      content:  Text(msg),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    return snackBar;
  }
}
