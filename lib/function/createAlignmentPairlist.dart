
  import 'package:flutter/material.dart';
import 'package:gradient_maker/aignmnet_pair.dart';
import 'package:gradient_maker/constants.dart';
import 'package:gradient_maker/gradprovder.dart';

void createAlignmentPairlist(GradProvider gradProvider) {
    alignmentPairList = [
      AlignmentPair(
        gradProvider.originalAlignmentPair.start,
        gradProvider.originalAlignmentPair.end,
      ),
      AlignmentPair(
        Alignment.centerLeft,
        Alignment.centerRight,
      ),
      AlignmentPair(
        Alignment.topCenter,
        Alignment.bottomCenter,
      ),
      AlignmentPair(
        Alignment.topLeft,
        Alignment.bottomRight,
      ),
      AlignmentPair(
        Alignment.bottomLeft,
        Alignment.topRight,
      ),
      AlignmentPair(
        Alignment.centerLeft,
        Alignment.topRight,
      ),
      AlignmentPair(
        Alignment.centerRight,
        Alignment.topLeft,
      ),
      AlignmentPair(
        Alignment.centerLeft,
        Alignment.bottomRight,
      ),
      AlignmentPair(
        Alignment.centerRight,
        Alignment.bottomLeft,
      ),
    ];
  }
