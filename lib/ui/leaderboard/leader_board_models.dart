import 'dart:ui';

import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget theFirstTree(context, number, imageUrl, size, username, point, icon, [positionLeft, positionRight, positionTop]) {
  return Positioned(
    left: positionLeft,
    top: positionTop,
    right: positionRight,
    child: Column(
      children: [
        Text(
          number,
          style: TextStyle(color: ColorTable.swatch1, fontSize: Constants.getWidth(context) * 0.05, fontFamily: 'Poppins'),
        ),
        Icon(
          icon,
          size: 20,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        ),
        imageWidget(imageUrl, size),
        SizedBox(
          height: Constants.getHeight(context) * 0.01,
        ),
        nameAndPoint(username, point, context)
      ],
    ),
  );
}

Widget nameAndPoint(username, point, context) {
  return Column(
    children: [
      Container(
        constraints: BoxConstraints(maxWidth: Constants.getWidth(context) * 0.17),
        child: Text(
          username,
          style: TextStyle(color: ColorTable.swatch1, fontSize: Constants.getWidth(context) * 0.03, fontFamily: 'Poppins'),
        ),
      ),
      Text(
        point,
        style: TextStyle(color: Colors.white, fontSize: Constants.getWidth(context) * 0.04, fontFamily: 'Poppins'),
      ),
    ],
  );
}

Widget imageWidget(imageUrl, size) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: size + 5.0,
        height: size + 5.0,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(size / 2)),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image.asset(
          imageUrl,
          height: size,
        ),
      ),
    ],
  );
}

Widget listViewContainer(BuildContext context, int index, name, point) {
  return Container(
    width: Constants.getWidth(context),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          listViewOrderHeader(index),
          SizedBox(
            width: 20,
          ),
          listViewInfoBody(context, name, point)
        ],
      ),
    ),
  );
}

Widget listViewOrderHeader(int index) {
  return Column(
    children: [
      Text(
        (index + 4).toString(),
        style: TextStyle(color: ColorTable.swatch1, fontSize: 17, fontFamily: 'Poppins'),
      ),
      Icon(
        FontAwesomeIcons.chevronUp,
        size: 20,
        color: Colors.white,
      ),
    ],
  );
}

Widget listViewInfoBody(BuildContext context, name, point) {
  return Container(
    height: 60,
    width: Constants.getWidth(context) * 0.75,
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.circular(30)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/top-rated.png',
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: TextStyle(color: ColorTable.swatch5, fontSize: Constants.getWidth(context) * 0.042),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            point,
            style: TextStyle(color: ColorTable.swatch5, fontSize: 17),
          ),
        ),
      ],
    ),
  );
}

Widget customAppBar(BuildContext context) {
  return Container(
    height: Constants.getHeight(context) * 0.15,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Liderlik Tablosu',
          style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Poppins'),
        ),
      ],
    ),
  );
}
