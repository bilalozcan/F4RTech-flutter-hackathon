import 'package:flutter/material.dart';

class Constants {

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}