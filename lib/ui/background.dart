import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:flutter/material.dart';

Widget backgroundContainer(BuildContext context) {
  return Container(
    width: Constants.getWidth(context),
    height: Constants.getHeight(context),
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorTable.swatch2, ColorTable.swatch3])),
  );
}
