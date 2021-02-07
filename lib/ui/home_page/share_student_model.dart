import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';

class ShareStudentModel {
  TextEditingController studentName = TextEditingController();
  TextEditingController studentPhone = TextEditingController();
  TextEditingController studentTC = TextEditingController();
  TextEditingController studentAge = TextEditingController();
  TextEditingController studentAddress = TextEditingController();
  TextEditingController studentClass = TextEditingController();
  TextEditingController explanation = TextEditingController();
}

Widget loadingIcon(BuildContext context) {
  return Center(
    child: Container(
      width: Constants.getWidth(context),
      height: Constants.getHeight(context),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xff0f3057)),
      child: LoadingBouncingGrid.square(
        size: 30,
        backgroundColor: Color(0xff8cfffb),
      ),
    ),
  );
}

Widget customAppBar(BuildContext context) {
  return Container(
    height: Constants.getHeight(context) * 0.13,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 30, left: 20),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )),
      ],
    ),
  );
}

Widget userInput(_controller, text, textInputType, length) {
  return Padding(
    padding: EdgeInsets.only(top: 10.0),
    child: TextFormField(
      controller: _controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      cursorColor: ColorTable.swatch6,
      autofocus: false,
      keyboardType: textInputType,
      style: TextStyle(fontSize: 15.0, color: ColorTable.swatch6),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: Color(0xff435189)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
